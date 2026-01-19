#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_graphql_analyze/tests/specs/nursery/noRootType"
cp "/tests/crates/biome_graphql_analyze/tests/specs/nursery/noRootType/invalid.graphql" "crates/biome_graphql_analyze/tests/specs/nursery/noRootType/invalid.graphql"
mkdir -p "crates/biome_graphql_analyze/tests/specs/nursery/noRootType"
cp "/tests/crates/biome_graphql_analyze/tests/specs/nursery/noRootType/invalid.graphql.snap" "crates/biome_graphql_analyze/tests/specs/nursery/noRootType/invalid.graphql.snap"
mkdir -p "crates/biome_graphql_analyze/tests/specs/nursery/noRootType"
cp "/tests/crates/biome_graphql_analyze/tests/specs/nursery/noRootType/invalid.options.json" "crates/biome_graphql_analyze/tests/specs/nursery/noRootType/invalid.options.json"
mkdir -p "crates/biome_graphql_analyze/tests/specs/nursery/noRootType"
cp "/tests/crates/biome_graphql_analyze/tests/specs/nursery/noRootType/valid.graphql" "crates/biome_graphql_analyze/tests/specs/nursery/noRootType/valid.graphql"
mkdir -p "crates/biome_graphql_analyze/tests/specs/nursery/noRootType"
cp "/tests/crates/biome_graphql_analyze/tests/specs/nursery/noRootType/valid.graphql.snap" "crates/biome_graphql_analyze/tests/specs/nursery/noRootType/valid.graphql.snap"
mkdir -p "crates/biome_graphql_analyze/tests/specs/nursery/noRootType"
cp "/tests/crates/biome_graphql_analyze/tests/specs/nursery/noRootType/valid.options.json" "crates/biome_graphql_analyze/tests/specs/nursery/noRootType/valid.options.json"

# Run the specific test for noRootType rule
# The test is in specs::nursery::no_root_type module
cargo test -p biome_graphql_analyze specs::nursery::no_root_type -- --nocapture
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
