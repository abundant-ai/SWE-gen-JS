#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "src"
cp "/tests/src/index.spec.ts" "src/index.spec.ts"
mkdir -p "tests/tsconfig-options"
cp "/tests/tsconfig-options/log-options.js" "tests/tsconfig-options/log-options.js"
mkdir -p "tests/tsconfig-options"
cp "/tests/tsconfig-options/tsconfig.json" "tests/tsconfig-options/tsconfig.json"

# Reinstall dependencies if package.json or package-lock.json changed
npm install --legacy-peer-deps --ignore-scripts

# Patch create-merged-schema to handle network errors gracefully if it exists
if [ -f "scripts/create-merged-schema.ts" ]; then
    sed -i 's/^main();$/main().catch(() => { console.error("Schema merge failed, continuing..."); process.exit(0); });/' scripts/create-merged-schema.ts
fi

# Build must succeed - failing means fix is incomplete
if ! npm run build; then
    echo 0 > /logs/verifier/reward.txt
    exit 1
fi

# Run the specific test file for this PR
npx mocha dist/index.spec.js -R spec --bail
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
