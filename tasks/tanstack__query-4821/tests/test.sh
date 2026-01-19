#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/react-query/src/__tests__"
cp "/tests/packages/react-query/src/__tests__/HydrationBoundary.test.tsx" "packages/react-query/src/__tests__/HydrationBoundary.test.tsx"

# Run the specific test file with jest (disable coverage)
cd /app/src/packages/react-query
NODE_OPTIONS="--max-old-space-size=2048" npx jest src/__tests__/HydrationBoundary.test.tsx --coverage=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
