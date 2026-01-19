#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_js_analyze/tests/specs/style/useConsistentCurlyBraces"
cp "/tests/crates/biome_js_analyze/tests/specs/style/useConsistentCurlyBraces/invalid.jsx" "crates/biome_js_analyze/tests/specs/style/useConsistentCurlyBraces/invalid.jsx"
mkdir -p "crates/biome_js_analyze/tests/specs/style/useConsistentCurlyBraces"
cp "/tests/crates/biome_js_analyze/tests/specs/style/useConsistentCurlyBraces/invalid.jsx.snap" "crates/biome_js_analyze/tests/specs/style/useConsistentCurlyBraces/invalid.jsx.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/style/useConsistentCurlyBraces"
cp "/tests/crates/biome_js_analyze/tests/specs/style/useConsistentCurlyBraces/valid.jsx" "crates/biome_js_analyze/tests/specs/style/useConsistentCurlyBraces/valid.jsx"
mkdir -p "crates/biome_js_analyze/tests/specs/style/useConsistentCurlyBraces"
cp "/tests/crates/biome_js_analyze/tests/specs/style/useConsistentCurlyBraces/valid.jsx.snap" "crates/biome_js_analyze/tests/specs/style/useConsistentCurlyBraces/valid.jsx.snap"

# Run specific tests for this PR
cargo test -p biome_js_analyze --test spec_tests use_consistent_curly_braces -- --nocapture
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
