#!/bin/bash

cd /app/src

# Rebuild packages to pick up any code changes (e.g., from oracle's fix.patch)
npm run build

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/microservices/test/helpers"
cp "/tests/packages/microservices/test/helpers/kafka-parser.spec.ts" "packages/microservices/test/helpers/kafka-parser.spec.ts"

# Configure ts-node to skip type checking (transpile only)
export TS_NODE_TRANSPILE_ONLY=true

# Run the specific test files using mocha with required setup files
npx mocha --require node_modules/reflect-metadata/Reflect.js --require mocha-setup.js --require ts-node/register --require tsconfig-paths/register \
  packages/microservices/test/helpers/kafka-parser.spec.ts
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
