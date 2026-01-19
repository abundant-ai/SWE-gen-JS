#!/bin/bash

cd /app/src

# Rebuild TypeScript after Oracle applies fix.patch (if applicable)
npm run build

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/common/test/pipes/file"
cp "/tests/packages/common/test/pipes/file/file-type.validator.spec.ts" "packages/common/test/pipes/file/file-type.validator.spec.ts"
mkdir -p "packages/common/test/pipes/file"
cp "/tests/packages/common/test/pipes/file/parse-file-pipe.builder.spec.ts" "packages/common/test/pipes/file/parse-file-pipe.builder.spec.ts"

# Run the specific test files using mocha separately to avoid shared state issues
npx mocha packages/common/test/pipes/file/file-type.validator.spec.ts
test_status=$?

# Only run remaining tests if previous ones passed
if [ $test_status -eq 0 ]; then
  npx mocha packages/common/test/pipes/file/parse-file-pipe.builder.spec.ts
  test_status=$?
fi

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
