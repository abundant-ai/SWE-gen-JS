#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/format/less/lookup/__snapshots__"
cp "/tests/format/less/lookup/__snapshots__/format.test.js.snap" "tests/format/less/lookup/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/less/lookup"
cp "/tests/format/less/lookup/format.test.js" "tests/format/less/lookup/format.test.js"
mkdir -p "tests/format/less/lookup"
cp "/tests/format/less/lookup/lookup-1.less" "tests/format/less/lookup/lookup-1.less"
mkdir -p "tests/format/less/lookup"
cp "/tests/format/less/lookup/lookup-2.less" "tests/format/less/lookup/lookup-2.less"
mkdir -p "tests/format/less/lookup"
cp "/tests/format/less/lookup/lookup.less" "tests/format/less/lookup/lookup.less"

# Run the specific test for LESS lookup formatting
npx jest tests/format/less/lookup --coverage=false --runInBand
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
