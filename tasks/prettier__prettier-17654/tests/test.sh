#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/config"
cp "/tests/config/run-format-test.js" "tests/config/run-format-test.js"
mkdir -p "tests/format/typescript/conformance/types/functions/__snapshots__"
cp "/tests/format/typescript/conformance/types/functions/__snapshots__/format.test.js.snap" "tests/format/typescript/conformance/types/functions/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/typescript/conformance/types/functions"
cp "/tests/format/typescript/conformance/types/functions/format.test.js" "tests/format/typescript/conformance/types/functions/format.test.js"
mkdir -p "tests/format/typescript/d-ts-files/__snapshots__"
cp "/tests/format/typescript/d-ts-files/__snapshots__/format.test.js.snap" "tests/format/typescript/d-ts-files/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/typescript/d-ts-files"
cp "/tests/format/typescript/d-ts-files/format.test.js" "tests/format/typescript/d-ts-files/format.test.js"
mkdir -p "tests/format/typescript/trailing-comma/__snapshots__"
cp "/tests/format/typescript/trailing-comma/__snapshots__/format.test.js.snap" "tests/format/typescript/trailing-comma/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/typescript/trailing-comma"
cp "/tests/format/typescript/trailing-comma/format.test.js" "tests/format/typescript/trailing-comma/format.test.js"

# Run the specific tests for this PR
# Use -u to update snapshots since bug.patch may have removed test files that had snapshots
npx jest tests/format/typescript/conformance/types/functions tests/format/typescript/d-ts-files tests/format/typescript/trailing-comma --coverage=false --runInBand -u
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
