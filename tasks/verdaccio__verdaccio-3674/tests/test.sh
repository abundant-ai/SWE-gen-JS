#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/ui-components/src/sections/Footer"
cp "/tests/packages/ui-components/src/sections/Footer/Footer.test.tsx" "packages/ui-components/src/sections/Footer/Footer.test.tsx"

# Reinstall dependencies after fix.patch (package.json and pnpm-lock.yaml changed)
pnpm install --frozen-lockfile

# Rebuild after applying fix.patch (TypeScript changes need recompilation)
pnpm run build

# Run only the specific test file affected by this PR
cd packages/ui-components
TZ=UTC NODE_ENV=test npx jest --config jest/jest.config.js src/sections/Footer/Footer.test.tsx --coverage=false
test_status=$?
cd /app/src

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
