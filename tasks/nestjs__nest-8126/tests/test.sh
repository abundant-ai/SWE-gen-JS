#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/core/test/helpers"
cp "/tests/packages/core/test/helpers/external-context-creator.spec.ts" "packages/core/test/helpers/external-context-creator.spec.ts"
mkdir -p "packages/core/test/interceptors"
cp "/tests/packages/core/test/interceptors/interceptors-consumer.spec.ts" "packages/core/test/interceptors/interceptors-consumer.spec.ts"
mkdir -p "packages/core/test/router"
cp "/tests/packages/core/test/router/router-response-controller.spec.ts" "packages/core/test/router/router-response-controller.spec.ts"
mkdir -p "packages/microservices/test"
cp "/tests/packages/microservices/test/listeners-controller.spec.ts" "packages/microservices/test/listeners-controller.spec.ts"
mkdir -p "packages/websockets/test"
cp "/tests/packages/websockets/test/web-sockets-controller.spec.ts" "packages/websockets/test/web-sockets-controller.spec.ts"

# Configure ts-node to skip type checking (transpile only)
export TS_NODE_TRANSPILE_ONLY=true

# Run the specific test files using mocha with required setup files
npx mocha --require node_modules/reflect-metadata/Reflect.js --require mocha-setup.js --require ts-node/register --require tsconfig-paths/register \
  packages/core/test/helpers/external-context-creator.spec.ts \
  packages/core/test/interceptors/interceptors-consumer.spec.ts \
  packages/core/test/router/router-response-controller.spec.ts \
  packages/microservices/test/listeners-controller.spec.ts \
  packages/websockets/test/web-sockets-controller.spec.ts
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
