#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/turbo-codemod/__tests__/__fixtures__/rename-pipeline/no-turbo-json"
cp "/tests/packages/turbo-codemod/__tests__/__fixtures__/rename-pipeline/no-turbo-json/package.json" "packages/turbo-codemod/__tests__/__fixtures__/rename-pipeline/no-turbo-json/package.json"
mkdir -p "packages/turbo-codemod/__tests__/__fixtures__/rename-pipeline/root-only"
cp "/tests/packages/turbo-codemod/__tests__/__fixtures__/rename-pipeline/root-only/important.txt" "packages/turbo-codemod/__tests__/__fixtures__/rename-pipeline/root-only/important.txt"
mkdir -p "packages/turbo-codemod/__tests__/__fixtures__/rename-pipeline/root-only"
cp "/tests/packages/turbo-codemod/__tests__/__fixtures__/rename-pipeline/root-only/package.json" "packages/turbo-codemod/__tests__/__fixtures__/rename-pipeline/root-only/package.json"
mkdir -p "packages/turbo-codemod/__tests__/__fixtures__/rename-pipeline/root-only"
cp "/tests/packages/turbo-codemod/__tests__/__fixtures__/rename-pipeline/root-only/turbo.json" "packages/turbo-codemod/__tests__/__fixtures__/rename-pipeline/root-only/turbo.json"
mkdir -p "packages/turbo-codemod/__tests__/__fixtures__/rename-pipeline/workspace-configs/apps/docs"
cp "/tests/packages/turbo-codemod/__tests__/__fixtures__/rename-pipeline/workspace-configs/apps/docs/index.js" "packages/turbo-codemod/__tests__/__fixtures__/rename-pipeline/workspace-configs/apps/docs/index.js"
mkdir -p "packages/turbo-codemod/__tests__/__fixtures__/rename-pipeline/workspace-configs/apps/docs"
cp "/tests/packages/turbo-codemod/__tests__/__fixtures__/rename-pipeline/workspace-configs/apps/docs/package.json" "packages/turbo-codemod/__tests__/__fixtures__/rename-pipeline/workspace-configs/apps/docs/package.json"
mkdir -p "packages/turbo-codemod/__tests__/__fixtures__/rename-pipeline/workspace-configs/apps/docs"
cp "/tests/packages/turbo-codemod/__tests__/__fixtures__/rename-pipeline/workspace-configs/apps/docs/turbo.json" "packages/turbo-codemod/__tests__/__fixtures__/rename-pipeline/workspace-configs/apps/docs/turbo.json"
mkdir -p "packages/turbo-codemod/__tests__/__fixtures__/rename-pipeline/workspace-configs/apps/web"
cp "/tests/packages/turbo-codemod/__tests__/__fixtures__/rename-pipeline/workspace-configs/apps/web/index.js" "packages/turbo-codemod/__tests__/__fixtures__/rename-pipeline/workspace-configs/apps/web/index.js"
mkdir -p "packages/turbo-codemod/__tests__/__fixtures__/rename-pipeline/workspace-configs/apps/web"
cp "/tests/packages/turbo-codemod/__tests__/__fixtures__/rename-pipeline/workspace-configs/apps/web/package.json" "packages/turbo-codemod/__tests__/__fixtures__/rename-pipeline/workspace-configs/apps/web/package.json"
mkdir -p "packages/turbo-codemod/__tests__/__fixtures__/rename-pipeline/workspace-configs/apps/web"
cp "/tests/packages/turbo-codemod/__tests__/__fixtures__/rename-pipeline/workspace-configs/apps/web/turbo.json" "packages/turbo-codemod/__tests__/__fixtures__/rename-pipeline/workspace-configs/apps/web/turbo.json"
mkdir -p "packages/turbo-codemod/__tests__/__fixtures__/rename-pipeline/workspace-configs"
cp "/tests/packages/turbo-codemod/__tests__/__fixtures__/rename-pipeline/workspace-configs/package.json" "packages/turbo-codemod/__tests__/__fixtures__/rename-pipeline/workspace-configs/package.json"
mkdir -p "packages/turbo-codemod/__tests__/__fixtures__/rename-pipeline/workspace-configs/packages/ui"
cp "/tests/packages/turbo-codemod/__tests__/__fixtures__/rename-pipeline/workspace-configs/packages/ui/index.js" "packages/turbo-codemod/__tests__/__fixtures__/rename-pipeline/workspace-configs/packages/ui/index.js"
mkdir -p "packages/turbo-codemod/__tests__/__fixtures__/rename-pipeline/workspace-configs/packages/ui"
cp "/tests/packages/turbo-codemod/__tests__/__fixtures__/rename-pipeline/workspace-configs/packages/ui/package.json" "packages/turbo-codemod/__tests__/__fixtures__/rename-pipeline/workspace-configs/packages/ui/package.json"
mkdir -p "packages/turbo-codemod/__tests__/__fixtures__/rename-pipeline/workspace-configs/packages/ui"
cp "/tests/packages/turbo-codemod/__tests__/__fixtures__/rename-pipeline/workspace-configs/packages/ui/turbo.json" "packages/turbo-codemod/__tests__/__fixtures__/rename-pipeline/workspace-configs/packages/ui/turbo.json"
mkdir -p "packages/turbo-codemod/__tests__/__fixtures__/rename-pipeline/workspace-configs"
cp "/tests/packages/turbo-codemod/__tests__/__fixtures__/rename-pipeline/workspace-configs/turbo.json" "packages/turbo-codemod/__tests__/__fixtures__/rename-pipeline/workspace-configs/turbo.json"
mkdir -p "packages/turbo-codemod/__tests__"
cp "/tests/packages/turbo-codemod/__tests__/migrate-env-var-dependencies.test.ts" "packages/turbo-codemod/__tests__/migrate-env-var-dependencies.test.ts"
mkdir -p "packages/turbo-codemod/__tests__"
cp "/tests/packages/turbo-codemod/__tests__/rename-pipeline.ts" "packages/turbo-codemod/__tests__/rename-pipeline.ts"

# Run the specific test files using jest
cd packages/turbo-codemod && npx jest __tests__/migrate-env-var-dependencies.test.ts __tests__/rename-pipeline.ts --coverage=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
