#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "src/__tests__"
cp "/tests/src/__tests__/controller.test.tsx" "src/__tests__/controller.test.tsx"
mkdir -p "src/__tests__"
cp "/tests/src/__tests__/useFieldArray.test.tsx" "src/__tests__/useFieldArray.test.tsx"
mkdir -p "src/__tests__/useForm"
cp "/tests/src/__tests__/useForm/register.test.tsx" "src/__tests__/useForm/register.test.tsx"

# This PR is about TypeScript types - need to verify types compile correctly
# Run TypeScript type checking on the test files (which import WatchedForm type)
# Use project-compatible settings from tsconfig.json
npx tsc --noEmit --skipLibCheck --strict \
  --jsx react \
  --esModuleInterop \
  --module es2015 \
  --target es2018 \
  --moduleResolution node \
  --lib dom,dom.iterable,esnext \
  --noUnusedLocals false \
  --noUnusedParameters false \
  --noImplicitReturns false \
  src/__tests__/controller.test.tsx \
  src/__tests__/useFieldArray.test.tsx \
  src/__tests__/useForm/register.test.tsx
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
