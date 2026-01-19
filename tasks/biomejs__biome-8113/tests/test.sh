#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_js_analyze/tests/specs/correctness/noInvalidUseBeforeDeclaration"
cp "/tests/crates/biome_js_analyze/tests/specs/correctness/noInvalidUseBeforeDeclaration/enum.ts" "crates/biome_js_analyze/tests/specs/correctness/noInvalidUseBeforeDeclaration/enum.ts"
mkdir -p "crates/biome_js_analyze/tests/specs/correctness/noInvalidUseBeforeDeclaration"
cp "/tests/crates/biome_js_analyze/tests/specs/correctness/noInvalidUseBeforeDeclaration/enum.ts.snap" "crates/biome_js_analyze/tests/specs/correctness/noInvalidUseBeforeDeclaration/enum.ts.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/correctness/noInvalidUseBeforeDeclaration"
cp "/tests/crates/biome_js_analyze/tests/specs/correctness/noInvalidUseBeforeDeclaration/invalid.js" "crates/biome_js_analyze/tests/specs/correctness/noInvalidUseBeforeDeclaration/invalid.js"
mkdir -p "crates/biome_js_analyze/tests/specs/correctness/noInvalidUseBeforeDeclaration"
cp "/tests/crates/biome_js_analyze/tests/specs/correctness/noInvalidUseBeforeDeclaration/invalid.js.snap" "crates/biome_js_analyze/tests/specs/correctness/noInvalidUseBeforeDeclaration/invalid.js.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/correctness/noInvalidUseBeforeDeclaration"
cp "/tests/crates/biome_js_analyze/tests/specs/correctness/noInvalidUseBeforeDeclaration/invalid.ts" "crates/biome_js_analyze/tests/specs/correctness/noInvalidUseBeforeDeclaration/invalid.ts"
mkdir -p "crates/biome_js_analyze/tests/specs/correctness/noInvalidUseBeforeDeclaration"
cp "/tests/crates/biome_js_analyze/tests/specs/correctness/noInvalidUseBeforeDeclaration/invalid.ts.snap" "crates/biome_js_analyze/tests/specs/correctness/noInvalidUseBeforeDeclaration/invalid.ts.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/correctness/noInvalidUseBeforeDeclaration"
cp "/tests/crates/biome_js_analyze/tests/specs/correctness/noInvalidUseBeforeDeclaration/valid.js" "crates/biome_js_analyze/tests/specs/correctness/noInvalidUseBeforeDeclaration/valid.js"
mkdir -p "crates/biome_js_analyze/tests/specs/correctness/noInvalidUseBeforeDeclaration"
cp "/tests/crates/biome_js_analyze/tests/specs/correctness/noInvalidUseBeforeDeclaration/valid.js.snap" "crates/biome_js_analyze/tests/specs/correctness/noInvalidUseBeforeDeclaration/valid.js.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/correctness/noInvalidUseBeforeDeclaration"
cp "/tests/crates/biome_js_analyze/tests/specs/correctness/noInvalidUseBeforeDeclaration/valid.ts" "crates/biome_js_analyze/tests/specs/correctness/noInvalidUseBeforeDeclaration/valid.ts"
mkdir -p "crates/biome_js_analyze/tests/specs/correctness/noInvalidUseBeforeDeclaration"
cp "/tests/crates/biome_js_analyze/tests/specs/correctness/noInvalidUseBeforeDeclaration/valid.ts.snap" "crates/biome_js_analyze/tests/specs/correctness/noInvalidUseBeforeDeclaration/valid.ts.snap"

# Run the noInvalidUseBeforeDeclaration snapshot tests
cargo test -p biome_js_analyze --test spec_tests -- no_invalid_use_before_declaration --nocapture
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
