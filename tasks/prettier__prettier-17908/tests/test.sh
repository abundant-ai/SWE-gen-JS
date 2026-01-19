#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/config"
cp "/tests/config/run-format-test.js" "tests/config/run-format-test.js"
mkdir -p "tests/format/js/import/__snapshots__"
cp "/tests/format/js/import/__snapshots__/format.test.js.snap" "tests/format/js/import/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/js/import/long-module-name/__snapshots__"
cp "/tests/format/js/import/long-module-name/__snapshots__/format.test.js.snap" "tests/format/js/import/long-module-name/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/js/import/long-module-name"
cp "/tests/format/js/import/long-module-name/format.test.js" "tests/format/js/import/long-module-name/format.test.js"
mkdir -p "tests/format/js/import/long-module-name"
cp "/tests/format/js/import/long-module-name/import-defer.js" "tests/format/js/import/long-module-name/import-defer.js"
mkdir -p "tests/format/js/import/long-module-name"
cp "/tests/format/js/import/long-module-name/import-expression.js" "tests/format/js/import/long-module-name/import-expression.js"
mkdir -p "tests/format/js/import/long-module-name"
cp "/tests/format/js/import/long-module-name/import-source.js" "tests/format/js/import/long-module-name/import-source.js"
mkdir -p "tests/format/js/require/__snapshots__"
cp "/tests/format/js/require/__snapshots__/format.test.js.snap" "tests/format/js/require/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/js/require"
cp "/tests/format/js/require/long-module-name.js" "tests/format/js/require/long-module-name.js"

# Run the specific tests for this PR (tests/format/js/import and tests/format/js/require)
npx jest tests/format/js/import tests/format/js/require --coverage=false --runInBand
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
