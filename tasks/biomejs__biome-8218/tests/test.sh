#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noMultiStr"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noMultiStr/invalid.js" "crates/biome_js_analyze/tests/specs/nursery/noMultiStr/invalid.js"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noMultiStr"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noMultiStr/invalid.js.snap" "crates/biome_js_analyze/tests/specs/nursery/noMultiStr/invalid.js.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noMultiStr"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noMultiStr/valid.js" "crates/biome_js_analyze/tests/specs/nursery/noMultiStr/valid.js"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noMultiStr"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noMultiStr/valid.js.snap" "crates/biome_js_analyze/tests/specs/nursery/noMultiStr/valid.js.snap"

# Run the specific tests for noMultiStr
# The tests are in crates/biome_js_analyze/tests/specs/nursery/noMultiStr/
cargo test -p biome_js_analyze no_multi_str -- --nocapture
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
