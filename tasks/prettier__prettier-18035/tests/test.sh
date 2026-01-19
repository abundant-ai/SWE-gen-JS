#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/format/typescript/import-require/__snapshots__"
cp "/tests/format/typescript/import-require/__snapshots__/format.test.js.snap" "tests/format/typescript/import-require/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/typescript/import-require"
cp "/tests/format/typescript/import-require/comments.ts" "tests/format/typescript/import-require/comments.ts"
mkdir -p "tests/format/typescript/import-require"
cp "/tests/format/typescript/import-require/import-require.ts" "tests/format/typescript/import-require/import-require.ts"

# Run the specific test for TypeScript import-require formatting
npx jest tests/format/typescript/import-require --coverage=false --runInBand
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
