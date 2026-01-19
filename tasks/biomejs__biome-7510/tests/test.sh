#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_grit_patterns/tests/specs/css"
cp "/tests/crates/biome_grit_patterns/tests/specs/css/biomeCompatibility.css" "crates/biome_grit_patterns/tests/specs/css/biomeCompatibility.css"
mkdir -p "crates/biome_grit_patterns/tests/specs/css"
cp "/tests/crates/biome_grit_patterns/tests/specs/css/biomeCompatibility.grit" "crates/biome_grit_patterns/tests/specs/css/biomeCompatibility.grit"
mkdir -p "crates/biome_grit_patterns/tests/specs/css"
cp "/tests/crates/biome_grit_patterns/tests/specs/css/biomeCompatibility.snap" "crates/biome_grit_patterns/tests/specs/css/biomeCompatibility.snap"
mkdir -p "crates/biome_grit_patterns/tests/specs/ts"
cp "/tests/crates/biome_grit_patterns/tests/specs/ts/treeSitterCompatibility.grit" "crates/biome_grit_patterns/tests/specs/ts/treeSitterCompatibility.grit"
mkdir -p "crates/biome_grit_patterns/tests/specs/ts"
cp "/tests/crates/biome_grit_patterns/tests/specs/ts/treeSitterCompatibility.snap" "crates/biome_grit_patterns/tests/specs/ts/treeSitterCompatibility.snap"
mkdir -p "crates/biome_grit_patterns/tests/specs/ts"
cp "/tests/crates/biome_grit_patterns/tests/specs/ts/treeSitterCompatibility.ts" "crates/biome_grit_patterns/tests/specs/ts/treeSitterCompatibility.ts"

# Run specific tests for this PR
cargo test -p biome_grit_patterns --test spec_tests -- --nocapture
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
