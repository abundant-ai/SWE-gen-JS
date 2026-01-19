#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/lib"
cp "/tests/lib/cli.js" "tests/lib/cli.js"
mkdir -p "tests/lib/eslint"
cp "/tests/lib/eslint/flat-eslint.js" "tests/lib/eslint/flat-eslint.js"
mkdir -p "tests/lib"
cp "/tests/lib/unsupported-api.js" "tests/lib/unsupported-api.js"

# Run only the shouldUseFlatConfig tests to avoid pre-existing failures
npx mocha tests/lib/eslint/flat-eslint.js --grep "shouldUseFlatConfig"
shouldUseFlatConfig_status=$?

# Run the unsupported-api tests to verify the export
npx mocha tests/lib/unsupported-api.js
unsupported_api_status=$?

# Both must pass
test_status=$((shouldUseFlatConfig_status || unsupported_api_status))

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
