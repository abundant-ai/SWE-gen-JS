#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "turborepo-tests/integration/tests"
cp "/tests/turborepo-tests/integration/tests/turbo-trace.t" "turborepo-tests/integration/tests/turbo-trace.t"

# Rebuild turbo binary (needed because solve.sh may have applied fix.patch)
cargo build --bin turbo

# Run specific integration test file using prysk
pnpm --filter turborepo-tests-integration exec prysk tests/turbo-trace.t
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
