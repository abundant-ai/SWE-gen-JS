#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noUnnecessaryConditions"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noUnnecessaryConditions/validAssignment.ts" "crates/biome_js_analyze/tests/specs/nursery/noUnnecessaryConditions/validAssignment.ts"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noUnnecessaryConditions"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noUnnecessaryConditions/validAssignment.ts.snap" "crates/biome_js_analyze/tests/specs/nursery/noUnnecessaryConditions/validAssignment.ts.snap"
mkdir -p "crates/biome_module_graph/tests/snapshots"
cp "/tests/crates/biome_module_graph/tests/snapshots/test_widening_via_assignment.snap" "crates/biome_module_graph/tests/snapshots/test_widening_via_assignment.snap"
mkdir -p "crates/biome_module_graph/tests/snapshots"
cp "/tests/crates/biome_module_graph/tests/snapshots/test_widening_via_assignment_multiple_values.snap" "crates/biome_module_graph/tests/snapshots/test_widening_via_assignment_multiple_values.snap"
mkdir -p "crates/biome_module_graph/tests"
cp "/tests/crates/biome_module_graph/tests/spec_tests.rs" "crates/biome_module_graph/tests/spec_tests.rs"

# Run the specific tests for this PR
cargo test -p biome_module_graph test_widening_via_assignment -- --nocapture
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
