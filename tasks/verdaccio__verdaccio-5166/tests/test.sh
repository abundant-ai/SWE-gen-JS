#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/middleware/test/__snapshots__"
cp "/tests/packages/middleware/test/__snapshots__/template.test.ts.snap" "packages/middleware/test/__snapshots__/template.test.ts.snap"
mkdir -p "packages/middleware/test"
cp "/tests/packages/middleware/test/template.test.ts" "packages/middleware/test/template.test.ts"
mkdir -p "packages/server/express/test/config"
cp "/tests/packages/server/express/test/config/web-enabled.yaml" "packages/server/express/test/config/web-enabled.yaml"
mkdir -p "packages/server/express/test"
cp "/tests/packages/server/express/test/server.spec.ts" "packages/server/express/test/server.spec.ts"

# Rebuild after applying fix.patch (TypeScript changes need recompilation)
pnpm build

# Run vitest on the specific test files for this PR
npx vitest run packages/middleware/test/template.test.ts packages/server/express/test/server.spec.ts --coverage.enabled=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
