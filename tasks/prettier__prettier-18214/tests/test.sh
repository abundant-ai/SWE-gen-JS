#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/format/graphql/descriptions/__snapshots__"
cp "/tests/format/graphql/descriptions/__snapshots__/format.test.js.snap" "tests/format/graphql/descriptions/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/graphql/descriptions"
cp "/tests/format/graphql/descriptions/format.test.js" "tests/format/graphql/descriptions/format.test.js"
mkdir -p "tests/format/graphql/descriptions"
cp "/tests/format/graphql/descriptions/fragment-with-variable-description(legacy).graphql" "tests/format/graphql/descriptions/fragment-with-variable-description(legacy).graphql"
mkdir -p "tests/format/graphql/descriptions"
cp "/tests/format/graphql/descriptions/fragment.graphql" "tests/format/graphql/descriptions/fragment.graphql"
mkdir -p "tests/format/graphql/descriptions"
cp "/tests/format/graphql/descriptions/nameless-query-with-description.graphql" "tests/format/graphql/descriptions/nameless-query-with-description.graphql"
mkdir -p "tests/format/graphql/descriptions"
cp "/tests/format/graphql/descriptions/operation-and-variable-definition-descriptions.graphql" "tests/format/graphql/descriptions/operation-and-variable-definition-descriptions.graphql"
mkdir -p "tests/format/graphql/descriptions"
cp "/tests/format/graphql/descriptions/variable-definition-with-description-default value-and-directives.graphql" "tests/format/graphql/descriptions/variable-definition-with-description-default value-and-directives.graphql"
mkdir -p "tests/format/graphql/kitchen-sink/__snapshots__"
cp "/tests/format/graphql/kitchen-sink/__snapshots__/format.test.js.snap" "tests/format/graphql/kitchen-sink/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/graphql/kitchen-sink"
cp "/tests/format/graphql/kitchen-sink/kitchen-sink-2.graphql" "tests/format/graphql/kitchen-sink/kitchen-sink-2.graphql"
mkdir -p "tests/format/graphql/kitchen-sink"
cp "/tests/format/graphql/kitchen-sink/kitchen-sink.graphql" "tests/format/graphql/kitchen-sink/kitchen-sink.graphql"
mkdir -p "tests/format/graphql/kitchen-sink"
cp "/tests/format/graphql/kitchen-sink/schema-kitchen-sink.graphql" "tests/format/graphql/kitchen-sink/schema-kitchen-sink.graphql"
mkdir -p "tests/format/misc/errors/graphql/__snapshots__"
cp "/tests/format/misc/errors/graphql/__snapshots__/format.test.js.snap" "tests/format/misc/errors/graphql/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/misc/errors/graphql"
cp "/tests/format/misc/errors/graphql/descriptions-on-a-short-hand-query.graphql" "tests/format/misc/errors/graphql/descriptions-on-a-short-hand-query.graphql"
mkdir -p "tests/unit/__snapshots__"
cp "/tests/unit/__snapshots__/visitor-keys.js.snap" "tests/unit/__snapshots__/visitor-keys.js.snap"

# Run the specific test files for this PR
# Snapshots are updated by running the corresponding format.test.js files
npx jest tests/format/graphql/descriptions/format.test.js tests/format/graphql/kitchen-sink/format.test.js tests/format/misc/errors/graphql/format.test.js tests/unit/visitor-keys.js --coverage=false --runInBand
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
