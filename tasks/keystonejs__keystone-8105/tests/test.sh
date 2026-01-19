#!/bin/bash

cd /app/src

export CI=true

# Rebuild the project to pick up any source code changes (e.g., from fix.patch applied by oracle)
yarn build
build_status=$?

if [ $build_status -ne 0 ]; then
  echo 0 > /logs/verifier/reward.txt
  exit $build_status
fi

# Verify the fix for PR #8105 - HTTP server should bind to '::' by default
# The fix changes the host from 'localhost' to '::' and updates console output format
dev_ts="/app/src/packages/core/src/scripts/run/dev.ts"
start_ts="/app/src/packages/core/src/scripts/run/start.ts"

# Check for the correct host binding in dev.ts (should be '::' not 'localhost')
if ! grep -q "host: '::'.*// the default for nodejs httpServer" "$dev_ts"; then
  echo "FAILURE: dev.ts is not binding to '::' by default"
  echo 0 > /logs/verifier/reward.txt
  exit 1
fi

# Check for the correct host binding in start.ts (should be '::' not 'localhost')
if ! grep -q "host: '::'.*// the default for nodejs httpServer" "$start_ts"; then
  echo "FAILURE: start.ts is not binding to '::' by default"
  echo 0 > /logs/verifier/reward.txt
  exit 1
fi

# Check for the easyHost variable in dev.ts (part of the fix for display purposes)
if ! grep -q "const easyHost = httpOptions.host === '::' ? 'localhost' : httpOptions.host" "$dev_ts"; then
  echo "FAILURE: dev.ts missing easyHost computation"
  echo 0 > /logs/verifier/reward.txt
  exit 1
fi

# Check for the easyHost variable in start.ts (part of the fix for display purposes)
if ! grep -q "const easyHost = httpOptions.host === '::' ? 'localhost' : httpOptions.host" "$start_ts"; then
  echo "FAILURE: start.ts missing easyHost computation"
  echo 0 > /logs/verifier/reward.txt
  exit 1
fi

# Check for the correct console.log format in dev.ts
if ! grep -q 'Server listening on \${httpOptions.host}, port \${httpOptions.port}' "$dev_ts"; then
  echo "FAILURE: dev.ts has incorrect server listening message format"
  echo 0 > /logs/verifier/reward.txt
  exit 1
fi

# Check for the correct GraphQL API console.log format in dev.ts (separate line)
if ! grep -q 'GraphQL API available at' "$dev_ts"; then
  echo "FAILURE: dev.ts has incorrect GraphQL API message format"
  echo 0 > /logs/verifier/reward.txt
  exit 1
fi

# Check for the correct console.log format in start.ts
if ! grep -q 'Server listening on \${httpOptions.host}, port \${httpOptions.port}' "$start_ts"; then
  echo "FAILURE: start.ts has incorrect server listening message format"
  echo 0 > /logs/verifier/reward.txt
  exit 1
fi

echo "SUCCESS: All source code patterns match the expected fix"
echo 1 > /logs/verifier/reward.txt
exit 0
