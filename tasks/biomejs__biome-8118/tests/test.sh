#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_js_analyze/tests/specs/a11y/useValidLang"
cp "/tests/crates/biome_js_analyze/tests/specs/a11y/useValidLang/invalid.jsx" "crates/biome_js_analyze/tests/specs/a11y/useValidLang/invalid.jsx"
mkdir -p "crates/biome_js_analyze/tests/specs/a11y/useValidLang"
cp "/tests/crates/biome_js_analyze/tests/specs/a11y/useValidLang/invalid.jsx.snap" "crates/biome_js_analyze/tests/specs/a11y/useValidLang/invalid.jsx.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/a11y/useValidLang"
cp "/tests/crates/biome_js_analyze/tests/specs/a11y/useValidLang/valid.jsx" "crates/biome_js_analyze/tests/specs/a11y/useValidLang/valid.jsx"
mkdir -p "crates/biome_js_analyze/tests/specs/a11y/useValidLang"
cp "/tests/crates/biome_js_analyze/tests/specs/a11y/useValidLang/valid.jsx.snap" "crates/biome_js_analyze/tests/specs/a11y/useValidLang/valid.jsx.snap"

# Run the useValidLang snapshot tests
cargo test -p biome_js_analyze --test spec_tests -- use_valid_lang --nocapture
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
