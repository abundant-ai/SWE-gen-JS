#!/bin/bash

cd /app/src

# Rebuild TypeScript after Oracle applies fix.patch (if applicable)
npm run build

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "integration/nest-application/global-prefix/e2e"
cp "/tests/integration/nest-application/global-prefix/e2e/global-prefix.spec.ts" "integration/nest-application/global-prefix/e2e/global-prefix.spec.ts"
mkdir -p "packages/core/test/middleware"
cp "/tests/packages/core/test/middleware/builder.spec.ts" "packages/core/test/middleware/builder.spec.ts"
mkdir -p "packages/core/test/middleware"
cp "/tests/packages/core/test/middleware/route-info-path-extractor.spec.ts" "packages/core/test/middleware/route-info-path-extractor.spec.ts"

# Run the specific test files using mocha
npx mocha integration/nest-application/global-prefix/e2e/global-prefix.spec.ts packages/core/test/middleware/builder.spec.ts packages/core/test/middleware/route-info-path-extractor.spec.ts
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
