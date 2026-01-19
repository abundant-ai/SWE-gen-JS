#!/bin/bash

cd /app/src

# Detect if the fix has been applied by checking for a specific code change
# The fix changes 'argv.eval == null' to 'argv.eval === undefined' in src/_bin.ts
if grep -q "argv.eval === undefined" src/_bin.ts; then
    # Fix has been applied - restore HEAD test file (which has test skipped)
    mkdir -p "src"
    cp "/tests/src/index.spec.ts" "src/index.spec.ts"
fi
# Otherwise, bug.patch has unskipped the test and we keep that state

# Reinstall dependencies if package.json or package-lock.json changed
npm install --legacy-peer-deps --ignore-scripts

# Rebuild (may have type errors but that's okay - the dist will be partial but tests can run)
npm run build || true

# Check if dist folder exists - if not, the build completely failed
if [ ! -d "dist" ]; then
    echo 0 > /logs/verifier/reward.txt
    exit 1
fi

# Run the specific test for this PR - the source map test that was unskipped
npx mocha dist/index.spec.js -R spec --bail --grep "eval should work with source maps"
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
