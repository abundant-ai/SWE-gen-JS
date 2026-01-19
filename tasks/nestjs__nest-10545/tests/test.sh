#!/bin/bash

cd /app/src

# Reinstall dependencies after Oracle applies fix.patch (if package.json changed)
npm install --legacy-peer-deps

# Rebuild TypeScript after Oracle applies fix.patch (if applicable)
npm run build

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "integration/websockets/e2e"
cp "/tests/integration/websockets/e2e/gateway.spec.ts" "integration/websockets/e2e/gateway.spec.ts"
mkdir -p "integration/websockets/e2e"
cp "/tests/integration/websockets/e2e/ws-gateway.spec.ts" "integration/websockets/e2e/ws-gateway.spec.ts"

# Run the specific test files using mocha with required setup files
npx mocha --require ts-node/register --require tsconfig-paths/register --require node_modules/reflect-metadata/Reflect.js --require hooks/mocha-init-hook.ts integration/websockets/e2e/gateway.spec.ts integration/websockets/e2e/ws-gateway.spec.ts
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
