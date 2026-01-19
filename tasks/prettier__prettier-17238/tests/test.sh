#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/format/angular/template-literal/__snapshots__"
cp "/tests/format/angular/template-literal/__snapshots__/format.test.js.snap" "tests/format/angular/template-literal/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/angular/template-literal"
cp "/tests/format/angular/template-literal/format.test.js" "tests/format/angular/template-literal/format.test.js"
mkdir -p "tests/format/angular/template-literal"
cp "/tests/format/angular/template-literal/template-literal.html" "tests/format/angular/template-literal/template-literal.html"

# Run the specific tests for this PR (tests in tests/format/angular/template-literal/)
npx jest tests/format/angular/template-literal --coverage=false --runInBand
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
