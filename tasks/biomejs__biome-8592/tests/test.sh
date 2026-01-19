#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_graphql_analyze/tests/specs/nursery/useUniqueInputFieldNames"
cp "/tests/crates/biome_graphql_analyze/tests/specs/nursery/useUniqueInputFieldNames/invalid.graphql" "crates/biome_graphql_analyze/tests/specs/nursery/useUniqueInputFieldNames/invalid.graphql"
mkdir -p "crates/biome_graphql_analyze/tests/specs/nursery/useUniqueInputFieldNames"
cp "/tests/crates/biome_graphql_analyze/tests/specs/nursery/useUniqueInputFieldNames/invalid.graphql.snap" "crates/biome_graphql_analyze/tests/specs/nursery/useUniqueInputFieldNames/invalid.graphql.snap"
mkdir -p "crates/biome_graphql_analyze/tests/specs/nursery/useUniqueInputFieldNames"
cp "/tests/crates/biome_graphql_analyze/tests/specs/nursery/useUniqueInputFieldNames/valid.graphql" "crates/biome_graphql_analyze/tests/specs/nursery/useUniqueInputFieldNames/valid.graphql"
mkdir -p "crates/biome_graphql_analyze/tests/specs/nursery/useUniqueInputFieldNames"
cp "/tests/crates/biome_graphql_analyze/tests/specs/nursery/useUniqueInputFieldNames/valid.graphql.snap" "crates/biome_graphql_analyze/tests/specs/nursery/useUniqueInputFieldNames/valid.graphql.snap"

# Run the specific test for biome_graphql_analyze
cargo test -p biome_graphql_analyze -- --nocapture
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
