#!/bin/bash

cd /app/src

# Rebuild the project after applying the fix
npm run build

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/core/test/injector"
cp "/tests/packages/core/test/injector/injector.spec.ts" "packages/core/test/injector/injector.spec.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/nest-application-context.spec.ts" "packages/core/test/nest-application-context.spec.ts"

# Run the specific test files using mocha with required setup files
npx mocha --require mocha-setup.js --require ts-node/register --require tsconfig-paths/register --require node_modules/reflect-metadata/Reflect.js \
  packages/core/test/injector/injector.spec.ts \
  packages/core/test/nest-application-context.spec.ts
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
