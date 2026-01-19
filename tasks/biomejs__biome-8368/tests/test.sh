#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_js_analyze/tests/specs/style/useUnifiedTypeSignatures"
cp "/tests/crates/biome_js_analyze/tests/specs/style/useUnifiedTypeSignatures/invalid.ts" "crates/biome_js_analyze/tests/specs/style/useUnifiedTypeSignatures/invalid.ts"
mkdir -p "crates/biome_js_analyze/tests/specs/style/useUnifiedTypeSignatures"
cp "/tests/crates/biome_js_analyze/tests/specs/style/useUnifiedTypeSignatures/invalid.ts.snap" "crates/biome_js_analyze/tests/specs/style/useUnifiedTypeSignatures/invalid.ts.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/style/useUnifiedTypeSignatures"
cp "/tests/crates/biome_js_analyze/tests/specs/style/useUnifiedTypeSignatures/invalidJsdoc.options.json" "crates/biome_js_analyze/tests/specs/style/useUnifiedTypeSignatures/invalidJsdoc.options.json"
mkdir -p "crates/biome_js_analyze/tests/specs/style/useUnifiedTypeSignatures"
cp "/tests/crates/biome_js_analyze/tests/specs/style/useUnifiedTypeSignatures/invalidJsdoc.ts" "crates/biome_js_analyze/tests/specs/style/useUnifiedTypeSignatures/invalidJsdoc.ts"
mkdir -p "crates/biome_js_analyze/tests/specs/style/useUnifiedTypeSignatures"
cp "/tests/crates/biome_js_analyze/tests/specs/style/useUnifiedTypeSignatures/invalidJsdoc.ts.snap" "crates/biome_js_analyze/tests/specs/style/useUnifiedTypeSignatures/invalidJsdoc.ts.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/style/useUnifiedTypeSignatures"
cp "/tests/crates/biome_js_analyze/tests/specs/style/useUnifiedTypeSignatures/invalidParams.options.json" "crates/biome_js_analyze/tests/specs/style/useUnifiedTypeSignatures/invalidParams.options.json"
mkdir -p "crates/biome_js_analyze/tests/specs/style/useUnifiedTypeSignatures"
cp "/tests/crates/biome_js_analyze/tests/specs/style/useUnifiedTypeSignatures/invalidParams.ts" "crates/biome_js_analyze/tests/specs/style/useUnifiedTypeSignatures/invalidParams.ts"
mkdir -p "crates/biome_js_analyze/tests/specs/style/useUnifiedTypeSignatures"
cp "/tests/crates/biome_js_analyze/tests/specs/style/useUnifiedTypeSignatures/invalidParams.ts.snap" "crates/biome_js_analyze/tests/specs/style/useUnifiedTypeSignatures/invalidParams.ts.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/style/useUnifiedTypeSignatures"
cp "/tests/crates/biome_js_analyze/tests/specs/style/useUnifiedTypeSignatures/valid.ts" "crates/biome_js_analyze/tests/specs/style/useUnifiedTypeSignatures/valid.ts"
mkdir -p "crates/biome_js_analyze/tests/specs/style/useUnifiedTypeSignatures"
cp "/tests/crates/biome_js_analyze/tests/specs/style/useUnifiedTypeSignatures/valid.ts.snap" "crates/biome_js_analyze/tests/specs/style/useUnifiedTypeSignatures/valid.ts.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/style/useUnifiedTypeSignatures"
cp "/tests/crates/biome_js_analyze/tests/specs/style/useUnifiedTypeSignatures/validJsdoc.options.json" "crates/biome_js_analyze/tests/specs/style/useUnifiedTypeSignatures/validJsdoc.options.json"
mkdir -p "crates/biome_js_analyze/tests/specs/style/useUnifiedTypeSignatures"
cp "/tests/crates/biome_js_analyze/tests/specs/style/useUnifiedTypeSignatures/validJsdoc.ts" "crates/biome_js_analyze/tests/specs/style/useUnifiedTypeSignatures/validJsdoc.ts"
mkdir -p "crates/biome_js_analyze/tests/specs/style/useUnifiedTypeSignatures"
cp "/tests/crates/biome_js_analyze/tests/specs/style/useUnifiedTypeSignatures/validJsdoc.ts.snap" "crates/biome_js_analyze/tests/specs/style/useUnifiedTypeSignatures/validJsdoc.ts.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/style/useUnifiedTypeSignatures"
cp "/tests/crates/biome_js_analyze/tests/specs/style/useUnifiedTypeSignatures/validParams.options.json" "crates/biome_js_analyze/tests/specs/style/useUnifiedTypeSignatures/validParams.options.json"
mkdir -p "crates/biome_js_analyze/tests/specs/style/useUnifiedTypeSignatures"
cp "/tests/crates/biome_js_analyze/tests/specs/style/useUnifiedTypeSignatures/validParams.ts" "crates/biome_js_analyze/tests/specs/style/useUnifiedTypeSignatures/validParams.ts"
mkdir -p "crates/biome_js_analyze/tests/specs/style/useUnifiedTypeSignatures"
cp "/tests/crates/biome_js_analyze/tests/specs/style/useUnifiedTypeSignatures/validParams.ts.snap" "crates/biome_js_analyze/tests/specs/style/useUnifiedTypeSignatures/validParams.ts.snap"

# Run the specific style tests for useUnifiedTypeSignatures in JS analyzer
# The test files are in style/useUnifiedTypeSignatures directory
# Running spec_tests matching use_unified_type_signatures test name pattern
cargo test -p biome_js_analyze --test spec_tests use_unified_type_signatures -- --nocapture
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
