#!/bin/bash

cd /app/src

# Rebuild the project after applying the fix
npm run build

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "integration/nest-application/global-prefix/e2e"
cp "/tests/integration/nest-application/global-prefix/e2e/global-prefix.spec.ts" "integration/nest-application/global-prefix/e2e/global-prefix.spec.ts"

# Run the specific test file using mocha with required setup files
npx mocha --require mocha-setup.js --require ts-node/register --require tsconfig-paths/register --require node_modules/reflect-metadata/Reflect.js \
  integration/nest-application/global-prefix/e2e/global-prefix.spec.ts
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
