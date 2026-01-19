#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noReturnAssign"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noReturnAssign/invalid.js" "crates/biome_js_analyze/tests/specs/nursery/noReturnAssign/invalid.js"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noReturnAssign"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noReturnAssign/invalid.js.snap" "crates/biome_js_analyze/tests/specs/nursery/noReturnAssign/invalid.js.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noReturnAssign"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noReturnAssign/invalid.ts" "crates/biome_js_analyze/tests/specs/nursery/noReturnAssign/invalid.ts"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noReturnAssign"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noReturnAssign/invalid.ts.snap" "crates/biome_js_analyze/tests/specs/nursery/noReturnAssign/invalid.ts.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noReturnAssign"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noReturnAssign/valid.js" "crates/biome_js_analyze/tests/specs/nursery/noReturnAssign/valid.js"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noReturnAssign"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noReturnAssign/valid.js.snap" "crates/biome_js_analyze/tests/specs/nursery/noReturnAssign/valid.js.snap"

# Run the specific tests for noReturnAssign
# The tests are in crates/biome_js_analyze/tests/specs/nursery/noReturnAssign/
cargo test -p biome_js_analyze no_return_assign -- --nocapture
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
