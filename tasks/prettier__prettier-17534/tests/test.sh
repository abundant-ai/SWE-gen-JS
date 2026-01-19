#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/format/angular/v20-syntax/__snapshots__"
cp "/tests/format/angular/v20-syntax/__snapshots__/format.test.js.snap" "tests/format/angular/v20-syntax/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/angular/v20-syntax"
cp "/tests/format/angular/v20-syntax/exponentiation-operators.html" "tests/format/angular/v20-syntax/exponentiation-operators.html"
mkdir -p "tests/format/angular/v20-syntax"
cp "/tests/format/angular/v20-syntax/format.test.js" "tests/format/angular/v20-syntax/format.test.js"
mkdir -p "tests/format/angular/v20-syntax"
cp "/tests/format/angular/v20-syntax/in-operators.html" "tests/format/angular/v20-syntax/in-operators.html"
mkdir -p "tests/format/angular/v20-syntax"
cp "/tests/format/angular/v20-syntax/tagged-template-literal.html" "tests/format/angular/v20-syntax/tagged-template-literal.html"
mkdir -p "tests/format/angular/v20-syntax"
cp "/tests/format/angular/v20-syntax/template-literal.html" "tests/format/angular/v20-syntax/template-literal.html"
mkdir -p "tests/format/angular/v20-syntax"
cp "/tests/format/angular/v20-syntax/void-operators.html" "tests/format/angular/v20-syntax/void-operators.html"

# Run the specific tests for this PR
npx jest tests/format/angular/v20-syntax/format.test.js --coverage=false --runInBand
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
