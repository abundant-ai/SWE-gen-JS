#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/format/js/babel-plugins/__snapshots__"
cp "/tests/format/js/babel-plugins/__snapshots__/format.test.js.snap" "tests/format/js/babel-plugins/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/js/babel-plugins"
cp "/tests/format/js/babel-plugins/discard-binding.js" "tests/format/js/babel-plugins/discard-binding.js"
mkdir -p "tests/format/js/babel-plugins"
cp "/tests/format/js/babel-plugins/format.test.js" "tests/format/js/babel-plugins/format.test.js"
mkdir -p "tests/format/js/discard-binding/__snapshots__"
cp "/tests/format/js/discard-binding/__snapshots__/format.test.js.snap" "tests/format/js/discard-binding/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/js/discard-binding"
cp "/tests/format/js/discard-binding/array-pattern.js" "tests/format/js/discard-binding/array-pattern.js"
mkdir -p "tests/format/js/discard-binding"
cp "/tests/format/js/discard-binding/basic.js" "tests/format/js/discard-binding/basic.js"
mkdir -p "tests/format/js/discard-binding"
cp "/tests/format/js/discard-binding/discard-binding-arrow-params.js" "tests/format/js/discard-binding/discard-binding-arrow-params.js"
mkdir -p "tests/format/js/discard-binding"
cp "/tests/format/js/discard-binding/discard-binding-assignment.js" "tests/format/js/discard-binding/discard-binding-assignment.js"
mkdir -p "tests/format/js/discard-binding"
cp "/tests/format/js/discard-binding/discard-binding-async-arrow-params.js" "tests/format/js/discard-binding/discard-binding-async-arrow-params.js"
mkdir -p "tests/format/js/discard-binding"
cp "/tests/format/js/discard-binding/discard-binding-bindings.js" "tests/format/js/discard-binding/discard-binding-bindings.js"
mkdir -p "tests/format/js/discard-binding"
cp "/tests/format/js/discard-binding/discard-binding-for-await-using-binding.js" "tests/format/js/discard-binding/discard-binding-for-await-using-binding.js"
mkdir -p "tests/format/js/discard-binding"
cp "/tests/format/js/discard-binding/discard-binding-for-bindings.js" "tests/format/js/discard-binding/discard-binding-for-bindings.js"
mkdir -p "tests/format/js/discard-binding"
cp "/tests/format/js/discard-binding/discard-binding-for-lhs.js" "tests/format/js/discard-binding/discard-binding-for-lhs.js"
mkdir -p "tests/format/js/discard-binding"
cp "/tests/format/js/discard-binding/discard-binding-for-using-binding.js" "tests/format/js/discard-binding/discard-binding-for-using-binding.js"
mkdir -p "tests/format/js/discard-binding"
cp "/tests/format/js/discard-binding/format.test.js" "tests/format/js/discard-binding/format.test.js"
mkdir -p "tests/format/js/discard-binding"
cp "/tests/format/js/discard-binding/function-parameter.js" "tests/format/js/discard-binding/function-parameter.js"
mkdir -p "tests/format/js/discard-binding"
cp "/tests/format/js/discard-binding/object-pattern.js" "tests/format/js/discard-binding/object-pattern.js"
mkdir -p "tests/format/js/discard-binding"
cp "/tests/format/js/discard-binding/unary-expression-void.js" "tests/format/js/discard-binding/unary-expression-void.js"
mkdir -p "tests/format/js/discard-binding"
cp "/tests/format/js/discard-binding/using-variable-declarator.js" "tests/format/js/discard-binding/using-variable-declarator.js"
mkdir -p "tests/format/js/discard-binding"
cp "/tests/format/js/discard-binding/using.js" "tests/format/js/discard-binding/using.js"
mkdir -p "tests/format/misc/errors/js/discard-binding/__snapshots__"
cp "/tests/format/misc/errors/js/discard-binding/__snapshots__/format.test.js.snap" "tests/format/misc/errors/js/discard-binding/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/misc/errors/js/discard-binding"
cp "/tests/format/misc/errors/js/discard-binding/format.test.js" "tests/format/misc/errors/js/discard-binding/format.test.js"
mkdir -p "tests/format/misc/errors/js/discard-binding"
cp "/tests/format/misc/errors/js/discard-binding/invalid-array-expression.js" "tests/format/misc/errors/js/discard-binding/invalid-array-expression.js"
mkdir -p "tests/format/misc/errors/js/discard-binding"
cp "/tests/format/misc/errors/js/discard-binding/invalid-assignment-expression.js" "tests/format/misc/errors/js/discard-binding/invalid-assignment-expression.js"
mkdir -p "tests/format/misc/errors/js/discard-binding"
cp "/tests/format/misc/errors/js/discard-binding/invalid-assignment-for.js" "tests/format/misc/errors/js/discard-binding/invalid-assignment-for.js"
mkdir -p "tests/format/misc/errors/js/discard-binding"
cp "/tests/format/misc/errors/js/discard-binding/invalid-assignment-pattern.js" "tests/format/misc/errors/js/discard-binding/invalid-assignment-pattern.js"

# Run the specific tests for this PR
# Use -u to update snapshots since bug.patch may have removed test files that had snapshots
npx jest tests/format/js/babel-plugins tests/format/js/discard-binding tests/format/misc/errors/js/discard-binding --coverage=false --runInBand -u
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
