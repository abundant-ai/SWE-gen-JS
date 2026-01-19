#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/format/angular/angular/__snapshots__"
cp "/tests/format/angular/angular/__snapshots__/format.test.js.snap" "tests/format/angular/angular/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/angular/interpolation/html/__snapshots__"
cp "/tests/format/angular/interpolation/html/__snapshots__/format.test.js.snap" "tests/format/angular/interpolation/html/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/angular/interpolation/html"
cp "/tests/format/angular/interpolation/html/comments.html" "tests/format/angular/interpolation/html/comments.html"

# Run the specific tests for this PR (tests/format/angular)
npx jest tests/format/angular --coverage=false --runInBand
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
