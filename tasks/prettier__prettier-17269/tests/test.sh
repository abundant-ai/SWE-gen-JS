#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/format/json/jsonc/empty/__snapshots__"
cp "/tests/format/json/jsonc/empty/__snapshots__/format.test.js.snap" "tests/format/json/jsonc/empty/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/json/jsonc/empty"
cp "/tests/format/json/jsonc/empty/format.test.js" "tests/format/json/jsonc/empty/format.test.js"
mkdir -p "tests/format/misc/errors/json/__snapshots__"
cp "/tests/format/misc/errors/json/__snapshots__/format.test.js.snap" "tests/format/misc/errors/json/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/misc/errors/json"
cp "/tests/format/misc/errors/json/format.test.js" "tests/format/misc/errors/json/format.test.js"

# Run the specific tests for this PR (tests in tests/format/json/)
npx jest tests/format/json/jsonc/empty tests/format/misc/errors/json --coverage=false --runInBand
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
