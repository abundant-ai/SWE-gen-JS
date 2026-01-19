#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/format/flow/interface-types/break/__snapshots__"
cp "/tests/format/flow/interface-types/break/__snapshots__/format.test.js.snap" "tests/format/flow/interface-types/break/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/typescript/class-and-interface/long-type-parameters/__snapshots__"
cp "/tests/format/typescript/class-and-interface/long-type-parameters/__snapshots__/format.test.js.snap" "tests/format/typescript/class-and-interface/long-type-parameters/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/typescript/interface/__snapshots__"
cp "/tests/format/typescript/interface/__snapshots__/format.test.js.snap" "tests/format/typescript/interface/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/typescript/interface/long-type-parameters/__snapshots__"
cp "/tests/format/typescript/interface/long-type-parameters/__snapshots__/format.test.js.snap" "tests/format/typescript/interface/long-type-parameters/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/typescript/interface2/break/__snapshots__"
cp "/tests/format/typescript/interface2/break/__snapshots__/format.test.js.snap" "tests/format/typescript/interface2/break/__snapshots__/format.test.js.snap"

# Run the specific test files for this PR
# Snapshots are updated by running the corresponding format.test.js files
# The test files include flow interface-types and various typescript interface tests
npx jest tests/format/flow/interface-types/break/format.test.js tests/format/typescript/class-and-interface/long-type-parameters/format.test.js tests/format/typescript/interface/format.test.js tests/format/typescript/interface/long-type-parameters/format.test.js tests/format/typescript/interface2/break/format.test.js --coverage=false --runInBand
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
