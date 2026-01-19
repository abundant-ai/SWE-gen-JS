#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/format/flow-repo/missing_annotation/__snapshots__"
cp "/tests/format/flow-repo/missing_annotation/__snapshots__/format.test.js.snap" "tests/format/flow-repo/missing_annotation/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/flow-repo/optional/__snapshots__"
cp "/tests/format/flow-repo/optional/__snapshots__/format.test.js.snap" "tests/format/flow-repo/optional/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/js/comments/__snapshots__"
cp "/tests/format/js/comments/__snapshots__/format.test.js.snap" "tests/format/js/comments/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/js/identifier/parentheses/__snapshots__"
cp "/tests/format/js/identifier/parentheses/__snapshots__/format.test.js.snap" "tests/format/js/identifier/parentheses/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/js/no-semi/__snapshots__"
cp "/tests/format/js/no-semi/__snapshots__/format.test.js.snap" "tests/format/js/no-semi/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/js/objects/__snapshots__"
cp "/tests/format/js/objects/__snapshots__/format.test.js.snap" "tests/format/js/objects/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/js/reserved-word/__snapshots__"
cp "/tests/format/js/reserved-word/__snapshots__/format.test.js.snap" "tests/format/js/reserved-word/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/js/sequence-break/__snapshots__"
cp "/tests/format/js/sequence-break/__snapshots__/format.test.js.snap" "tests/format/js/sequence-break/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/js/sequence-break"
cp "/tests/format/js/sequence-break/break.js" "tests/format/js/sequence-break/break.js"
mkdir -p "tests/format/js/sequence-expression/__snapshots__"
cp "/tests/format/js/sequence-expression/__snapshots__/format.test.js.snap" "tests/format/js/sequence-expression/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/js/sequence-expression"
cp "/tests/format/js/sequence-expression/expression.js" "tests/format/js/sequence-expression/expression.js"
mkdir -p "tests/format/js/sequence-expression/no-semi/__snapshots__"
cp "/tests/format/js/sequence-expression/no-semi/__snapshots__/format.test.js.snap" "tests/format/js/sequence-expression/no-semi/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/js/sequence-expression/no-semi"
cp "/tests/format/js/sequence-expression/no-semi/expression.js" "tests/format/js/sequence-expression/no-semi/expression.js"
mkdir -p "tests/format/js/sequence-expression/no-semi"
cp "/tests/format/js/sequence-expression/no-semi/format.test.js" "tests/format/js/sequence-expression/no-semi/format.test.js"
mkdir -p "tests/format/js/sequence-expression"
cp "/tests/format/js/sequence-expression/return.js" "tests/format/js/sequence-expression/return.js"
mkdir -p "tests/format/js/strings/__snapshots__"
cp "/tests/format/js/strings/__snapshots__/format.test.js.snap" "tests/format/js/strings/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/jsx/jsx/__snapshots__"
cp "/tests/format/jsx/jsx/__snapshots__/format.test.js.snap" "tests/format/jsx/jsx/__snapshots__/format.test.js.snap"

# Run the specific tests for this PR
npx jest tests/format/flow-repo/missing_annotation tests/format/flow-repo/optional tests/format/js/comments tests/format/js/identifier/parentheses tests/format/js/no-semi tests/format/js/objects tests/format/js/reserved-word tests/format/js/sequence-break tests/format/js/sequence-expression tests/format/js/strings tests/format/jsx/jsx --coverage=false --runInBand
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
