#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/config"
cp "/tests/config/run-format-test.js" "tests/config/run-format-test.js"
mkdir -p "tests/format/js/comments-closure-typecast/__snapshots__"
cp "/tests/format/js/comments-closure-typecast/__snapshots__/format.test.js.snap" "tests/format/js/comments-closure-typecast/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/js/comments-closure-typecast"
cp "/tests/format/js/comments-closure-typecast/issue-4124.js" "tests/format/js/comments-closure-typecast/issue-4124.js"
mkdir -p "tests/format/js/comments-closure-typecast"
cp "/tests/format/js/comments-closure-typecast/issue-8045.js" "tests/format/js/comments-closure-typecast/issue-8045.js"

# Run the specific tests for this PR
# Testing format tests for comments-closure-typecast
npx jest tests/format/js/comments-closure-typecast --coverage=false --runInBand
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
