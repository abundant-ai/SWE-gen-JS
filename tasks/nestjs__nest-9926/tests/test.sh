#!/bin/bash

cd /app/src

# Reinstall dependencies after Oracle applies fix.patch (if package.json changed)
npm install --legacy-peer-deps

# Rebuild the project after applying the fix
npm run build

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "integration/nest-application/raw-body/e2e"
cp "/tests/integration/nest-application/raw-body/e2e/express.spec.ts" "integration/nest-application/raw-body/e2e/express.spec.ts"
mkdir -p "integration/nest-application/raw-body/e2e"
cp "/tests/integration/nest-application/raw-body/e2e/fastify.spec.ts" "integration/nest-application/raw-body/e2e/fastify.spec.ts"

# Run the specific test files using mocha with required setup files
npx mocha --require mocha-setup.js --require ts-node/register --require tsconfig-paths/register --require node_modules/reflect-metadata/Reflect.js --require hooks/mocha-init-hook.ts integration/nest-application/raw-body/e2e/express.spec.ts integration/nest-application/raw-body/e2e/fastify.spec.ts
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
