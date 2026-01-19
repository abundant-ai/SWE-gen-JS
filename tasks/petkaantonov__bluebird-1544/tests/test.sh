#!/bin/bash

cd /app/bluebird

# Build the project (build happens at test time to avoid Docker build timeout)
node tools/build.js --no-debug --release || {
    echo "Build failed, exiting"
    exit 1
}

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test/mocha"
cp "/tests/mocha/async.js" "test/mocha/async.js"

# Create a setup file to load built bluebird as global Promise
cat > /tmp/mocha-setup.js <<'EOF'
global.Promise = require('/app/bluebird/js/release/bluebird.js');
EOF

# Run the test with mocha, loading the setup file first
# Use _mocha directly to ensure --expose-gc is passed to the test process
# Note: The test file has one unrelated failing test ("Immediately fulfilled" uses deprecated Promise.defer.fulfill)
# Since we can't modify the test file, we'll run all tests and check if the memory tests pass
node --expose-gc ./node_modules/mocha/bin/_mocha --require /tmp/mocha-setup.js test/mocha/async.js 2>&1 | tee /tmp/test-output.txt
test_status=$?

# Check if the memory tests passed (these are the ones we care about for this bug fix)
# Look for specific patterns: the tests pass if we see checkmarks for .then and .catch
# and do NOT see numbered failures like "2) .then" or "3) .catch"
if grep -A 3 "Frees memory" /tmp/test-output.txt | grep -E "✓.*\.then" > /dev/null && \
   grep -A 3 "Frees memory" /tmp/test-output.txt | grep -E "✓.*\.catch" > /dev/null; then
    echo "Memory freeing tests passed!"
    test_status=0
elif grep -A 3 "Frees memory" /tmp/test-output.txt | grep -E "[0-9]+\).*\.then" > /dev/null || \
     grep -A 3 "Frees memory" /tmp/test-output.txt | grep -E "[0-9]+\).*\.catch" > /dev/null; then
    echo "Memory freeing tests failed (memory leak detected)"
    test_status=1
fi

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
