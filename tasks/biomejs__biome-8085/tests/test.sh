#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noForIn"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noForIn/invalid.js" "crates/biome_js_analyze/tests/specs/nursery/noForIn/invalid.js"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noForIn"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noForIn/invalid.js.snap" "crates/biome_js_analyze/tests/specs/nursery/noForIn/invalid.js.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noForIn"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noForIn/valid.js" "crates/biome_js_analyze/tests/specs/nursery/noForIn/valid.js"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noForIn"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noForIn/valid.js.snap" "crates/biome_js_analyze/tests/specs/nursery/noForIn/valid.js.snap"

# Run the biome_js_analyze spec tests for the noForIn rule
# Using cargo test filter to run only tests matching 'no_for_in' (snake_case)
cargo test -p biome_js_analyze --test spec_tests no_for_in -- --nocapture
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
