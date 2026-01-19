#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "src/__tests__"
cp "/tests/src/__tests__/type.test.tsx" "src/__tests__/type.test.tsx"
cp "/tests/src/__tests__/useWatch.test.tsx" "src/__tests__/useWatch.test.tsx"

# Run specific test files with Jest (disable coverage to avoid thresholds)
pnpm test -- src/__tests__/type.test.tsx src/__tests__/useWatch.test.tsx --coverage=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
