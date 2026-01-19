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
cp "/tests/manual.js" "__tests__/manual.js"
mkdir -p "__tests__"
cp "/tests/map-set.js" "__tests__/map-set.js"
mkdir -p "__tests__"
cp "/tests/patch.js" "__tests__/patch.js"

# Run Vitest on the specific test files (disable coverage for subset testing)
npx vitest run __tests__/base.js __tests__/manual.js __tests__/map-set.js __tests__/patch.js --coverage.enabled=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
