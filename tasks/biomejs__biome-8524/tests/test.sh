#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_cli/tests/cases"
cp "/tests/crates/biome_cli/tests/cases/monorepo.rs" "crates/biome_cli/tests/cases/monorepo.rs"
mkdir -p "crates/biome_cli/tests/snapshots/main_cases_monorepo"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_monorepo/plugins_from_root_config_work_in_child_config_extends_root.snap" "crates/biome_cli/tests/snapshots/main_cases_monorepo/plugins_from_root_config_work_in_child_config_extends_root.snap"

# Run the specific test for biome_cli
cargo test -p biome_cli -- --nocapture
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
