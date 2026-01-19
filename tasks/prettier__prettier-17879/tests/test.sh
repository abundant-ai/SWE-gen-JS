#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/format/html/attributes/iframe-allow-attribute/__snapshots__"
cp "/tests/format/html/attributes/iframe-allow-attribute/__snapshots__/format.test.js.snap" "tests/format/html/attributes/iframe-allow-attribute/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/html/attributes/iframe-allow-attribute"
cp "/tests/format/html/attributes/iframe-allow-attribute/allow-attribute.html" "tests/format/html/attributes/iframe-allow-attribute/allow-attribute.html"
mkdir -p "tests/format/html/attributes/iframe-allow-attribute"
cp "/tests/format/html/attributes/iframe-allow-attribute/format.test.js" "tests/format/html/attributes/iframe-allow-attribute/format.test.js"
mkdir -p "tests/format/html/attributes/iframe-allow-attribute/small-print-width/__snapshots__"
cp "/tests/format/html/attributes/iframe-allow-attribute/small-print-width/__snapshots__/format.test.js.snap" "tests/format/html/attributes/iframe-allow-attribute/small-print-width/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/html/attributes/iframe-allow-attribute/small-print-width"
cp "/tests/format/html/attributes/iframe-allow-attribute/small-print-width/allow-attribute.html" "tests/format/html/attributes/iframe-allow-attribute/small-print-width/allow-attribute.html"
mkdir -p "tests/format/html/attributes/iframe-allow-attribute/small-print-width"
cp "/tests/format/html/attributes/iframe-allow-attribute/small-print-width/format.test.js" "tests/format/html/attributes/iframe-allow-attribute/small-print-width/format.test.js"

# Run the specific tests for this PR (tests/format/html/attributes/iframe-allow-attribute)
npx jest tests/format/html/attributes/iframe-allow-attribute --coverage=false --runInBand
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
