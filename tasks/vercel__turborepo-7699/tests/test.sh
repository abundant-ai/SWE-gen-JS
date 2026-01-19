#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/turborepo-vt100/tests"
cp "/tests/crates/turborepo-vt100/tests/entire_screen.rs" "crates/turborepo-vt100/tests/entire_screen.rs"

# Run the specific test file for turborepo-vt100 crate
cargo test -p turborepo-vt100 --test entire_screen -- --nocapture
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
