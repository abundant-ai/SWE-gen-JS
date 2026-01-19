#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_js_analyze/tests/specs/suspicious/noRedeclare"
cp "/tests/crates/biome_js_analyze/tests/specs/suspicious/noRedeclare/valid-conditional-type.ts" "crates/biome_js_analyze/tests/specs/suspicious/noRedeclare/valid-conditional-type.ts"
mkdir -p "crates/biome_js_analyze/tests/specs/suspicious/noRedeclare"
cp "/tests/crates/biome_js_analyze/tests/specs/suspicious/noRedeclare/valid-conditional-type.ts.snap" "crates/biome_js_analyze/tests/specs/suspicious/noRedeclare/valid-conditional-type.ts.snap"

# Run the specific JS analyzer tests affected by this PR
# The test files are in suspicious/noRedeclare/valid-conditional-type.ts
# Running all suspicious tests (narrow enough to be fast, broad enough to catch the test)
cargo test -p biome_js_analyze --test spec_tests suspicious -- --nocapture
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
