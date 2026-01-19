#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/react-query/src/__tests__"
cp "/tests/packages/react-query/src/__tests__/useQuery.test.tsx" "packages/react-query/src/__tests__/useQuery.test.tsx"

# Run the specific test file using jest (the project's test runner)
cd /app/src/packages/react-query
npx jest src/__tests__/useQuery.test.tsx --coverage=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
