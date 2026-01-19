#!/bin/bash

cd /app/src

# Rebuild TypeScript after Oracle applies fix.patch (if applicable)
npm run build

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/core/test/injector"
cp "/tests/packages/core/test/injector/compiler.spec.ts" "packages/core/test/injector/compiler.spec.ts"
mkdir -p "packages/core/test/injector/opaque-key-factory"
cp "/tests/packages/core/test/injector/opaque-key-factory/by-reference-module-opaque-key-factory.spec.ts" "packages/core/test/injector/opaque-key-factory/by-reference-module-opaque-key-factory.spec.ts"
mkdir -p "packages/core/test/injector/opaque-key-factory"
cp "/tests/packages/core/test/injector/opaque-key-factory/deep-hashed-module-opaque-key-factory.spec.ts" "packages/core/test/injector/opaque-key-factory/deep-hashed-module-opaque-key-factory.spec.ts"

# Run the specific test files using mocha
npx mocha packages/core/test/injector/compiler.spec.ts packages/core/test/injector/opaque-key-factory/by-reference-module-opaque-key-factory.spec.ts packages/core/test/injector/opaque-key-factory/deep-hashed-module-opaque-key-factory.spec.ts
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
