#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "src/__tests__/useForm"
cp "/tests/src/__tests__/useForm/reset.test.tsx" "src/__tests__/useForm/reset.test.tsx"

# Run tests with Jest (--runInBand to avoid OOM kills)
pnpm test -- src/__tests__/useForm/reset.test.tsx --coverage=false --runInBand
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
