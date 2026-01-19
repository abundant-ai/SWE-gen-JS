#!/bin/bash

cd /app/src

export CI=true

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/cli-tests"
cp "/tests/cli-tests/utils.ts" "tests/cli-tests/utils.ts"

# Rebuild the project to pick up any source code changes (e.g., from fix.patch applied by oracle)
pnpm build
build_status=$?

if [ $build_status -ne 0 ]; then
  echo 0 > /logs/verifier/reward.txt
  exit $build_status
fi

# Verify the fix for PR #9692 - --title=prisma flag should be added to all spawn calls
# The fix adds '--title=prisma' to node spawn commands to prevent Windows/Node 22+ crashes

# Check migrate.ts for the --title=prisma flag
migrate_ts="/app/src/packages/core/src/scripts/migrate.ts"
if ! grep -q "'--title=prisma'" "$migrate_ts"; then
  echo "FAILURE: migrate.ts is missing '--title=prisma' flag in spawn command"
  echo 0 > /logs/verifier/reward.txt
  exit 1
fi

# Check prisma.ts for the --title=prisma flag
prisma_ts="/app/src/packages/core/src/scripts/prisma.ts"
if ! grep -q "'--title=prisma'" "$prisma_ts"; then
  echo "FAILURE: prisma.ts is missing '--title=prisma' flag in spawn command"
  echo 0 > /logs/verifier/reward.txt
  exit 1
fi

# Check tests/cli-tests/utils.ts for the --title=prisma flag
utils_ts="/app/src/tests/cli-tests/utils.ts"
if ! grep -q "'--title=prisma'" "$utils_ts"; then
  echo "FAILURE: tests/cli-tests/utils.ts is missing '--title=prisma' flag in spawn command"
  echo 0 > /logs/verifier/reward.txt
  exit 1
fi

echo "SUCCESS: All source files have the '--title=prisma' flag in spawn commands"
test_status=0

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
