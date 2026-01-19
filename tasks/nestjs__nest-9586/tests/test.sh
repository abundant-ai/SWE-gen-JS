#!/bin/bash

cd /app/src

# Rebuild the project after applying the fix
npm run build

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/microservices/test/ctx-host"
cp "/tests/packages/microservices/test/ctx-host/kafka.context.spec.ts" "packages/microservices/test/ctx-host/kafka.context.spec.ts"
mkdir -p "packages/microservices/test/server"
cp "/tests/packages/microservices/test/server/server-kafka.spec.ts" "packages/microservices/test/server/server-kafka.spec.ts"

# Run the specific test files using mocha with required setup files
npx mocha --require mocha-setup.js --require ts-node/register --require tsconfig-paths/register --require node_modules/reflect-metadata/Reflect.js --require hooks/mocha-init-hook.ts \
  packages/microservices/test/ctx-host/kafka.context.spec.ts \
  packages/microservices/test/server/server-kafka.spec.ts
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
