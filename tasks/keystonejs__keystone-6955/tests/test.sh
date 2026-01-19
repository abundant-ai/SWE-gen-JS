#!/bin/bash

cd /app/src

export CI=true
export TEST_ADAPTER=sqlite
export DATABASE_URL=file:./dev.db

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/api-tests"
cp "/tests/api-tests/admin-meta.test.ts" "tests/api-tests/admin-meta.test.ts"

# Temporarily modify package.json to skip keystone postinstall during prepare
sed -i 's/&& cd examples-staging\/basic && yarn keystone-next postinstall//' package.json

# Reinstall dependencies in case fix.patch modified package.json or yarn.lock
yarn install --frozen-lockfile

# Restore package.json
git checkout package.json || true

# Rebuild the project to pick up any source code changes (e.g., from fix.patch applied by oracle)
yarn build
build_status=$?

if [ $build_status -ne 0 ]; then
  echo 0 > /logs/verifier/reward.txt
  exit $build_status
fi

# Run only the specific test file for this PR using Jest
# Using --runInBand to avoid memory issues with parallel test execution
# Disable logging and redirect stderr to stdout for cleaner test output
DISABLE_LOGGING=true NODE_ENV=test yarn run jest \
  tests/api-tests/admin-meta.test.ts \
  --coverage=false \
  --runInBand \
  --no-watchman \
  --verbose 2>&1
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
