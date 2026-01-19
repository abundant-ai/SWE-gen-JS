#!/bin/bash

cd /app/src

# Set environment variables (from CI config)
export FORCE_COLOR=true
export CI=false

# Define global.self for react-devtools-core compatibility (required by src/devtools.ts)
export NODE_OPTIONS="--require ${PWD}/define-self.js"
cat > define-self.js << 'EOF'
if (!global.self) {
  global.self = global;
}
EOF

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test"
cp "/tests/errors.tsx" "test/errors.tsx"

# Rebuild TypeScript project to pick up any changes (e.g., if Oracle applied fix.patch)
# Need to allow errors due to incompatible dependency types (undici-types, @types/lodash with TS 3.8.3)
cp tsconfig.json tsconfig.json.backup
node -e "const fs=require('fs'); const cfg=JSON.parse(fs.readFileSync('tsconfig.json')); cfg.compilerOptions.noEmitOnError=false; cfg.compilerOptions.skipLibCheck=true; fs.writeFileSync('tsconfig.json', JSON.stringify(cfg, null, '\t'));"
npm run build || true
mv tsconfig.json.backup tsconfig.json

# Run AVA tests for the specific test file
npx ava test/errors.tsx
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
