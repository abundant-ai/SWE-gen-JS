#!/bin/bash

cd /app/src

# Reinstall dependencies after Oracle applies fix.patch (if package.json changed)
npm install --legacy-peer-deps

# Rebuild TypeScript after Oracle applies fix.patch (if applicable)
npm run build

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/metadata-scanner.spec.ts" "packages/core/test/metadata-scanner.spec.ts"
mkdir -p "packages/microservices/test"
cp "/tests/packages/microservices/test/listeners-metadata-explorer.spec.ts" "packages/microservices/test/listeners-metadata-explorer.spec.ts"
mkdir -p "packages/websockets/test"
cp "/tests/packages/websockets/test/gateway-metadata-explorer.spec.ts" "packages/websockets/test/gateway-metadata-explorer.spec.ts"

# Run the specific test files using mocha with required setup files
npx mocha --require ts-node/register --require tsconfig-paths/register --require node_modules/reflect-metadata/Reflect.js --require hooks/mocha-init-hook.ts packages/core/test/metadata-scanner.spec.ts packages/microservices/test/listeners-metadata-explorer.spec.ts packages/websockets/test/gateway-metadata-explorer.spec.ts
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
