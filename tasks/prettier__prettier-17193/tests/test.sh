#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/format/js/binary-expressions/mutiple-comments"
cp "/tests/format/js/binary-expressions/mutiple-comments/17192.js" "tests/format/js/binary-expressions/mutiple-comments/17192.js"
mkdir -p "tests/format/js/binary-expressions/mutiple-comments/__snapshots__"
cp "/tests/format/js/binary-expressions/mutiple-comments/__snapshots__/format.test.js.snap" "tests/format/js/binary-expressions/mutiple-comments/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/js/binary-expressions/mutiple-comments"
cp "/tests/format/js/binary-expressions/mutiple-comments/format.test.js" "tests/format/js/binary-expressions/mutiple-comments/format.test.js"
mkdir -p "tests/format/js/logical-expressions/__snapshots__"
cp "/tests/format/js/logical-expressions/__snapshots__/format.test.js.snap" "tests/format/js/logical-expressions/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/js/logical-expressions"
cp "/tests/format/js/logical-expressions/format.test.js" "tests/format/js/logical-expressions/format.test.js"
mkdir -p "tests/format/js/logical-expressions"
cp "/tests/format/js/logical-expressions/issue-7024.js" "tests/format/js/logical-expressions/issue-7024.js"
mkdir -p "tests/format/js/logical-expressions"
cp "/tests/format/js/logical-expressions/logical-expression-operators.js" "tests/format/js/logical-expressions/logical-expression-operators.js"
mkdir -p "tests/format/js/logical-expressions/multiple-comments"
cp "/tests/format/js/logical-expressions/multiple-comments/17192.js" "tests/format/js/logical-expressions/multiple-comments/17192.js"
mkdir -p "tests/format/js/logical-expressions/multiple-comments/__snapshots__"
cp "/tests/format/js/logical-expressions/multiple-comments/__snapshots__/format.test.js.snap" "tests/format/js/logical-expressions/multiple-comments/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/js/logical-expressions/multiple-comments"
cp "/tests/format/js/logical-expressions/multiple-comments/format.test.js" "tests/format/js/logical-expressions/multiple-comments/format.test.js"
mkdir -p "tests/format/typescript/intersection/mutiple-comments"
cp "/tests/format/typescript/intersection/mutiple-comments/17192.ts" "tests/format/typescript/intersection/mutiple-comments/17192.ts"
mkdir -p "tests/format/typescript/intersection/mutiple-comments/__snapshots__"
cp "/tests/format/typescript/intersection/mutiple-comments/__snapshots__/format.test.js.snap" "tests/format/typescript/intersection/mutiple-comments/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/typescript/intersection/mutiple-comments"
cp "/tests/format/typescript/intersection/mutiple-comments/format.test.js" "tests/format/typescript/intersection/mutiple-comments/format.test.js"

# Run the specific tests for this PR
npx jest tests/format/js/binary-expressions/mutiple-comments tests/format/js/logical-expressions tests/format/typescript/intersection/mutiple-comments --coverage=false --runInBand
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
