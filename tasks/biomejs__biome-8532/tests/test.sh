#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_cli/tests/commands"
cp "/tests/crates/biome_cli/tests/commands/check.rs" "crates/biome_cli/tests/commands/check.rs"
mkdir -p "crates/biome_cli/tests/commands"
cp "/tests/crates/biome_cli/tests/commands/ci.rs" "crates/biome_cli/tests/commands/ci.rs"
mkdir -p "crates/biome_cli/tests/snapshots/main_commands_check"
cp "/tests/crates/biome_cli/tests/snapshots/main_commands_check/check_help.snap" "crates/biome_cli/tests/snapshots/main_commands_check/check_help.snap"
mkdir -p "crates/biome_cli/tests/snapshots/main_commands_ci"
cp "/tests/crates/biome_cli/tests/snapshots/main_commands_ci/ci_help.snap" "crates/biome_cli/tests/snapshots/main_commands_ci/ci_help.snap"
mkdir -p "crates/biome_cli/tests/snapshots/main_commands_lint"
cp "/tests/crates/biome_cli/tests/snapshots/main_commands_lint/lint_help.snap" "crates/biome_cli/tests/snapshots/main_commands_lint/lint_help.snap"

# Run the specific test for biome_cli
cargo test -p biome_cli -- --nocapture
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
