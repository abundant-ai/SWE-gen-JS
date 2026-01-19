#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/core/auth-js/test"
cp "/tests/packages/core/auth-js/test/GoTrueClient.test.ts" "packages/core/auth-js/test/GoTrueClient.test.ts"
mkdir -p "packages/core/supabase-js/test/unit"
cp "/tests/packages/core/supabase-js/test/unit/SupabaseAuthClient.test.ts" "packages/core/supabase-js/test/unit/SupabaseAuthClient.test.ts"

# Run specific test file from the supabase-js package (unit test that doesn't require server)
cd /app/src/packages/core/supabase-js
npx jest test/unit/SupabaseAuthClient.test.ts --coverage=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
