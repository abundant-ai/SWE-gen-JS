#!/bin/bash

cd /app/src

# Verify the script mode simplification changes from PR #1155
# This PR removes --cwd-mode, removes bin-cwd.ts, and simplifies script mode handling
# The FIX transforms the old complex mode handling into a simpler --dir approach

echo "=== Checking script mode simplification changes ==="

# Check 1: Verify bin-cwd.ts is removed (the fix deletes this file)
if [ ! -f "src/bin-cwd.ts" ]; then
  echo "PASS: src/bin-cwd.ts is removed"
else
  echo "FAIL: src/bin-cwd.ts still exists"
  echo "The fix should remove the bin-cwd.ts file"
  echo 0 > /logs/verifier/reward.txt
  exit 1
fi

# Check 2: Verify ts-node-cwd is removed from package.json bin
if ! grep -q '"ts-node-cwd"' package.json; then
  echo "PASS: ts-node-cwd is removed from package.json bin"
else
  echo "FAIL: ts-node-cwd still in package.json bin"
  echo "The fix should remove the ts-node-cwd binary"
  echo 0 > /logs/verifier/reward.txt
  exit 1
fi

# Check 3: Verify --cwd-mode is removed from bin.ts
if ! grep -q "'--cwd-mode'" src/bin.ts && ! grep -q '"--cwd-mode"' src/bin.ts; then
  echo "PASS: --cwd-mode is removed from bin.ts"
else
  echo "FAIL: --cwd-mode still in bin.ts"
  echo "The fix should remove the --cwd-mode option"
  echo 0 > /logs/verifier/reward.txt
  exit 1
fi

# Check 4: Verify --dir option is used (replaces --cwd)
if grep -q "'--dir': String" src/bin.ts; then
  echo "PASS: --dir option exists in bin.ts"
else
  echo "FAIL: --dir option not found in bin.ts"
  echo "The fix should add the --dir option"
  echo 0 > /logs/verifier/reward.txt
  exit 1
fi

# Check 5: Verify createRequire is not exported from index.ts (made private)
if grep -q "^export const createRequire" src/index.ts || grep -q "^export { createRequire" src/index.ts; then
  echo "FAIL: createRequire is still exported from src/index.ts"
  echo "The fix should make createRequire private (not exported)"
  echo 0 > /logs/verifier/reward.txt
  exit 1
else
  echo "PASS: createRequire is not exported from src/index.ts"
fi

# Check 6: Verify bin-cwd.js export is removed from package.json exports
if ! grep -q "dist/bin-cwd" package.json; then
  echo "PASS: dist/bin-cwd is removed from package.json exports"
else
  echo "FAIL: dist/bin-cwd still in package.json exports"
  echo "The fix should remove the bin-cwd exports"
  echo 0 > /logs/verifier/reward.txt
  exit 1
fi

# Check 7: Verify getCwd function exists instead of getProjectSearchDir
if grep -q "function getCwd" src/bin.ts; then
  echo "PASS: getCwd function exists in bin.ts"
else
  echo "FAIL: getCwd function not found in bin.ts"
  echo "The fix should add getCwd function"
  echo 0 > /logs/verifier/reward.txt
  exit 1
fi

# Check 8: Verify getProjectSearchDir is removed
if ! grep -q "function getProjectSearchDir" src/bin.ts; then
  echo "PASS: getProjectSearchDir is removed from bin.ts"
else
  echo "FAIL: getProjectSearchDir still exists in bin.ts"
  echo "The fix should remove the getProjectSearchDir function"
  echo 0 > /logs/verifier/reward.txt
  exit 1
fi

# Check 9: Verify requireResolveNonCached is removed (part of the simplification)
if ! grep -q "function requireResolveNonCached" src/bin.ts; then
  echo "PASS: requireResolveNonCached is removed from bin.ts"
else
  echo "FAIL: requireResolveNonCached still exists in bin.ts"
  echo "The fix should remove the requireResolveNonCached function"
  echo 0 > /logs/verifier/reward.txt
  exit 1
fi

# Check 10: Verify --scope option is added to the help text in bin.ts
if grep -q "Scope compiler to files within" src/bin.ts; then
  echo "PASS: --scope option exists in bin.ts help"
else
  echo "FAIL: --scope option not found in bin.ts help"
  echo "The fix should add the --scope option to help text"
  echo 0 > /logs/verifier/reward.txt
  exit 1
fi

echo ""
echo "=== All script mode simplification checks passed ==="
echo 1 > /logs/verifier/reward.txt
exit 0
