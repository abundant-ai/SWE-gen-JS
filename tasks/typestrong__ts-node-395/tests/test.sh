#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "src"
cp "/tests/src/index.spec.ts" "src/index.spec.ts"
mkdir -p "tests"
cp "/tests/emit-compiled.ts" "tests/emit-compiled.ts"
mkdir -p "tests"
cp "/tests/jsx-react.tsx" "tests/jsx-react.tsx"
mkdir -p "tests"
cp "/tests/tsconfig.json" "tests/tsconfig.json"

# Reinstall dependencies if package.json changed
npm install --legacy-peer-deps --ignore-scripts

# Rebuild to pick up changes (may have type errors but that's okay)
npm run build || true

# Check if dist folder exists - if not, the build completely failed
if [ ! -d "dist" ]; then
    echo 0 > /logs/verifier/reward.txt
    exit 1
fi

# Test that tsx source maps work correctly with jsx: "react"
# Run ts-node with the tsx file and capture the compiled output
# The emit-compiled.ts script hooks into .tsx compilation to print the compiled JavaScript
# Use --fast mode to skip type checking (emit-compiled.ts itself has no type definitions)
output=$(node dist/bin --fast -O '{"jsx":"react"}' -r ./tests/emit-compiled.ts tests/jsx-react.tsx 2>&1) || true

# Check if the output contains a properly formatted source map URL
# The bug causes the '=' after 'sourceMappingURL' to be missing
if echo "$output" | grep -q '//# sourceMappingURL=data:application/json;charset=utf-8;base64,'; then
    echo 1 > /logs/verifier/reward.txt
    exit 0
else
    echo 0 > /logs/verifier/reward.txt
    exit 1
fi
