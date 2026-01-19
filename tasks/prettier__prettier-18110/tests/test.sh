#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/config"
cp "/tests/config/run-format-test.js" "tests/config/run-format-test.js"
mkdir -p "tests/format/typescript/property-signature/consistent-with-flow/__snapshots__"
cp "/tests/format/typescript/property-signature/consistent-with-flow/__snapshots__/format.test.js.snap" "tests/format/typescript/property-signature/consistent-with-flow/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/typescript/property-signature/consistent-with-flow"
cp "/tests/format/typescript/property-signature/consistent-with-flow/comments.ts" "tests/format/typescript/property-signature/consistent-with-flow/comments.ts"
mkdir -p "tests/format/typescript/property-signature/consistent-with-flow"
cp "/tests/format/typescript/property-signature/consistent-with-flow/format.test.js" "tests/format/typescript/property-signature/consistent-with-flow/format.test.js"
mkdir -p "tests/format/typescript/property-signature/consistent-with-flow"
cp "/tests/format/typescript/property-signature/consistent-with-flow/intersection.ts" "tests/format/typescript/property-signature/consistent-with-flow/intersection.ts"
mkdir -p "tests/format/typescript/property-signature/consistent-with-flow"
cp "/tests/format/typescript/property-signature/consistent-with-flow/union.ts" "tests/format/typescript/property-signature/consistent-with-flow/union.ts"

# Run the specific test files for this PR
# Snapshots are updated by running the corresponding format.test.js file
npx jest tests/format/typescript/property-signature/consistent-with-flow/format.test.js --coverage=false --runInBand
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
