#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_cli/tests/cases"
cp "/tests/crates/biome_cli/tests/cases/handle_astro_files.rs" "crates/biome_cli/tests/cases/handle_astro_files.rs"
mkdir -p "crates/biome_cli/tests/snapshots/main_cases_handle_astro_files"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_handle_astro_files/dont_indent_frontmatter.snap" "crates/biome_cli/tests/snapshots/main_cases_handle_astro_files/dont_indent_frontmatter.snap"

# Run the biome_cli tests for handle_astro_files
cargo test -p biome_cli --test main handle_astro_files -- --nocapture
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
