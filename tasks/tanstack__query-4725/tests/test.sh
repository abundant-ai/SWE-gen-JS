#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/eslint-plugin-query/src/rules/exhaustive-deps"
cp "/tests/packages/eslint-plugin-query/src/rules/exhaustive-deps/exhaustive-deps.test.ts" "packages/eslint-plugin-query/src/rules/exhaustive-deps/exhaustive-deps.test.ts"

# Run the specific test file with jest (disable coverage)
cd /app/src/packages/eslint-plugin-query
NODE_OPTIONS="--max-old-space-size=2048" npx jest src/rules/exhaustive-deps/exhaustive-deps.test.ts --coverage=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
