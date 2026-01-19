#!/bin/bash

cd /app/src

# Rebuild the project after applying the fix
npm run build

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "integration/send-files/e2e"
cp "/tests/integration/send-files/e2e/express.spec.ts" "integration/send-files/e2e/express.spec.ts"
mkdir -p "integration/send-files/e2e"
cp "/tests/integration/send-files/e2e/fastify.spec.ts" "integration/send-files/e2e/fastify.spec.ts"
mkdir -p "packages/common/test/file-stream"
cp "/tests/packages/common/test/file-stream/streamable-file.spec.ts" "packages/common/test/file-stream/streamable-file.spec.ts"

# Run the specific test files using mocha with required setup files
npx mocha --require mocha-setup.js --require ts-node/register --require tsconfig-paths/register --require node_modules/reflect-metadata/Reflect.js \
  integration/send-files/e2e/express.spec.ts \
  integration/send-files/e2e/fastify.spec.ts \
  packages/common/test/file-stream/streamable-file.spec.ts
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
