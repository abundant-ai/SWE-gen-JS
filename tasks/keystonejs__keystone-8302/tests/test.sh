#!/bin/bash

cd /app/src

# Set environment variables for tests
export CI=true

# Rebuild the project to pick up any source code changes (e.g., from fix.patch applied by oracle)
yarn build
build_status=$?

if [ $build_status -ne 0 ]; then
  echo 0 > /logs/verifier/reward.txt
  exit $build_status
fi

# Test the fix for PR #8302 - --reset-db flag removal from `keystone dev`
#
# In HEAD (fixed), running `keystone dev --reset-db` should fail with:
#   "Option 'resetDb' is unsupported for this command"
# because the defaultFlags function checks if flags are in the allowed defaults.
#
# In BASE (buggy), `keystone dev --reset-db` would be accepted.

# Create a minimal test project directory
test_project=$(mktemp -d)
cd "$test_project"

# Create minimal keystone config
cat > keystone.ts << 'KEYSTONECONFIG'
import { config } from '@keystone-6/core';
import { list } from '@keystone-6/core';
import { text } from '@keystone-6/core/fields';

export default config({
  db: {
    provider: 'sqlite',
    url: 'file:./app.db',
  },
  lists: {
    Todo: list({
      fields: {
        title: text(),
      },
    }),
  },
});
KEYSTONECONFIG

# Link to keystone packages
mkdir -p node_modules
ln -s /app/src/packages/core node_modules/@keystone-6
ln -s /app/src/node_modules/@prisma node_modules/@prisma
ln -s /app/src/node_modules/prisma node_modules/prisma
ln -s /app/src/node_modules/typescript node_modules/typescript
ln -s /app/src/node_modules/graphql node_modules/graphql
ln -s /app/src/node_modules/next node_modules/next
ln -s /app/src/node_modules/react node_modules/react
ln -s /app/src/node_modules/react-dom node_modules/react-dom

# Run keystone dev with --reset-db and capture the output
output=$(timeout 10 node /app/src/packages/core/bin/cli.js dev --reset-db 2>&1) || true
exit_code=$?

# Clean up
cd /app/src
rm -rf "$test_project"

# Check if the error message indicates unsupported option (HEAD/fixed behavior)
if echo "$output" | grep -q "unsupported for this command"; then
  echo "SUCCESS: --reset-db flag correctly rejected"
  echo 1 > /logs/verifier/reward.txt
  exit 0
else
  echo "FAILURE: --reset-db flag was not rejected"
  echo "Output was: $output"
  echo 0 > /logs/verifier/reward.txt
  exit 1
fi
