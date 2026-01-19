#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/config"
cp "/tests/config/run-format-test.js" "tests/config/run-format-test.js"
mkdir -p "tests/config/utils"
cp "/tests/config/utils/check-parsers.js" "tests/config/utils/check-parsers.js"
mkdir -p "tests/format/flow/mapped-types/__snapshots__"
cp "/tests/format/flow/mapped-types/__snapshots__/format.test.js.snap" "tests/format/flow/mapped-types/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/flow/mapped-types"
cp "/tests/format/flow/mapped-types/format.test.js" "tests/format/flow/mapped-types/format.test.js"
mkdir -p "tests/format/js/arrows-bind"
cp "/tests/format/js/arrows-bind/format.test.js" "tests/format/js/arrows-bind/format.test.js"
mkdir -p "tests/format/js/async-do-expressions"
cp "/tests/format/js/async-do-expressions/format.test.js" "tests/format/js/async-do-expressions/format.test.js"
mkdir -p "tests/format/js/babel-plugins"
cp "/tests/format/js/babel-plugins/format.test.js" "tests/format/js/babel-plugins/format.test.js"
mkdir -p "tests/format/js/bind-expressions"
cp "/tests/format/js/bind-expressions/format.test.js" "tests/format/js/bind-expressions/format.test.js"
mkdir -p "tests/format/js/call/invalid"
cp "/tests/format/js/call/invalid/format.test.js" "tests/format/js/call/invalid/format.test.js"
mkdir -p "tests/format/js/comments-pipeline-own-line"
cp "/tests/format/js/comments-pipeline-own-line/format.test.js" "tests/format/js/comments-pipeline-own-line/format.test.js"
mkdir -p "tests/format/js/deferred-import-evaluation"
cp "/tests/format/js/deferred-import-evaluation/format.test.js" "tests/format/js/deferred-import-evaluation/format.test.js"
mkdir -p "tests/format/js/destructuring-private-fields"
cp "/tests/format/js/destructuring-private-fields/format.test.js" "tests/format/js/destructuring-private-fields/format.test.js"
mkdir -p "tests/format/js/do"
cp "/tests/format/js/do/format.test.js" "tests/format/js/do/format.test.js"
mkdir -p "tests/format/js/explicit-resource-management/__snapshots__"
cp "/tests/format/js/explicit-resource-management/__snapshots__/format.test.js.snap" "tests/format/js/explicit-resource-management/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/js/explicit-resource-management"
cp "/tests/format/js/explicit-resource-management/format.test.js" "tests/format/js/explicit-resource-management/format.test.js"
mkdir -p "tests/format/js/export-default/escaped"
cp "/tests/format/js/export-default/escaped/format.test.js" "tests/format/js/export-default/escaped/format.test.js"
mkdir -p "tests/format/js/export-default/export-default-from"
cp "/tests/format/js/export-default/export-default-from/format.test.js" "tests/format/js/export-default/export-default-from/format.test.js"
mkdir -p "tests/format/js/module-blocks"
cp "/tests/format/js/module-blocks/format.test.js" "tests/format/js/module-blocks/format.test.js"
mkdir -p "tests/format/js/multiparser-invalid/__snapshots__"
cp "/tests/format/js/multiparser-invalid/__snapshots__/format.test.js.snap" "tests/format/js/multiparser-invalid/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/js/multiparser-invalid"
cp "/tests/format/js/multiparser-invalid/format.test.js" "tests/format/js/multiparser-invalid/format.test.js"

# Run the specific tests for this PR
# Testing format tests for flow/mapped-types, babel-plugins, and various experimental features
npx jest tests/format/flow/mapped-types tests/format/js/arrows-bind tests/format/js/async-do-expressions tests/format/js/babel-plugins tests/format/js/bind-expressions tests/format/js/call/invalid tests/format/js/comments-pipeline-own-line tests/format/js/deferred-import-evaluation tests/format/js/destructuring-private-fields tests/format/js/do tests/format/js/explicit-resource-management tests/format/js/export-default/escaped tests/format/js/export-default/export-default-from tests/format/js/module-blocks tests/format/js/multiparser-invalid --coverage=false --runInBand
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
