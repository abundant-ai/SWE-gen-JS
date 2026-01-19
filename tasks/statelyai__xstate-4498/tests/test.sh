#!/bin/bash

set -o pipefail

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/setup.types.test.ts" "packages/core/test/setup.types.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/typegenTypes.test.ts" "packages/core/test/typegenTypes.test.ts"

# Type tests require TypeScript compilation
# Check only core package, filtering errors to our test files
cd packages/core && npx tsc --noEmit --skipLibCheck 2>&1 > /tmp/tsc_output.txt
tsc_exit=$?

# Check if there are type errors in our specific test files
if grep -E "test/(setup\.types\.test\.ts|typegenTypes\.test\.ts)" /tmp/tsc_output.txt > /tmp/test_errors.txt 2>&1; then
  cat /tmp/test_errors.txt | head -200
  test_status=1
else
  # No errors in our test files
  if [ $tsc_exit -eq 0 ]; then
    echo "TypeScript compilation successful - no errors"
    test_status=0
  else
    # There were errors but not in our test files - this is OK (other packages may have issues)
    echo "TypeScript found errors in other files but our test files are clean"
    test_status=0
  fi
fi

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
