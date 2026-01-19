#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/format/mdx/import-export/__snapshots__"
cp "/tests/format/mdx/import-export/__snapshots__/format.test.js.snap" "tests/format/mdx/import-export/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/mdx/import-export"
cp "/tests/format/mdx/import-export/esm.mdx" "tests/format/mdx/import-export/esm.mdx"
mkdir -p "tests/format/mdx/import-export"
cp "/tests/format/mdx/import-export/format.test.js" "tests/format/mdx/import-export/format.test.js"
mkdir -p "tests/format/mdx/import-export"
cp "/tests/format/mdx/import-export/like-import-declaration.mdx" "tests/format/mdx/import-export/like-import-declaration.mdx"
mkdir -p "tests/format/mdx/import-export"
cp "/tests/format/mdx/import-export/list.mdx" "tests/format/mdx/import-export/list.mdx"
mkdir -p "tests/format/mdx/import-export"
cp "/tests/format/mdx/import-export/paragraph.mdx" "tests/format/mdx/import-export/paragraph.mdx"

# Run the specific test for MDX import-export formatting
npx jest tests/format/mdx/import-export --coverage=false --runInBand
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
