#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/config"
cp "/tests/config/run-format-test.js" "tests/config/run-format-test.js"
mkdir -p "tests/format/js/multiparser-comments/__snapshots__"
cp "/tests/format/js/multiparser-comments/__snapshots__/format.test.js.snap" "tests/format/js/multiparser-comments/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/js/multiparser-css/__snapshots__"
cp "/tests/format/js/multiparser-css/__snapshots__/format.test.js.snap" "tests/format/js/multiparser-css/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/js/strings/__snapshots__"
cp "/tests/format/js/strings/__snapshots__/format.test.js.snap" "tests/format/js/strings/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/js/strings"
cp "/tests/format/js/strings/template-literals.js" "tests/format/js/strings/template-literals.js"
mkdir -p "tests/format/js/template-literals/__snapshots__"
cp "/tests/format/js/template-literals/__snapshots__/format.test.js.snap" "tests/format/js/template-literals/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/js/template-literals"
cp "/tests/format/js/template-literals/expression-break.js" "tests/format/js/template-literals/expression-break.js"
mkdir -p "tests/format/js/test-declarations/__snapshots__"
cp "/tests/format/js/test-declarations/__snapshots__/format.test.js.snap" "tests/format/js/test-declarations/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/jsx/template/__snapshots__"
cp "/tests/format/jsx/template/__snapshots__/format.test.js.snap" "tests/format/jsx/template/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/jsx/template"
cp "/tests/format/jsx/template/format.test.js" "tests/format/jsx/template/format.test.js"
mkdir -p "tests/format/jsx/template"
cp "/tests/format/jsx/template/styled-components.js" "tests/format/jsx/template/styled-components.js"

# Run the specific test files for template-literals and related formatting
# Use --runInBand to avoid parallel execution and memory issues
npx jest tests/format/js/strings/format.test.js tests/format/js/template-literals/format.test.js tests/format/js/test-declarations/format.test.js tests/format/js/multiparser-comments/format.test.js tests/format/js/multiparser-css/format.test.js tests/format/jsx/template/format.test.js --coverage=false --runInBand
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
