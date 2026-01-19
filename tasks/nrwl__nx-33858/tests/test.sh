#!/bin/bash

cd /app/src

# Set CI environment variable for tests
export CI=true

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/angular/src/generators/application"
cp "/tests/packages/angular/src/generators/application/application.spec.ts" "packages/angular/src/generators/application/application.spec.ts"
mkdir -p "packages/angular/src/generators/library"
cp "/tests/packages/angular/src/generators/library/library.spec.ts" "packages/angular/src/generators/library/library.spec.ts"

# Run Jest tests for the specific test files using the Angular package's config
cd packages/angular
npx jest src/generators/application/application.spec.ts src/generators/library/library.spec.ts --coverage=false --maxWorkers=1 --workerIdleMemoryLimit=512M --config jest.config.cts
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
