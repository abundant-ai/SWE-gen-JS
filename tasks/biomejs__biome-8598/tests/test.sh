#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_graphql_analyze/tests/specs/nursery/useUniqueFieldDefinitionNames"
cp "/tests/crates/biome_graphql_analyze/tests/specs/nursery/useUniqueFieldDefinitionNames/invalid.graphql" "crates/biome_graphql_analyze/tests/specs/nursery/useUniqueFieldDefinitionNames/invalid.graphql"
mkdir -p "crates/biome_graphql_analyze/tests/specs/nursery/useUniqueFieldDefinitionNames"
cp "/tests/crates/biome_graphql_analyze/tests/specs/nursery/useUniqueFieldDefinitionNames/invalid.graphql.snap" "crates/biome_graphql_analyze/tests/specs/nursery/useUniqueFieldDefinitionNames/invalid.graphql.snap"
mkdir -p "crates/biome_graphql_analyze/tests/specs/nursery/useUniqueFieldDefinitionNames"
cp "/tests/crates/biome_graphql_analyze/tests/specs/nursery/useUniqueFieldDefinitionNames/valid.graphql" "crates/biome_graphql_analyze/tests/specs/nursery/useUniqueFieldDefinitionNames/valid.graphql"
mkdir -p "crates/biome_graphql_analyze/tests/specs/nursery/useUniqueFieldDefinitionNames"
cp "/tests/crates/biome_graphql_analyze/tests/specs/nursery/useUniqueFieldDefinitionNames/valid.graphql.snap" "crates/biome_graphql_analyze/tests/specs/nursery/useUniqueFieldDefinitionNames/valid.graphql.snap"

# Run the specific test for biome_graphql_analyze
cargo test -p biome_graphql_analyze -- --nocapture
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
