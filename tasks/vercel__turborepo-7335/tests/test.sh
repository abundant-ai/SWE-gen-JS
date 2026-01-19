#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
# This ensures both NOP and Oracle run against the fixed test expectations
mkdir -p "crates/turborepo-ui/tests"
cp "/tests/crates/turborepo-ui/tests/threads.rs" "crates/turborepo-ui/tests/threads.rs"

# Run the Rust unit test for threads
# cargo test will compile the test with any code changes from fix.patch (Oracle agent)
# This is the primary test for this PR which tests the finish() API change
cargo test --package turborepo-ui --test threads -- --nocapture
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
