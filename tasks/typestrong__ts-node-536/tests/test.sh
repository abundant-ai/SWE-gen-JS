#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "src"
cp "/tests/src/index.spec.ts" "src/index.spec.ts"
mkdir -p "tests"
cp "/tests/tsconfig.json" "tests/tsconfig.json"

# Rebuild after copying test file
npm run build

# Run the CLI tests that validate tsconfig loading and CLI behavior
npx mocha dist/index.spec.js -R spec --bail --grep "cli"
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
