#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_module_graph/tests"
cp "/tests/crates/biome_module_graph/tests/spec_tests.rs" "crates/biome_module_graph/tests/spec_tests.rs"

# Run the specific test for biome_module_graph
cargo test -p biome_module_graph -- --nocapture
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
