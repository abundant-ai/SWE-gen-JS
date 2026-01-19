#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/mermaid/src/diagrams/gantt"
cp "/tests/packages/mermaid/src/diagrams/gantt/ganttDb.spec.ts" "packages/mermaid/src/diagrams/gantt/ganttDb.spec.ts"
mkdir -p "packages/mermaid/src/tests"
cp "/tests/packages/mermaid/src/tests/util.ts" "packages/mermaid/src/tests/util.ts"

# Reinstall dependencies after oracle applies fix (package.json and pnpm-lock.yaml may have changed)
pnpm install --frozen-lockfile --ignore-scripts

# Rebuild after copying test files (required for TypeScript projects)
pnpm run build

# Run specific test files using vitest
npx vitest run packages/mermaid/src/diagrams/gantt/ganttDb.spec.ts --coverage.enabled=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
