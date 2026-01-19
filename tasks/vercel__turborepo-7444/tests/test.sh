#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
# This ensures both NOP and Oracle run against the fixed test expectations
mkdir -p "turborepo-tests/integration/tests"
cp "/tests/turborepo-tests/integration/tests/turbo-help.t" "turborepo-tests/integration/tests/turbo-help.t"

# Rebuild the turbo binary to pick up any code changes from fix.patch (Oracle agent)
# NOP agent doesn't apply fix.patch, so this rebuilds the buggy binary (no changes)
# Oracle agent applies fix.patch before this script runs, so this rebuilds the fixed binary
cargo build -p turbo

# Run the specific test file using prysk
cd turborepo-tests/integration
./node_modules/.bin/prysk tests/turbo-help.t
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
