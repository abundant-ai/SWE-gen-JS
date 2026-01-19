#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/format/js/comments/__snapshots__"
cp "/tests/format/js/comments/__snapshots__/format.test.js.snap" "tests/format/js/comments/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/js/logical-expressions/__snapshots__"
cp "/tests/format/js/logical-expressions/__snapshots__/format.test.js.snap" "tests/format/js/logical-expressions/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/js/logical-expressions"
cp "/tests/format/js/logical-expressions/in-unary-expression.js" "tests/format/js/logical-expressions/in-unary-expression.js"
mkdir -p "tests/format/js/unary-expression/__snapshots__"
cp "/tests/format/js/unary-expression/__snapshots__/format.test.js.snap" "tests/format/js/unary-expression/__snapshots__/format.test.js.snap"

# Run the specific test files for js formatting (comments, logical-expressions, unary-expression)
# Use --runInBand to avoid parallel execution and memory issues
npx jest tests/format/js/comments/format.test.js tests/format/js/logical-expressions/format.test.js tests/format/js/unary-expression/format.test.js --coverage=false --runInBand
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
