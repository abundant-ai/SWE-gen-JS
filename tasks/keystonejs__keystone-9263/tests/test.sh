#!/bin/bash

cd /app/src

export CI=true

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/fields-document/src"
cp "/tests/packages/fields-document/src/validation.test.tsx" "packages/fields-document/src/validation.test.tsx"

# Rebuild the project to pick up any source code changes (e.g., from fix.patch applied by oracle)
pnpm build
build_status=$?

if [ $build_status -ne 0 ]; then
  echo 0 > /logs/verifier/reward.txt
  exit $build_status
fi

# Run the specific test file for this PR
npx jest packages/fields-document/src/validation.test.tsx --coverage=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
