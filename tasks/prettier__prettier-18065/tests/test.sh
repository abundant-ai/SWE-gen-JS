#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/format/handlebars/style-tag/__snapshots__"
cp "/tests/format/handlebars/style-tag/__snapshots__/format.test.js.snap" "tests/format/handlebars/style-tag/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/handlebars/style-tag/embedded-language-formatting-off/__snapshots__"
cp "/tests/format/handlebars/style-tag/embedded-language-formatting-off/__snapshots__/format.test.js.snap" "tests/format/handlebars/style-tag/embedded-language-formatting-off/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/handlebars/style-tag/html-whitespace-sensitivity-ignore/__snapshots__"
cp "/tests/format/handlebars/style-tag/html-whitespace-sensitivity-ignore/__snapshots__/format.test.js.snap" "tests/format/handlebars/style-tag/html-whitespace-sensitivity-ignore/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/handlebars/style-tag/html-whitespace-sensitivity-ignore"
cp "/tests/format/handlebars/style-tag/html-whitespace-sensitivity-ignore/format.test.js" "tests/format/handlebars/style-tag/html-whitespace-sensitivity-ignore/format.test.js"
mkdir -p "tests/format/handlebars/style-tag/html-whitespace-sensitivity-ignore"
cp "/tests/format/handlebars/style-tag/html-whitespace-sensitivity-ignore/invalid.hbs" "tests/format/handlebars/style-tag/html-whitespace-sensitivity-ignore/invalid.hbs"
mkdir -p "tests/format/handlebars/style-tag/html-whitespace-sensitivity-ignore"
cp "/tests/format/handlebars/style-tag/html-whitespace-sensitivity-ignore/test.hbs" "tests/format/handlebars/style-tag/html-whitespace-sensitivity-ignore/test.hbs"

# Run the specific test file for this PR
npx jest tests/format/handlebars/style-tag/html-whitespace-sensitivity-ignore/format.test.js --coverage=false --runInBand
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
