#!/bin/bash

cd /app/src

# Reinstall dependencies after Oracle applies fix.patch (if package.json changed)
npm install --legacy-peer-deps

# Rebuild the project after applying the fix
npm run build

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "integration/repl/e2e"
cp "/tests/integration/repl/e2e/repl.spec.ts" "integration/repl/e2e/repl.spec.ts"
mkdir -p "packages/core/test/repl"
cp "/tests/packages/core/test/repl/assign-to-object.util.spec.ts" "packages/core/test/repl/assign-to-object.util.spec.ts"
mkdir -p "packages/core/test/repl/native-functions"
cp "/tests/packages/core/test/repl/native-functions/debug-repl-fn.spec.ts" "packages/core/test/repl/native-functions/debug-repl-fn.spec.ts"
mkdir -p "packages/core/test/repl/native-functions"
cp "/tests/packages/core/test/repl/native-functions/get-repl-fn.spec.ts" "packages/core/test/repl/native-functions/get-repl-fn.spec.ts"
mkdir -p "packages/core/test/repl/native-functions"
cp "/tests/packages/core/test/repl/native-functions/help-repl-fn.spec.ts" "packages/core/test/repl/native-functions/help-repl-fn.spec.ts"
mkdir -p "packages/core/test/repl/native-functions"
cp "/tests/packages/core/test/repl/native-functions/methods-repl-fn.spec.ts" "packages/core/test/repl/native-functions/methods-repl-fn.spec.ts"
mkdir -p "packages/core/test/repl/native-functions"
cp "/tests/packages/core/test/repl/native-functions/resolve-repl-fn.spec.ts" "packages/core/test/repl/native-functions/resolve-repl-fn.spec.ts"
mkdir -p "packages/core/test/repl/native-functions"
cp "/tests/packages/core/test/repl/native-functions/select-repl-fn.spec.ts" "packages/core/test/repl/native-functions/select-repl-fn.spec.ts"

# Run the specific test files using mocha with required setup files
# Note: Only running unit tests, not integration tests due to REPL environment issues
npx mocha --require mocha-setup.js --require ts-node/register --require tsconfig-paths/register --require node_modules/reflect-metadata/Reflect.js --require hooks/mocha-init-hook.ts \
  packages/core/test/repl/assign-to-object.util.spec.ts \
  packages/core/test/repl/native-functions/debug-repl-fn.spec.ts \
  packages/core/test/repl/native-functions/get-repl-fn.spec.ts \
  packages/core/test/repl/native-functions/help-repl-fn.spec.ts \
  packages/core/test/repl/native-functions/methods-repl-fn.spec.ts \
  packages/core/test/repl/native-functions/resolve-repl-fn.spec.ts \
  packages/core/test/repl/native-functions/select-repl-fn.spec.ts
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
