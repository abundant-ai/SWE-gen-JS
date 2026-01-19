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

# Verify the fix for PR #8132 - server bind address output format
# The fix removes the default 'host: ::' and adds HOST env var support
dev_ts="/app/src/packages/core/src/scripts/run/dev.ts"

# Check for the buggy pattern (host: '::' as default)
if grep -q "host: '::'" "$dev_ts"; then
  echo "FAILURE: Found buggy 'host: ::' default in httpOptions"
  echo 0 > /logs/verifier/reward.txt
  exit 1
fi

# Check for HOST environment variable support
if ! grep -q "process.env.HOST" "$dev_ts"; then
  echo "FAILURE: Missing HOST environment variable support"
  echo 0 > /logs/verifier/reward.txt
  exit 1
fi

# Check for the improved easyHost check
if ! grep -q "undefined.*''.*'::'.*'0.0.0.0'" "$dev_ts" && ! grep -q "\[undefined, '', '::', '0.0.0.0'\]" "$dev_ts"; then
  echo "FAILURE: Missing improved easyHost check for multiple host values"
  echo 0 > /logs/verifier/reward.txt
  exit 1
fi

echo "SUCCESS: All source code patterns match the expected fix"
echo 1 > /logs/verifier/reward.txt
exit 0
