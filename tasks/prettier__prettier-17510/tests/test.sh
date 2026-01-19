#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/config"
cp "/tests/config/run-format-test.js" "tests/config/run-format-test.js"
mkdir -p "tests/format/js/comments/__snapshots__"
cp "/tests/format/js/comments/__snapshots__/format.test.js.snap" "tests/format/js/comments/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/js/comments"
cp "/tests/format/js/comments/tagged-template-literal.js" "tests/format/js/comments/tagged-template-literal.js"
mkdir -p "tests/format/js/comments/tagged-template-literal"
cp "/tests/format/js/comments/tagged-template-literal/11662.js" "tests/format/js/comments/tagged-template-literal/11662.js"
mkdir -p "tests/format/js/comments/tagged-template-literal/__snapshots__"
cp "/tests/format/js/comments/tagged-template-literal/__snapshots__/format.test.js.snap" "tests/format/js/comments/tagged-template-literal/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/js/comments/tagged-template-literal"
cp "/tests/format/js/comments/tagged-template-literal/format.test.js" "tests/format/js/comments/tagged-template-literal/format.test.js"
mkdir -p "tests/format/typescript/comments"
cp "/tests/format/typescript/comments/11662.ts" "tests/format/typescript/comments/11662.ts"
mkdir -p "tests/format/typescript/comments/__snapshots__"
cp "/tests/format/typescript/comments/__snapshots__/format.test.js.snap" "tests/format/typescript/comments/__snapshots__/format.test.js.snap"

# Run the specific tests for this PR
npx jest tests/format/js/comments/tagged-template-literal/format.test.js tests/format/typescript/comments/ --coverage=false --runInBand
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
