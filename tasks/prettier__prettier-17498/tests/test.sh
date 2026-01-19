#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/format/html/multiparser/ts/__snapshots__"
cp "/tests/format/html/multiparser/ts/__snapshots__/format.test.js.snap" "tests/format/html/multiparser/ts/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/typescript/comments/__snapshots__"
cp "/tests/format/typescript/comments/__snapshots__/format.test.js.snap" "tests/format/typescript/comments/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/typescript/comments"
cp "/tests/format/typescript/comments/mapped_types.ts" "tests/format/typescript/comments/mapped_types.ts"
mkdir -p "tests/format/typescript/mapped-type/__snapshots__"
cp "/tests/format/typescript/mapped-type/__snapshots__/format.test.js.snap" "tests/format/typescript/mapped-type/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/typescript/mapped-type/break-mode/__snapshots__"
cp "/tests/format/typescript/mapped-type/break-mode/__snapshots__/format.test.js.snap" "tests/format/typescript/mapped-type/break-mode/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/typescript/mapped-type/break-mode"
cp "/tests/format/typescript/mapped-type/break-mode/break-mode.ts" "tests/format/typescript/mapped-type/break-mode/break-mode.ts"
mkdir -p "tests/format/typescript/mapped-type/break-mode"
cp "/tests/format/typescript/mapped-type/break-mode/issue-10571.ts" "tests/format/typescript/mapped-type/break-mode/issue-10571.ts"
mkdir -p "tests/format/typescript/prettier-ignore/__snapshots__"
cp "/tests/format/typescript/prettier-ignore/__snapshots__/format.test.js.snap" "tests/format/typescript/prettier-ignore/__snapshots__/format.test.js.snap"
mkdir -p "tests/unit/__snapshots__"
cp "/tests/unit/__snapshots__/visitor-keys.js.snap" "tests/unit/__snapshots__/visitor-keys.js.snap"

# Run the specific tests for this PR
# Testing format tests for HTML multiparser TypeScript, TypeScript comments, mapped types, and visitor keys
npx jest tests/format/html/multiparser/ts tests/format/typescript/comments tests/format/typescript/mapped-type tests/format/typescript/prettier-ignore tests/unit/visitor-keys --coverage=false --runInBand
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
