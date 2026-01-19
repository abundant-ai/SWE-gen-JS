#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/format/angular/interpolation/html/__snapshots__"
cp "/tests/format/angular/interpolation/html/__snapshots__/format.test.js.snap" "tests/format/angular/interpolation/html/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/angular/interpolation/html"
cp "/tests/format/angular/interpolation/html/non-null-assertion.html" "tests/format/angular/interpolation/html/non-null-assertion.html"

# Run the specific test for Angular interpolation HTML formatting
npx jest tests/format/angular/interpolation/html --coverage=false --runInBand
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
