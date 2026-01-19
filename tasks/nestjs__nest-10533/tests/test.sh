#!/bin/bash

cd /app/src

# Reinstall dependencies after Oracle applies fix.patch (if package.json changed)
npm install --legacy-peer-deps

# Remove compiled files to ensure ts-node compiles from TypeScript source
find packages -name "*.js" -type f -delete
find packages -name "*.d.ts" -type f -delete

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/common/test/decorators"
cp "/tests/packages/common/test/decorators/route-params.decorator.spec.ts" "packages/common/test/decorators/route-params.decorator.spec.ts"

# Run the specific test files using mocha with required setup files
npx mocha --require ts-node/register --require tsconfig-paths/register --require node_modules/reflect-metadata/Reflect.js --require hooks/mocha-init-hook.ts packages/common/test/decorators/route-params.decorator.spec.ts
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
