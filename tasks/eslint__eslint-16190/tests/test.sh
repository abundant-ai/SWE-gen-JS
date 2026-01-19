#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/lib/config"
cp "/tests/lib/config/flat-config-array.js" "tests/lib/config/flat-config-array.js"
mkdir -p "tests/lib/eslint"
cp "/tests/lib/eslint/flat-eslint.js" "tests/lib/eslint/flat-eslint.js"

# Run only the specific tests that were added/modified in this PR
# Using --grep to match the exact test descriptions that were added
npx mocha tests/lib/config/flat-config-array.js --grep "should convert config into normalized JSON object|should throw an error when config with parser object is normalized|should throw an error when config with processor object is normalized"
config_status=$?

npx mocha tests/lib/eslint/flat-eslint.js --grep "should run autofix even if files are cached without autofix results|should invalidate the cache if the overrideConfig changed between executions"
eslint_status=$?

# Overall test status: pass only if both test runs passed
if [ $config_status -eq 0 ] && [ $eslint_status -eq 0 ]; then
    test_status=0
else
    test_status=1
fi

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
