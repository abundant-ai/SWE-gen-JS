#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/format/yaml/block-folded/__snapshots__"
cp "/tests/format/yaml/block-folded/__snapshots__/format.test.js.snap" "tests/format/yaml/block-folded/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/yaml/block-folded"
cp "/tests/format/yaml/block-folded/block-folded-keep.yml" "tests/format/yaml/block-folded/block-folded-keep.yml"
mkdir -p "tests/format/yaml/block-folded"
cp "/tests/format/yaml/block-folded/block-folded-strip.yml" "tests/format/yaml/block-folded/block-folded-strip.yml"
mkdir -p "tests/format/yaml/document/__snapshots__"
cp "/tests/format/yaml/document/__snapshots__/format.test.js.snap" "tests/format/yaml/document/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/yaml/document"
cp "/tests/format/yaml/document/end-mark-2.yml" "tests/format/yaml/document/end-mark-2.yml"
mkdir -p "tests/format/yaml/document"
cp "/tests/format/yaml/document/end-mark.yml" "tests/format/yaml/document/end-mark.yml"
mkdir -p "tests/format/yaml/prettier-ignore/__snapshots__"
cp "/tests/format/yaml/prettier-ignore/__snapshots__/format.test.js.snap" "tests/format/yaml/prettier-ignore/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/yaml/root/__snapshots__"
cp "/tests/format/yaml/root/__snapshots__/format.test.js.snap" "tests/format/yaml/root/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/yaml/spec/__snapshots__"
cp "/tests/format/yaml/spec/__snapshots__/format.test.js.snap" "tests/format/yaml/spec/__snapshots__/format.test.js.snap"

# Run the specific test files for this PR
# Snapshots are updated by running the corresponding format.test.js files
npx jest tests/format/yaml/block-folded/format.test.js tests/format/yaml/document/format.test.js tests/format/yaml/prettier-ignore/format.test.js tests/format/yaml/root/format.test.js tests/format/yaml/spec/format.test.js --coverage=false --runInBand
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
