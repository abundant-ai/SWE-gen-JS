#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/ui-components/src/components/Versions"
cp "/tests/packages/ui-components/src/components/Versions/Versions.test.tsx" "packages/ui-components/src/components/Versions/Versions.test.tsx"

# Rebuild after applying fix.patch (TypeScript changes need recompilation)
pnpm build

# Run vitest on the specific test file for this PR from the ui-components directory
cd packages/ui-components
TZ=UTC npx vitest run \
  src/components/Versions/Versions.test.tsx \
  --coverage.enabled=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
