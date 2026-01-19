#!/bin/bash

cd /app/bluebird

# Build the project (build happens at test time to avoid Docker build timeout)
node tools/build.js --no-debug --release || {
    echo "Build failed, exiting"
    exit 1
}

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test/mocha"
cp "/tests/mocha/tapCatch.js" "test/mocha/tapCatch.js"

# Create a setup file to load built bluebird as global Promise
cat > /tmp/mocha-setup.js <<'EOF'
global.Promise = require('/app/bluebird/js/release/bluebird.js');
EOF

# Run the test with mocha, loading the setup file first
node ./node_modules/mocha/bin/_mocha --require /tmp/mocha-setup.js test/mocha/tapCatch.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
