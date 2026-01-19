#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/react-query/src/__tests__"
cp "/tests/packages/react-query/src/__tests__/useSuspenseQuery.test.tsx" "packages/react-query/src/__tests__/useSuspenseQuery.test.tsx"

# Run vitest from react-query package directory
cd /app/src/packages/react-query
npx vitest run src/__tests__/useSuspenseQuery.test.tsx --no-coverage
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
