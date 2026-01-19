#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/middleware/test"
cp "/tests/packages/middleware/test/encode.spec.ts" "packages/middleware/test/encode.spec.ts"
mkdir -p "packages/middleware/test"
cp "/tests/packages/middleware/test/make-url-relative.spec.ts" "packages/middleware/test/make-url-relative.spec.ts"
mkdir -p "packages/proxy/test"
cp "/tests/packages/proxy/test/proxy.search.spec.ts" "packages/proxy/test/proxy.search.spec.ts"

# Rebuild after applying fix.patch (TypeScript changes need recompilation)
pnpm build

# Run vitest on the specific test files for this PR
TZ=UTC npx vitest run \
  packages/middleware/test/encode.spec.ts \
  packages/middleware/test/make-url-relative.spec.ts \
  packages/proxy/test/proxy.search.spec.ts \
  --coverage.enabled=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
