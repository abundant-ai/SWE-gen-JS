#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/common/test/pipes/file"
cp "/tests/packages/common/test/pipes/file/file-type.validator.spec.ts" "packages/common/test/pipes/file/file-type.validator.spec.ts"
mkdir -p "packages/common/test/pipes/file"
cp "/tests/packages/common/test/pipes/file/max-file-size.validator.spec.ts" "packages/common/test/pipes/file/max-file-size.validator.spec.ts"

# Run the specific test files using mocha
npx mocha packages/common/test/pipes/file/file-type.validator.spec.ts packages/common/test/pipes/file/max-file-size.validator.spec.ts
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
