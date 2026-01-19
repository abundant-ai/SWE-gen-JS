#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/format/css/font/__snapshots__"
cp "/tests/format/css/font/__snapshots__/format.test.js.snap" "tests/format/css/font/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/css/font"
cp "/tests/format/css/font/font.css" "tests/format/css/font/font.css"
mkdir -p "tests/format/css/font"
cp "/tests/format/css/font/format.test.js" "tests/format/css/font/format.test.js"

# Run the specific test files for this PR
# Snapshots are updated by running the corresponding format.test.js file
npx jest tests/format/css/font/format.test.js --coverage=false --runInBand
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
