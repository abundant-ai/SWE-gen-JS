#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/format/angular/assignment-operator/__snapshots__"
cp "/tests/format/angular/assignment-operator/__snapshots__/format.test.js.snap" "tests/format/angular/assignment-operator/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/angular/assignment-operator"
cp "/tests/format/angular/assignment-operator/assignment-operator.html" "tests/format/angular/assignment-operator/assignment-operator.html"
mkdir -p "tests/format/angular/assignment-operator"
cp "/tests/format/angular/assignment-operator/format.test.js" "tests/format/angular/assignment-operator/format.test.js"

# Run the specific tests for this PR (tests/format/angular/assignment-operator/)
npx jest tests/format/angular/assignment-operator --coverage=false --runInBand
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
