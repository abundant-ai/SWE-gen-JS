#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "src/__tests__"
cp "/tests/src/__tests__/controller.test.tsx" "src/__tests__/controller.test.tsx"
cp "/tests/src/__tests__/form.test.tsx" "src/__tests__/form.test.tsx"
mkdir -p "src/__tests__/useForm"
cp "/tests/src/__tests__/useForm/resolver.test.tsx" "src/__tests__/useForm/resolver.test.tsx"
mkdir -p "src/__tests__/useFieldArray"
cp "/tests/src/__tests__/useFieldArray/replace.test.tsx" "src/__tests__/useFieldArray/replace.test.tsx"

# Run tests with Jest (--runInBand to avoid OOM kills)
pnpm test -- src/__tests__/controller.test.tsx src/__tests__/form.test.tsx src/__tests__/useForm/resolver.test.tsx src/__tests__/useFieldArray/replace.test.tsx --coverage=false --runInBand
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
