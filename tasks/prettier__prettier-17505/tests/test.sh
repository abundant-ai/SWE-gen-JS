#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/integration/__tests__/__snapshots__"
cp "/tests/integration/__tests__/__snapshots__/infer-parser.js.snap" "tests/integration/__tests__/__snapshots__/infer-parser.js.snap"
mkdir -p "tests/integration/__tests__/__snapshots__"
cp "/tests/integration/__tests__/__snapshots__/line-after-filepath-with-errors.js.snap" "tests/integration/__tests__/__snapshots__/line-after-filepath-with-errors.js.snap"
mkdir -p "tests/integration/__tests__"
cp "/tests/integration/__tests__/infer-parser.js" "tests/integration/__tests__/infer-parser.js"
mkdir -p "tests/integration/__tests__"
cp "/tests/integration/__tests__/patterns-dirs.js" "tests/integration/__tests__/patterns-dirs.js"

# Run the specific tests for this PR
npx jest tests/integration/__tests__/infer-parser.js tests/integration/__tests__/patterns-dirs.js --coverage=false --runInBand
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
