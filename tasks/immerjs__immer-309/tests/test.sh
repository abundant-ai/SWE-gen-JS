#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "__tests__"
cp "/tests/base.js" "__tests__/base.js"
mkdir -p "__tests__"
cp "/tests/curry.js" "__tests__/curry.js"
mkdir -p "__tests__"
cp "/tests/draft.ts" "__tests__/draft.ts"
mkdir -p "__tests__"
cp "/tests/immutable.ts" "__tests__/immutable.ts"
mkdir -p "__tests__"
cp "/tests/produce.ts" "__tests__/produce.ts"
mkdir -p "__tests__"
cp "/tests/readme.js" "__tests__/readme.js"

# Run Jest on the specific test files from this PR
yarn jest __tests__/base.js __tests__/curry.js __tests__/draft.ts __tests__/immutable.ts __tests__/produce.ts __tests__/readme.js --coverage=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
