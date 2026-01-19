#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/format/html/yaml/__snapshots__"
cp "/tests/format/html/yaml/__snapshots__/format.test.js.snap" "tests/format/html/yaml/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/html/yaml"
cp "/tests/format/html/yaml/invalid.html" "tests/format/html/yaml/invalid.html"
mkdir -p "tests/format/yaml/json-test-suite/__snapshots__"
cp "/tests/format/yaml/json-test-suite/__snapshots__/format.test.js.snap" "tests/format/yaml/json-test-suite/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/yaml/json-test-suite"
cp "/tests/format/yaml/json-test-suite/format.test.js" "tests/format/yaml/json-test-suite/format.test.js"
mkdir -p "tests/format/yaml/mapping/duplicated-keys/__snapshots__"
cp "/tests/format/yaml/mapping/duplicated-keys/__snapshots__/format.test.js.snap" "tests/format/yaml/mapping/duplicated-keys/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/yaml/mapping/duplicated-keys"
cp "/tests/format/yaml/mapping/duplicated-keys/flow-mapping.yml" "tests/format/yaml/mapping/duplicated-keys/flow-mapping.yml"
mkdir -p "tests/format/yaml/mapping/duplicated-keys"
cp "/tests/format/yaml/mapping/duplicated-keys/format.test.js" "tests/format/yaml/mapping/duplicated-keys/format.test.js"
mkdir -p "tests/format/yaml/mapping/duplicated-keys"
cp "/tests/format/yaml/mapping/duplicated-keys/mapping.yml" "tests/format/yaml/mapping/duplicated-keys/mapping.yml"
mkdir -p "tests/format/yaml/mapping/duplicated-keys"
cp "/tests/format/yaml/mapping/duplicated-keys/merge-key.yml" "tests/format/yaml/mapping/duplicated-keys/merge-key.yml"
mkdir -p "tests/format/yaml/mapping/duplicated-keys"
cp "/tests/format/yaml/mapping/duplicated-keys/template-expression.yml" "tests/format/yaml/mapping/duplicated-keys/template-expression.yml"
mkdir -p "tests/format/yaml/yaml-test-suite/__snapshots__"
cp "/tests/format/yaml/yaml-test-suite/__snapshots__/format.test.js.snap" "tests/format/yaml/yaml-test-suite/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/yaml/yaml-test-suite"
cp "/tests/format/yaml/yaml-test-suite/format.test.js" "tests/format/yaml/yaml-test-suite/format.test.js"

# Run the specific test files for YAML formatting
# Use --runInBand to avoid parallel execution and memory issues
npx jest tests/format/html/yaml/format.test.js tests/format/yaml/json-test-suite/format.test.js tests/format/yaml/mapping/duplicated-keys/format.test.js tests/format/yaml/yaml-test-suite/format.test.js --coverage=false --runInBand
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
