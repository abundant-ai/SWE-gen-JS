#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/query-core/src/tests"
cp "/tests/packages/query-core/src/tests/queryClient.test.tsx" "packages/query-core/src/tests/queryClient.test.tsx"

# Run the specific test file with jest (disable coverage)
cd /app/src/packages/query-core
NODE_OPTIONS="--max-old-space-size=2048" npx jest src/tests/queryClient.test.tsx --coverage=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
