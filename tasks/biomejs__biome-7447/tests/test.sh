#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_grit_patterns/tests/specs/ts"
cp "/tests/crates/biome_grit_patterns/tests/specs/ts/spreadMetavariable.grit" "crates/biome_grit_patterns/tests/specs/ts/spreadMetavariable.grit"
mkdir -p "crates/biome_grit_patterns/tests/specs/ts"
cp "/tests/crates/biome_grit_patterns/tests/specs/ts/spreadMetavariable.snap" "crates/biome_grit_patterns/tests/specs/ts/spreadMetavariable.snap"
mkdir -p "crates/biome_grit_patterns/tests/specs/ts"
cp "/tests/crates/biome_grit_patterns/tests/specs/ts/spreadMetavariable.ts" "crates/biome_grit_patterns/tests/specs/ts/spreadMetavariable.ts"

# Run specific tests for this PR
cargo test -p biome_grit_patterns --test spec_tests spread_metavariable -- --nocapture
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
