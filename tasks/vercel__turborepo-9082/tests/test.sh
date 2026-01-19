#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "turborepo-tests/integration/tests"
cp "/tests/turborepo-tests/integration/tests/conflicting-flags.t" "turborepo-tests/integration/tests/conflicting-flags.t"
mkdir -p "turborepo-tests/integration/tests"
cp "/tests/turborepo-tests/integration/tests/no-args.t" "turborepo-tests/integration/tests/no-args.t"
mkdir -p "turborepo-tests/integration/tests"
cp "/tests/turborepo-tests/integration/tests/turbo-help.t" "turborepo-tests/integration/tests/turbo-help.t"

# Rebuild turbo binary (needed because solve.sh may have applied fix.patch)
cargo build --bin turbo

# Run specific integration test files using prysk
pnpm --filter turborepo-tests-integration exec prysk \
  tests/conflicting-flags.t \
  tests/no-args.t \
  tests/turbo-help.t
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
