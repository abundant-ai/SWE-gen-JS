#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/mermaid/src/diagram-api"
cp "/tests/packages/mermaid/src/diagram-api/diagram-orchestration.spec.ts" "packages/mermaid/src/diagram-api/diagram-orchestration.spec.ts"
mkdir -p "packages/mermaid/src"
cp "/tests/packages/mermaid/src/mermaidAPI.spec.ts" "packages/mermaid/src/mermaidAPI.spec.ts"

# Reinstall dependencies after oracle applies fix (package.json and pnpm-lock.yaml may have changed)
pnpm install --frozen-lockfile --ignore-scripts

# Rebuild after copying test files (required for TypeScript projects)
pnpm run build

# Run specific test files using vitest
npx vitest run packages/mermaid/src/diagram-api/diagram-orchestration.spec.ts packages/mermaid/src/mermaidAPI.spec.ts --coverage.enabled=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
