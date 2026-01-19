#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_cli/tests/commands"
cp "/tests/crates/biome_cli/tests/commands/format.rs" "crates/biome_cli/tests/commands/format.rs"
mkdir -p "crates/biome_cli/tests/commands"
cp "/tests/crates/biome_cli/tests/commands/init.rs" "crates/biome_cli/tests/commands/init.rs"
mkdir -p "crates/biome_cli/tests/snapshots/main_commands_format"
cp "/tests/crates/biome_cli/tests/snapshots/main_commands_format/html_enabled_by_default.snap" "crates/biome_cli/tests/snapshots/main_commands_format/html_enabled_by_default.snap"
mkdir -p "crates/biome_cli/tests/snapshots/main_commands_init"
cp "/tests/crates/biome_cli/tests/snapshots/main_commands_init/creates_config_file.snap" "crates/biome_cli/tests/snapshots/main_commands_init/creates_config_file.snap"
mkdir -p "crates/biome_cli/tests/snapshots/main_commands_init"
cp "/tests/crates/biome_cli/tests/snapshots/main_commands_init/creates_config_file_when_biome_installed_via_package_manager.snap" "crates/biome_cli/tests/snapshots/main_commands_init/creates_config_file_when_biome_installed_via_package_manager.snap"
mkdir -p "crates/biome_cli/tests/snapshots/main_commands_init"
cp "/tests/crates/biome_cli/tests/snapshots/main_commands_init/creates_config_jsonc_file.snap" "crates/biome_cli/tests/snapshots/main_commands_init/creates_config_jsonc_file.snap"
mkdir -p "crates/biome_cli/tests/snapshots/main_commands_init"
cp "/tests/crates/biome_cli/tests/snapshots/main_commands_init/enables_vcs_and_ignore_dist.snap" "crates/biome_cli/tests/snapshots/main_commands_init/enables_vcs_and_ignore_dist.snap"

# Rebuild the test binary after copying test files
# Touch the test files to ensure cargo detects changes
touch crates/biome_cli/tests/commands/format.rs
touch crates/biome_cli/tests/commands/init.rs
cargo test -p biome_cli --no-run 2>&1 | grep -v "^warning:" || true

# Run tests for the format and init command test files
# These tests are in the main test target, under the commands module
# We run the commands module tests which includes both format and init
test_output=$(cargo test -p biome_cli --test main commands -- --nocapture 2>&1)
test_status=$?
echo "$test_output"

# Check if any tests actually ran (count total tests across all test suites)
total_tests=$(echo "$test_output" | grep "^running [0-9]* tests" | awk '{sum += $2} END {print sum}')
if [ "$total_tests" = "0" ] || [ -z "$total_tests" ]; then
  echo "ERROR: No tests ran. Test files may be missing." >&2
  echo 0 > /logs/verifier/reward.txt
  exit 1
fi

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
