#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_js_analyze/tests/specs/suspicious/useIterableCallbackReturn"
cp "/tests/crates/biome_js_analyze/tests/specs/suspicious/useIterableCallbackReturn/checkForEachFalse.js" "crates/biome_js_analyze/tests/specs/suspicious/useIterableCallbackReturn/checkForEachFalse.js"
mkdir -p "crates/biome_js_analyze/tests/specs/suspicious/useIterableCallbackReturn"
cp "/tests/crates/biome_js_analyze/tests/specs/suspicious/useIterableCallbackReturn/checkForEachFalse.js.snap" "crates/biome_js_analyze/tests/specs/suspicious/useIterableCallbackReturn/checkForEachFalse.js.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/suspicious/useIterableCallbackReturn"
cp "/tests/crates/biome_js_analyze/tests/specs/suspicious/useIterableCallbackReturn/checkForEachFalse.options.json" "crates/biome_js_analyze/tests/specs/suspicious/useIterableCallbackReturn/checkForEachFalse.options.json"
mkdir -p "crates/biome_js_analyze/tests/specs/suspicious/useIterableCallbackReturn"
cp "/tests/crates/biome_js_analyze/tests/specs/suspicious/useIterableCallbackReturn/checkForEachTrue.js" "crates/biome_js_analyze/tests/specs/suspicious/useIterableCallbackReturn/checkForEachTrue.js"
mkdir -p "crates/biome_js_analyze/tests/specs/suspicious/useIterableCallbackReturn"
cp "/tests/crates/biome_js_analyze/tests/specs/suspicious/useIterableCallbackReturn/checkForEachTrue.js.snap" "crates/biome_js_analyze/tests/specs/suspicious/useIterableCallbackReturn/checkForEachTrue.js.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/suspicious/useIterableCallbackReturn"
cp "/tests/crates/biome_js_analyze/tests/specs/suspicious/useIterableCallbackReturn/checkForEachTrue.options.json" "crates/biome_js_analyze/tests/specs/suspicious/useIterableCallbackReturn/checkForEachTrue.options.json"

# Run the specific tests for useIterableCallbackReturn with checkForEach options
# The tests are in crates/biome_js_analyze/tests/specs/suspicious/useIterableCallbackReturn/
cargo test -p biome_js_analyze use_iterable_callback_return -- --nocapture
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
