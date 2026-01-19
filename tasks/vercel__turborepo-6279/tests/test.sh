#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "turborepo-tests/integration/tests/_fixtures/find_turbo/hoisted/node_modules/turbo-windows-64/bin"
cp "/tests/turborepo-tests/integration/tests/_fixtures/find_turbo/hoisted/node_modules/turbo-windows-64/bin/.keep" "turborepo-tests/integration/tests/_fixtures/find_turbo/hoisted/node_modules/turbo-windows-64/bin/.keep"
mkdir -p "turborepo-tests/integration/tests/_fixtures/find_turbo/hoisted/node_modules/turbo-windows-arm64/bin"
cp "/tests/turborepo-tests/integration/tests/_fixtures/find_turbo/hoisted/node_modules/turbo-windows-arm64/bin/.keep" "turborepo-tests/integration/tests/_fixtures/find_turbo/hoisted/node_modules/turbo-windows-arm64/bin/.keep"
mkdir -p "turborepo-tests/integration/tests/_fixtures/find_turbo/linked/node_modules/.pnpm/turbo-windows-64@1.0.0/node_modules/turbo-windows-64/bin"
cp "/tests/turborepo-tests/integration/tests/_fixtures/find_turbo/linked/node_modules/.pnpm/turbo-windows-64@1.0.0/node_modules/turbo-windows-64/bin/.keep" "turborepo-tests/integration/tests/_fixtures/find_turbo/linked/node_modules/.pnpm/turbo-windows-64@1.0.0/node_modules/turbo-windows-64/bin/.keep"
mkdir -p "turborepo-tests/integration/tests/_fixtures/find_turbo/linked/node_modules/.pnpm/turbo-windows-arm64@1.0.0/node_modules/turbo-windows-arm64/bin"
cp "/tests/turborepo-tests/integration/tests/_fixtures/find_turbo/linked/node_modules/.pnpm/turbo-windows-arm64@1.0.0/node_modules/turbo-windows-arm64/bin/.keep" "turborepo-tests/integration/tests/_fixtures/find_turbo/linked/node_modules/.pnpm/turbo-windows-arm64@1.0.0/node_modules/turbo-windows-arm64/bin/.keep"
mkdir -p "turborepo-tests/integration/tests/_fixtures/find_turbo/nested/node_modules/turbo/node_modules/turbo-windows-64/bin"
cp "/tests/turborepo-tests/integration/tests/_fixtures/find_turbo/nested/node_modules/turbo/node_modules/turbo-windows-64/bin/.keep" "turborepo-tests/integration/tests/_fixtures/find_turbo/nested/node_modules/turbo/node_modules/turbo-windows-64/bin/.keep"
mkdir -p "turborepo-tests/integration/tests/_fixtures/find_turbo/nested/node_modules/turbo/node_modules/turbo-windows-arm64/bin"
cp "/tests/turborepo-tests/integration/tests/_fixtures/find_turbo/nested/node_modules/turbo/node_modules/turbo-windows-arm64/bin/.keep" "turborepo-tests/integration/tests/_fixtures/find_turbo/nested/node_modules/turbo/node_modules/turbo-windows-arm64/bin/.keep"
mkdir -p "turborepo-tests/integration/tests/_fixtures/find_turbo/self/node_modules/turbo-windows-64/bin"
cp "/tests/turborepo-tests/integration/tests/_fixtures/find_turbo/self/node_modules/turbo-windows-64/bin/.keep" "turborepo-tests/integration/tests/_fixtures/find_turbo/self/node_modules/turbo-windows-64/bin/.keep"
mkdir -p "turborepo-tests/integration/tests/_fixtures/find_turbo/self/node_modules/turbo-windows-arm64/bin"
cp "/tests/turborepo-tests/integration/tests/_fixtures/find_turbo/self/node_modules/turbo-windows-arm64/bin/.keep" "turborepo-tests/integration/tests/_fixtures/find_turbo/self/node_modules/turbo-windows-arm64/bin/.keep"
mkdir -p "turborepo-tests/integration/tests/_fixtures/find_turbo/unplugged/.yarn/unplugged/turbo-windows-64-npm-1.0.0-520925a700/node_modules/turbo-windows-64/bin"
cp "/tests/turborepo-tests/integration/tests/_fixtures/find_turbo/unplugged/.yarn/unplugged/turbo-windows-64-npm-1.0.0-520925a700/node_modules/turbo-windows-64/bin/.keep" "turborepo-tests/integration/tests/_fixtures/find_turbo/unplugged/.yarn/unplugged/turbo-windows-64-npm-1.0.0-520925a700/node_modules/turbo-windows-64/bin/.keep"
mkdir -p "turborepo-tests/integration/tests/_fixtures/find_turbo/unplugged/.yarn/unplugged/turbo-windows-arm64-npm-1.0.0-520925a700/node_modules/turbo-windows-arm64/bin"
cp "/tests/turborepo-tests/integration/tests/_fixtures/find_turbo/unplugged/.yarn/unplugged/turbo-windows-arm64-npm-1.0.0-520925a700/node_modules/turbo-windows-arm64/bin/.keep" "turborepo-tests/integration/tests/_fixtures/find_turbo/unplugged/.yarn/unplugged/turbo-windows-arm64-npm-1.0.0-520925a700/node_modules/turbo-windows-arm64/bin/.keep"
mkdir -p "turborepo-tests/integration/tests/_fixtures/find_turbo/unplugged_env_moved/.moved/unplugged/turbo-windows-64-npm-1.0.0-520925a700/node_modules/turbo-windows-64/bin"
cp "/tests/turborepo-tests/integration/tests/_fixtures/find_turbo/unplugged_env_moved/.moved/unplugged/turbo-windows-64-npm-1.0.0-520925a700/node_modules/turbo-windows-64/bin/.keep" "turborepo-tests/integration/tests/_fixtures/find_turbo/unplugged_env_moved/.moved/unplugged/turbo-windows-64-npm-1.0.0-520925a700/node_modules/turbo-windows-64/bin/.keep"
mkdir -p "turborepo-tests/integration/tests/_fixtures/find_turbo/unplugged_env_moved/.moved/unplugged/turbo-windows-arm64-npm-1.0.0-520925a700/node_modules/turbo-windows-arm64/bin"
cp "/tests/turborepo-tests/integration/tests/_fixtures/find_turbo/unplugged_env_moved/.moved/unplugged/turbo-windows-arm64-npm-1.0.0-520925a700/node_modules/turbo-windows-arm64/bin/.keep" "turborepo-tests/integration/tests/_fixtures/find_turbo/unplugged_env_moved/.moved/unplugged/turbo-windows-arm64-npm-1.0.0-520925a700/node_modules/turbo-windows-arm64/bin/.keep"
mkdir -p "turborepo-tests/integration/tests/_fixtures/find_turbo/unplugged_moved/.moved/unplugged/turbo-windows-64-npm-1.0.0-520925a700/node_modules/turbo-windows-64/bin"
cp "/tests/turborepo-tests/integration/tests/_fixtures/find_turbo/unplugged_moved/.moved/unplugged/turbo-windows-64-npm-1.0.0-520925a700/node_modules/turbo-windows-64/bin/.keep" "turborepo-tests/integration/tests/_fixtures/find_turbo/unplugged_moved/.moved/unplugged/turbo-windows-64-npm-1.0.0-520925a700/node_modules/turbo-windows-64/bin/.keep"
mkdir -p "turborepo-tests/integration/tests/_fixtures/find_turbo/unplugged_moved/.moved/unplugged/turbo-windows-arm64-npm-1.0.0-520925a700/node_modules/turbo-windows-arm64/bin"
cp "/tests/turborepo-tests/integration/tests/_fixtures/find_turbo/unplugged_moved/.moved/unplugged/turbo-windows-arm64-npm-1.0.0-520925a700/node_modules/turbo-windows-arm64/bin/.keep" "turborepo-tests/integration/tests/_fixtures/find_turbo/unplugged_moved/.moved/unplugged/turbo-windows-arm64-npm-1.0.0-520925a700/node_modules/turbo-windows-arm64/bin/.keep"
mkdir -p "turborepo-tests/integration/tests/_fixtures/strict_env_vars/apps/my-app"
cp "/tests/turborepo-tests/integration/tests/_fixtures/strict_env_vars/apps/my-app/build.sh" "turborepo-tests/integration/tests/_fixtures/strict_env_vars/apps/my-app/build.sh"
mkdir -p "turborepo-tests/integration/tests/_fixtures/strict_env_vars/apps/my-app"
cp "/tests/turborepo-tests/integration/tests/_fixtures/strict_env_vars/apps/my-app/package.json" "turborepo-tests/integration/tests/_fixtures/strict_env_vars/apps/my-app/package.json"
mkdir -p "turborepo-tests/integration/tests/_fixtures/turbo-configs"
cp "/tests/turborepo-tests/integration/tests/_fixtures/turbo-configs/abs-path-globs-win.json" "turborepo-tests/integration/tests/_fixtures/turbo-configs/abs-path-globs-win.json"
mkdir -p "turborepo-tests/integration/tests/_helpers"
cp "/tests/turborepo-tests/integration/tests/_helpers/setup_monorepo.sh" "turborepo-tests/integration/tests/_helpers/setup_monorepo.sh"
mkdir -p "turborepo-tests/integration/tests"
cp "/tests/turborepo-tests/integration/tests/bad-flag.t" "turborepo-tests/integration/tests/bad-flag.t"

# Verify Windows support files exist (they are removed in bug.patch, added in fix.patch)
# Check for the turbo-exe-stub package that enables Windows support
if [ -f "packages/turbo-exe-stub/build.sh" ] && \
   [ -f "packages/turbo-exe-stub/turbo.cpp" ] && \
   [ -f "packages/turbo-exe-stub/.gitignore" ]; then
  echo "Windows support files found - test passed"
  test_status=0
else
  echo "Windows support files missing - test failed"
  test_status=1
fi

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
