#!/bin/bash

cd /app/src

# Clear Jest cache to ensure fresh test run
npx jest --clearCache 2>/dev/null || true

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/actionCreators.test.ts" "packages/core/test/actionCreators.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/actions.test.ts" "packages/core/test/actions.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/after.test.ts" "packages/core/test/after.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/event.test.ts" "packages/core/test/event.test.ts"
mkdir -p "packages/core/test/fixtures"
cp "/tests/packages/core/test/fixtures/factorial.ts" "packages/core/test/fixtures/factorial.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/guards.test.ts" "packages/core/test/guards.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/interpreter.test.ts" "packages/core/test/interpreter.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/invoke.test.ts" "packages/core/test/invoke.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/predictableExec.test.ts" "packages/core/test/predictableExec.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/waitFor.test.ts" "packages/core/test/waitFor.test.ts"
mkdir -p "packages/xstate-scxml/test/fixtures/actionSend"
cp "/tests/packages/xstate-scxml/test/fixtures/actionSend/send1.ts" "packages/xstate-scxml/test/fixtures/actionSend/send1.ts"
mkdir -p "packages/xstate-scxml/test/fixtures/actionSend"
cp "/tests/packages/xstate-scxml/test/fixtures/actionSend/send2.ts" "packages/xstate-scxml/test/fixtures/actionSend/send2.ts"
mkdir -p "packages/xstate-scxml/test/fixtures/actionSend"
cp "/tests/packages/xstate-scxml/test/fixtures/actionSend/send3.ts" "packages/xstate-scxml/test/fixtures/actionSend/send3.ts"
mkdir -p "packages/xstate-scxml/test/fixtures/actionSend"
cp "/tests/packages/xstate-scxml/test/fixtures/actionSend/send4.ts" "packages/xstate-scxml/test/fixtures/actionSend/send4.ts"
mkdir -p "packages/xstate-scxml/test/fixtures/actionSend"
cp "/tests/packages/xstate-scxml/test/fixtures/actionSend/send4b.ts" "packages/xstate-scxml/test/fixtures/actionSend/send4b.ts"
mkdir -p "packages/xstate-scxml/test/fixtures/actionSend"
cp "/tests/packages/xstate-scxml/test/fixtures/actionSend/send7.ts" "packages/xstate-scxml/test/fixtures/actionSend/send7.ts"
mkdir -p "packages/xstate-scxml/test/fixtures/actionSend"
cp "/tests/packages/xstate-scxml/test/fixtures/actionSend/send7b.ts" "packages/xstate-scxml/test/fixtures/actionSend/send7b.ts"
mkdir -p "packages/xstate-scxml/test/fixtures/actionSend"
cp "/tests/packages/xstate-scxml/test/fixtures/actionSend/send8.ts" "packages/xstate-scxml/test/fixtures/actionSend/send8.ts"
mkdir -p "packages/xstate-scxml/test/fixtures/actionSend"
cp "/tests/packages/xstate-scxml/test/fixtures/actionSend/send8b.ts" "packages/xstate-scxml/test/fixtures/actionSend/send8b.ts"
mkdir -p "packages/xstate-scxml/test/fixtures/actionSend"
cp "/tests/packages/xstate-scxml/test/fixtures/actionSend/send9.ts" "packages/xstate-scxml/test/fixtures/actionSend/send9.ts"
mkdir -p "packages/xstate-scxml/test/fixtures/assign-current-small-step"
cp "/tests/packages/xstate-scxml/test/fixtures/assign-current-small-step/test1.ts" "packages/xstate-scxml/test/fixtures/assign-current-small-step/test1.ts"
mkdir -p "packages/xstate-scxml/test/fixtures/assign"
cp "/tests/packages/xstate-scxml/test/fixtures/assign/assign_obj_literal.ts" "packages/xstate-scxml/test/fixtures/assign/assign_obj_literal.ts"
# Rebuild after copying test files to ensure they can import from updated built files
yarn build

# Run Jest on the specific test files for this PR
# Note: xstate-react and xstate-solid tests are excluded due to jest module resolution issues
# in this Docker environment (they try to import 'xstate' package which jest can't resolve)
yarn jest \
  packages/core/test/actionCreators.test.ts \
  packages/core/test/actions.test.ts \
  packages/core/test/after.test.ts \
  packages/core/test/event.test.ts \
  packages/core/test/fixtures/factorial.ts \
  packages/core/test/guards.test.ts \
  packages/core/test/interpreter.test.ts \
  packages/core/test/invoke.test.ts \
  packages/core/test/predictableExec.test.ts \
  packages/core/test/waitFor.test.ts \
  packages/xstate-scxml/test/fixtures/actionSend/send1.ts \
  packages/xstate-scxml/test/fixtures/actionSend/send2.ts \
  packages/xstate-scxml/test/fixtures/actionSend/send3.ts \
  packages/xstate-scxml/test/fixtures/actionSend/send4.ts \
  packages/xstate-scxml/test/fixtures/actionSend/send4b.ts \
  packages/xstate-scxml/test/fixtures/actionSend/send7.ts \
  packages/xstate-scxml/test/fixtures/actionSend/send7b.ts \
  packages/xstate-scxml/test/fixtures/actionSend/send8.ts \
  packages/xstate-scxml/test/fixtures/actionSend/send8b.ts \
  packages/xstate-scxml/test/fixtures/actionSend/send9.ts \
  packages/xstate-scxml/test/fixtures/assign-current-small-step/test1.ts \
  packages/xstate-scxml/test/fixtures/assign/assign_obj_literal.ts \
  --coverage=false --runInBand --no-cache
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
