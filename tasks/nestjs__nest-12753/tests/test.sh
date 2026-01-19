#!/bin/bash

cd /app/src

# Rebuild TypeScript after Oracle applies fix.patch (if applicable)
npm run build

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/core/test/router"
cp "/tests/packages/core/test/router/router-module.spec.ts" "packages/core/test/router/router-module.spec.ts"
mkdir -p "packages/microservices/test/module"
cp "/tests/packages/microservices/test/module/clients.module.spec.ts" "packages/microservices/test/module/clients.module.spec.ts"
mkdir -p "packages/platform-express/test/multer/multer"
cp "/tests/packages/platform-express/test/multer/multer/multer.module.spec.ts" "packages/platform-express/test/multer/multer/multer.module.spec.ts"

# Run the specific test files using mocha
npx mocha packages/core/test/router/router-module.spec.ts packages/microservices/test/module/clients.module.spec.ts packages/platform-express/test/multer/multer/multer.module.spec.ts
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
