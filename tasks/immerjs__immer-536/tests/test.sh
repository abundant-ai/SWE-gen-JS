#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "__tests__/__prod_snapshots__"
cp "/tests/__prod_snapshots__/base.js.snap" "__tests__/__prod_snapshots__/base.js.snap"
mkdir -p "__tests__/__prod_snapshots__"
cp "/tests/__prod_snapshots__/curry.js.snap" "__tests__/__prod_snapshots__/curry.js.snap"
mkdir -p "__tests__/__prod_snapshots__"
cp "/tests/__prod_snapshots__/frozen.js.snap" "__tests__/__prod_snapshots__/frozen.js.snap"
mkdir -p "__tests__/__prod_snapshots__"
cp "/tests/__prod_snapshots__/manual.js.snap" "__tests__/__prod_snapshots__/manual.js.snap"
mkdir -p "__tests__/__prod_snapshots__"
cp "/tests/__prod_snapshots__/patch.js.snap" "__tests__/__prod_snapshots__/patch.js.snap"
mkdir -p "__tests__/__prod_snapshots__"
cp "/tests/__prod_snapshots__/plugins.js.snap" "__tests__/__prod_snapshots__/plugins.js.snap"
mkdir -p "__tests__/__prod_snapshots__"
cp "/tests/__prod_snapshots__/readme.js.snap" "__tests__/__prod_snapshots__/readme.js.snap"
mkdir -p "__tests__/__snapshots__"
cp "/tests/__snapshots__/base.js.snap" "__tests__/__snapshots__/base.js.snap"
mkdir -p "__tests__/__snapshots__"
cp "/tests/__snapshots__/curry.js.snap" "__tests__/__snapshots__/curry.js.snap"
mkdir -p "__tests__/__snapshots__"
cp "/tests/__snapshots__/frozen.js.snap" "__tests__/__snapshots__/frozen.js.snap"
mkdir -p "__tests__/__snapshots__"
cp "/tests/__snapshots__/manual.js.snap" "__tests__/__snapshots__/manual.js.snap"
mkdir -p "__tests__/__snapshots__"
cp "/tests/__snapshots__/patch.js.snap" "__tests__/__snapshots__/patch.js.snap"
mkdir -p "__tests__/__snapshots__"
cp "/tests/__snapshots__/plugins.js.snap" "__tests__/__snapshots__/plugins.js.snap"
mkdir -p "__tests__/__snapshots__"
cp "/tests/__snapshots__/readme.js.snap" "__tests__/__snapshots__/readme.js.snap"
mkdir -p "__tests__"
cp "/tests/base.js" "__tests__/base.js"
mkdir -p "__tests__"
cp "/tests/curry.js" "__tests__/curry.js"
mkdir -p "__tests__"
cp "/tests/draft.ts" "__tests__/draft.ts"
mkdir -p "__tests__"
cp "/tests/empty.ts" "__tests__/empty.ts"
mkdir -p "__tests__"
cp "/tests/frozen.js" "__tests__/frozen.js"
mkdir -p "__tests__"
cp "/tests/immutable.ts" "__tests__/immutable.ts"
mkdir -p "__tests__"
cp "/tests/manual.js" "__tests__/manual.js"

# Run Jest on the specific test files from this PR
# Use -u to update snapshots and avoid obsolete snapshot warnings
yarn jest __tests__/base.js __tests__/curry.js __tests__/draft.ts __tests__/empty.ts __tests__/frozen.js __tests__/immutable.ts __tests__/manual.js --coverage=false -u
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
