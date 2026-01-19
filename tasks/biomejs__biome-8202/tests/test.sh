#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_grit_patterns/tests/specs/tsx"
cp "/tests/crates/biome_grit_patterns/tests/specs/tsx/jsx_attributes.grit" "crates/biome_grit_patterns/tests/specs/tsx/jsx_attributes.grit"
mkdir -p "crates/biome_grit_patterns/tests/specs/tsx"
cp "/tests/crates/biome_grit_patterns/tests/specs/tsx/jsx_attributes.snap" "crates/biome_grit_patterns/tests/specs/tsx/jsx_attributes.snap"
mkdir -p "crates/biome_grit_patterns/tests/specs/tsx"
cp "/tests/crates/biome_grit_patterns/tests/specs/tsx/jsx_attributes.tsx" "crates/biome_grit_patterns/tests/specs/tsx/jsx_attributes.tsx"

# Run the specific tests for jsx_attributes
# The tests are in crates/biome_grit_patterns/tests/specs/tsx/jsx_attributes.*
cargo test -p biome_grit_patterns jsx_attributes -- --nocapture
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
