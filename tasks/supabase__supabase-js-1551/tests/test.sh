#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test/deno"
cp "/tests/deno/integration.test.ts" "test/deno/integration.test.ts"
mkdir -p "test"
cp "/tests/integration.test.ts" "test/integration.test.ts"
mkdir -p "test/integration/bun"
cp "/tests/integration/bun/bun.lockb" "test/integration/bun/bun.lockb"
mkdir -p "test/integration/bun"
cp "/tests/integration/bun/integration.test.ts" "test/integration/bun/integration.test.ts"
mkdir -p "test/unit"
cp "/tests/unit/SupabaseClient.test.ts" "test/unit/SupabaseClient.test.ts"

# Run specific unit test file using jest (disable coverage to avoid threshold failures)
# Note: test/integration.test.ts requires a running Supabase server, so we only run unit tests
npx jest test/unit/SupabaseClient.test.ts --coverage=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
