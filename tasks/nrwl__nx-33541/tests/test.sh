#!/bin/bash

cd /app/src

# Set CI environment variable for tests
export CI=true

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/nx/src/project-graph"
cp "/tests/packages/nx/src/project-graph/project-graph.spec.ts" "packages/nx/src/project-graph/project-graph.spec.ts"

# Run Jest tests for the specific test file using the nx package's config
cd packages/nx
npx jest src/project-graph/project-graph.spec.ts --coverage=false --maxWorkers=1 --workerIdleMemoryLimit=512M --config jest.config.cts
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
