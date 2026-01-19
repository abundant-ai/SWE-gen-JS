#!/bin/bash

cd /app/src

# Rebuild TypeScript after Oracle applies fix.patch (if applicable)
npm run build

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "integration/versioning/e2e"
cp "/tests/integration/versioning/e2e/uri-versioning.spec.ts" "integration/versioning/e2e/uri-versioning.spec.ts"
mkdir -p "packages/core/test/middleware"
cp "/tests/packages/core/test/middleware/builder.spec.ts" "packages/core/test/middleware/builder.spec.ts"
mkdir -p "packages/core/test/middleware"
cp "/tests/packages/core/test/middleware/routes-mapper.spec.ts" "packages/core/test/middleware/routes-mapper.spec.ts"

# Run the specific test files using mocha with required setup files
npx mocha --require ts-node/register --require tsconfig-paths/register --require node_modules/reflect-metadata/Reflect.js --require hooks/mocha-init-hook.ts integration/versioning/e2e/uri-versioning.spec.ts packages/core/test/middleware/builder.spec.ts packages/core/test/middleware/routes-mapper.spec.ts
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
