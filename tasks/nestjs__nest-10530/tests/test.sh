#!/bin/bash

cd /app/src

# Reinstall dependencies after Oracle applies fix.patch (if package.json changed)
npm install --legacy-peer-deps

# Rebuild the project after applying the fix
npm run build

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/microservices/test/client"
cp "/tests/packages/microservices/test/client/client-grpc.spec.ts" "packages/microservices/test/client/client-grpc.spec.ts"
mkdir -p "packages/microservices/test/helpers"
cp "/tests/packages/microservices/test/helpers/grpc-helpers.spec.ts" "packages/microservices/test/helpers/grpc-helpers.spec.ts"
mkdir -p "packages/microservices/test/server"
cp "/tests/packages/microservices/test/server/server-grpc.spec.ts" "packages/microservices/test/server/server-grpc.spec.ts"

# Run the specific test files using mocha with required setup files
npx mocha --require ts-node/register --require tsconfig-paths/register --require node_modules/reflect-metadata/Reflect.js --require hooks/mocha-init-hook.ts packages/microservices/test/client/client-grpc.spec.ts packages/microservices/test/helpers/grpc-helpers.spec.ts packages/microservices/test/server/server-grpc.spec.ts
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
