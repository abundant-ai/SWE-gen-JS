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

# Verify the fix for PR #8115 - initFirstItem bypass when ui.isAccessAllowed is defined
# The fix adds hasInitFirstItemConditions and attemptRedirects functions and changes isAccessAllowed behavior
auth_index="/app/src/packages/auth/src/index.ts"

# Check for the hasInitFirstItemConditions function (introduced by the fix)
if ! grep -q "async function hasInitFirstItemConditions" "$auth_index"; then
  echo "FAILURE: Missing hasInitFirstItemConditions function"
  echo 0 > /logs/verifier/reward.txt
  exit 1
fi

# Check for the attemptRedirects function (introduced by the fix)
if ! grep -q "async function attemptRedirects" "$auth_index"; then
  echo "FAILURE: Missing attemptRedirects function"
  echo 0 > /logs/verifier/reward.txt
  exit 1
fi

# Check for the fixed isAccessAllowed that checks hasInitFirstItemConditions first
if ! grep -q "hasInitFirstItemConditions(context)" "$auth_index"; then
  echo "FAILURE: isAccessAllowed doesn't check hasInitFirstItemConditions"
  echo 0 > /logs/verifier/reward.txt
  exit 1
fi

# Check for authPublicPages (fix renames publicPages to authPublicPages)
if ! grep -q "authPublicPages" "$auth_index"; then
  echo "FAILURE: Missing authPublicPages variable"
  echo 0 > /logs/verifier/reward.txt
  exit 1
fi

# Check for authGetAdditionalFiles (fix renames getAdditionalFiles to authGetAdditionalFiles)
if ! grep -q "authGetAdditionalFiles" "$auth_index"; then
  echo "FAILURE: Missing authGetAdditionalFiles function"
  echo 0 > /logs/verifier/reward.txt
  exit 1
fi

echo "SUCCESS: All source code patterns match the expected fix"
echo 1 > /logs/verifier/reward.txt
exit 0
