#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_cli/tests/cases"
cp "/tests/crates/biome_cli/tests/cases/handle_vue_files.rs" "crates/biome_cli/tests/cases/handle_vue_files.rs"
mkdir -p "crates/biome_cli/tests/snapshots/main_cases_handle_vue_files"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_handle_vue_files/full_support_enabled_and_scss_is_skipped.snap" "crates/biome_cli/tests/snapshots/main_cases_handle_vue_files/full_support_enabled_and_scss_is_skipped.snap"

# Run the specific test for full_support_enabled_and_scss_is_skipped in handle_vue_files
# The test is in crates/biome_cli/tests/cases/handle_vue_files.rs
cargo test -p biome_cli full_support_enabled_and_scss_is_skipped -- --nocapture
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
