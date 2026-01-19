#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_grit_patterns/tests/specs/tsx"
cp "/tests/crates/biome_grit_patterns/tests/specs/tsx/jsx_slots.grit" "crates/biome_grit_patterns/tests/specs/tsx/jsx_slots.grit"
mkdir -p "crates/biome_grit_patterns/tests/specs/tsx"
cp "/tests/crates/biome_grit_patterns/tests/specs/tsx/jsx_slots.snap" "crates/biome_grit_patterns/tests/specs/tsx/jsx_slots.snap"
mkdir -p "crates/biome_grit_patterns/tests/specs/tsx"
cp "/tests/crates/biome_grit_patterns/tests/specs/tsx/jsx_slots.tsx" "crates/biome_grit_patterns/tests/specs/tsx/jsx_slots.tsx"

# Run the specific grit patterns tests affected by this PR
# The test files are in tsx/jsx_slots.*
# Running tsx tests to include the jsx_slots test case
cargo test -p biome_grit_patterns --test spec_tests tsx -- --nocapture
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
