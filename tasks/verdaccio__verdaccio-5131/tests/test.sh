#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/config/test"
cp "/tests/packages/config/test/package-access.spec.ts" "packages/config/test/package-access.spec.ts"
mkdir -p "packages/config/test/partials/config/yaml"
cp "/tests/packages/config/test/partials/config/yaml/pkgs-multi-proxy.yaml" "packages/config/test/partials/config/yaml/pkgs-multi-proxy.yaml"
mkdir -p "packages/config/test"
cp "/tests/packages/config/test/uplinks.spec.ts" "packages/config/test/uplinks.spec.ts"
mkdir -p "packages/proxy/test/conf"
cp "/tests/packages/proxy/test/conf/multi-proxy.yaml" "packages/proxy/test/conf/multi-proxy.yaml"
mkdir -p "packages/proxy/test"
cp "/tests/packages/proxy/test/headers.auth.spec.ts" "packages/proxy/test/headers.auth.spec.ts"
mkdir -p "packages/proxy/test"
cp "/tests/packages/proxy/test/noProxy.spec.ts" "packages/proxy/test/noProxy.spec.ts"
mkdir -p "packages/proxy/test"
cp "/tests/packages/proxy/test/proxy.error.___.ts" "packages/proxy/test/proxy.error.___.ts"
mkdir -p "packages/proxy/test"
cp "/tests/packages/proxy/test/proxy.metadata.spec.ts" "packages/proxy/test/proxy.metadata.spec.ts"
mkdir -p "packages/proxy/test"
cp "/tests/packages/proxy/test/proxy.protocol.spec.ts" "packages/proxy/test/proxy.protocol.spec.ts"
mkdir -p "packages/proxy/test"
cp "/tests/packages/proxy/test/proxy.search.spec.ts" "packages/proxy/test/proxy.search.spec.ts"
mkdir -p "packages/proxy/test"
cp "/tests/packages/proxy/test/proxy.tarball.spec.ts" "packages/proxy/test/proxy.tarball.spec.ts"
mkdir -p "packages/proxy/test"
cp "/tests/packages/proxy/test/uplink-util.spec.ts" "packages/proxy/test/uplink-util.spec.ts"
mkdir -p "packages/store/test"
cp "/tests/packages/store/test/storage.spec.ts" "packages/store/test/storage.spec.ts"
mkdir -p "packages/utils/test"
cp "/tests/packages/utils/test/matcher.spec.ts" "packages/utils/test/matcher.spec.ts"

# Rebuild after applying fix.patch (TypeScript changes need recompilation)
pnpm build

# Run vitest on the specific test files for this PR (excluding YAML config files)
npx vitest run \
  packages/config/test/package-access.spec.ts \
  packages/config/test/uplinks.spec.ts \
  packages/proxy/test/headers.auth.spec.ts \
  packages/proxy/test/noProxy.spec.ts \
  packages/proxy/test/proxy.error.___.ts \
  packages/proxy/test/proxy.metadata.spec.ts \
  packages/proxy/test/proxy.protocol.spec.ts \
  packages/proxy/test/proxy.search.spec.ts \
  packages/proxy/test/proxy.tarball.spec.ts \
  packages/proxy/test/uplink-util.spec.ts \
  packages/store/test/storage.spec.ts \
  packages/utils/test/matcher.spec.ts \
  --coverage.enabled=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
