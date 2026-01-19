#!/bin/bash

cd /app/src

# Rebuild TypeScript after Oracle applies fix.patch (if applicable)
npm run build

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/common/test/pipes"
cp "/tests/packages/common/test/pipes/parse-bool.pipe.spec.ts" "packages/common/test/pipes/parse-bool.pipe.spec.ts"
mkdir -p "packages/common/test/pipes"
cp "/tests/packages/common/test/pipes/parse-enum.pipe.spec.ts" "packages/common/test/pipes/parse-enum.pipe.spec.ts"
mkdir -p "packages/common/test/pipes"
cp "/tests/packages/common/test/pipes/parse-float.pipe.spec.ts" "packages/common/test/pipes/parse-float.pipe.spec.ts"
mkdir -p "packages/common/test/pipes"
cp "/tests/packages/common/test/pipes/parse-int.pipe.spec.ts" "packages/common/test/pipes/parse-int.pipe.spec.ts"
mkdir -p "packages/common/test/pipes"
cp "/tests/packages/common/test/pipes/parse-uuid.pipe.spec.ts" "packages/common/test/pipes/parse-uuid.pipe.spec.ts"

# Run the specific test files using mocha with required setup files
npx mocha --require ts-node/register --require tsconfig-paths/register --require node_modules/reflect-metadata/Reflect.js --require hooks/mocha-init-hook.ts packages/common/test/pipes/parse-bool.pipe.spec.ts packages/common/test/pipes/parse-enum.pipe.spec.ts packages/common/test/pipes/parse-float.pipe.spec.ts packages/common/test/pipes/parse-int.pipe.spec.ts packages/common/test/pipes/parse-uuid.pipe.spec.ts
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
