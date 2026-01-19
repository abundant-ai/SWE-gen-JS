#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/plugins/memory/test"
cp "/tests/packages/plugins/memory/test/local-memory.spec.ts" "packages/plugins/memory/test/local-memory.spec.ts"
mkdir -p "packages/plugins/memory/test"
cp "/tests/packages/plugins/memory/test/memory-handler.spec.ts" "packages/plugins/memory/test/memory-handler.spec.ts"

# Rebuild after applying fix.patch (TypeScript changes need recompilation)
pnpm build

# Run vitest on the specific test files for this PR
cd packages/plugins/memory
npx vitest run test/local-memory.spec.ts test/memory-handler.spec.ts --coverage.enabled=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
