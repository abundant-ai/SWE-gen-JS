#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_js_type_info/tests"
cp "/tests/crates/biome_js_type_info/tests/conditionals.rs" "crates/biome_js_type_info/tests/conditionals.rs"
mkdir -p "crates/biome_js_type_info/tests/snapshots"
cp "/tests/crates/biome_js_type_info/tests/snapshots/test_reference_to_falsy_subset_of.snap" "crates/biome_js_type_info/tests/snapshots/test_reference_to_falsy_subset_of.snap"
mkdir -p "crates/biome_module_graph/tests"
cp "/tests/crates/biome_module_graph/tests/spec_tests.rs" "crates/biome_module_graph/tests/spec_tests.rs"

# Run specific tests for this PR
cargo test -p biome_js_type_info --test conditionals -- --nocapture
test_status_1=$?

cargo test -p biome_module_graph --test spec_tests -- --nocapture
test_status_2=$?

# Both tests must pass
if [ $test_status_1 -eq 0 ] && [ $test_status_2 -eq 0 ]; then
  test_status=0
else
  test_status=1
fi

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
