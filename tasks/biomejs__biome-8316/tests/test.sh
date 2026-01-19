#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noMultiAssign"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noMultiAssign/invalid.js" "crates/biome_js_analyze/tests/specs/nursery/noMultiAssign/invalid.js"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noMultiAssign"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noMultiAssign/invalid.js.snap" "crates/biome_js_analyze/tests/specs/nursery/noMultiAssign/invalid.js.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noMultiAssign"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noMultiAssign/valid.js" "crates/biome_js_analyze/tests/specs/nursery/noMultiAssign/valid.js"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noMultiAssign"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noMultiAssign/valid.js.snap" "crates/biome_js_analyze/tests/specs/nursery/noMultiAssign/valid.js.snap"

# Run the specific test for noMultiAssign
# The test is in crates/biome_js_analyze/tests/specs/nursery/noMultiAssign/
cargo test -p biome_js_analyze no_multi_assign -- --nocapture
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
