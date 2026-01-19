#!/bin/bash

cd /app/src

# Check if config file exists in the source (should only exist after fix is applied)
# This is the key test - the bug.patch removes this file, fix.patch adds it back
if [ -f "packages/rtk-query-codegen-openapi/test/config.example.enum.ts" ]; then
  # Config exists - this means fix was applied
  # Reinstall dependencies (fix changes package.json dependencies)
  yarn install

  # Rebuild (TypeScript code changes need recompilation)
  yarn build

  # Verify the feature works by running the CLI with the enum config
  cd packages/rtk-query-codegen-openapi
  mkdir -p test/tmp
  node lib/bin/cli.js test/config.example.enum.ts
  test_status=$?
else
  # Config doesn't exist - this means we're in buggy state (NOP)
  test_status=1
fi

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
