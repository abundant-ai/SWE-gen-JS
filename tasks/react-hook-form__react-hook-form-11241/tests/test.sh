#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "src/__tests__"
cp "/tests/src/__tests__/useForm.test.tsx" "src/__tests__/useForm.test.tsx"

# Run Jest tests using the project's Jest config with specific test files
npx jest --config ./scripts/jest/jest.config.js src/__tests__/useForm.test.tsx --coverage=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
