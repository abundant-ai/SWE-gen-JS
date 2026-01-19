#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_json_analyze/tests"
cp "/tests/crates/biome_json_analyze/tests/spec_tests.rs" "crates/biome_json_analyze/tests/spec_tests.rs"

# Run the specific test file for biome_json_analyze
cargo test -p biome_json_analyze spec_tests -- --nocapture
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
