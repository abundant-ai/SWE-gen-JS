#!/bin/bash

cd /app/src

export CI=true
export TEST_ADAPTER=sqlite
export DATABASE_URL=file:./dev.db

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/core/src/scripts/tests/__snapshots__"
cp "/tests/packages/core/src/scripts/tests/__snapshots__/artifacts.test.ts.snap" "packages/core/src/scripts/tests/__snapshots__/artifacts.test.ts.snap"

# Reinstall dependencies in case fix.patch modified package.json or yarn.lock
yarn install --frozen-lockfile

# Rebuild the project to pick up any source code changes (e.g., from fix.patch applied by oracle)
yarn build
build_status=$?

if [ $build_status -ne 0 ]; then
  echo 0 > /logs/verifier/reward.txt
  exit $build_status
fi

# Run only the specific test file that tests the artifact generation
# Using --runInBand to avoid memory issues with parallel test execution
yarn jest \
  packages/core/src/scripts/tests/artifacts.test.ts \
  --coverage=false \
  --runInBand
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
