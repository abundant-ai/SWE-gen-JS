#!/bin/bash

cd /app/src

# Set environment variables for tests
export CI=true

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/core/src/scripts/tests/fixtures"
cp "/tests/packages/core/src/scripts/tests/fixtures/basic-with-no-ui.ts" "packages/core/src/scripts/tests/fixtures/basic-with-no-ui.ts"
cp "/tests/packages/core/src/scripts/tests/fixtures/log-node-env.ts" "packages/core/src/scripts/tests/fixtures/log-node-env.ts"
cp "/tests/packages/core/src/scripts/tests/fixtures/no-fields-with-migrations.ts" "packages/core/src/scripts/tests/fixtures/no-fields-with-migrations.ts"
cp "/tests/packages/core/src/scripts/tests/fixtures/no-fields.ts" "packages/core/src/scripts/tests/fixtures/no-fields.ts"
cp "/tests/packages/core/src/scripts/tests/fixtures/one-field-with-migrations.ts" "packages/core/src/scripts/tests/fixtures/one-field-with-migrations.ts"
cp "/tests/packages/core/src/scripts/tests/fixtures/two-fields-with-migrations.ts" "packages/core/src/scripts/tests/fixtures/two-fields-with-migrations.ts"
cp "/tests/packages/core/src/scripts/tests/fixtures/with-ts.ts" "packages/core/src/scripts/tests/fixtures/with-ts.ts"
mkdir -p "tests/sandbox"
cp "/tests/sandbox/utils.ts" "tests/sandbox/utils.ts"

# Rebuild the project to pick up any source code changes (e.g., from fix.patch applied by oracle)
yarn build
build_status=$?

if [ $build_status -ne 0 ]; then
  echo 0 > /logs/verifier/reward.txt
  exit $build_status
fi

# Run TypeScript type checking across the whole project
# This tests the fix for PR #8323 - prismaPath vs prismaClientPath API rename
# The fix changes the type definition from prismaPath to prismaClientPath
# The test files use prismaClientPath (fixed API) which will fail type check against buggy types
yarn lint:types
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
