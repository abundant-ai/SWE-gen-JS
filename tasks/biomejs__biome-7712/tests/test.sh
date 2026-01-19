#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/useVueDefineMacrosOrder"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/useVueDefineMacrosOrder/invalid-a.vue" "crates/biome_js_analyze/tests/specs/nursery/useVueDefineMacrosOrder/invalid-a.vue"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/useVueDefineMacrosOrder"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/useVueDefineMacrosOrder/invalid-a.vue.snap" "crates/biome_js_analyze/tests/specs/nursery/useVueDefineMacrosOrder/invalid-a.vue.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/useVueDefineMacrosOrder"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/useVueDefineMacrosOrder/invalid-b.vue" "crates/biome_js_analyze/tests/specs/nursery/useVueDefineMacrosOrder/invalid-b.vue"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/useVueDefineMacrosOrder"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/useVueDefineMacrosOrder/invalid-b.vue.snap" "crates/biome_js_analyze/tests/specs/nursery/useVueDefineMacrosOrder/invalid-b.vue.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/useVueDefineMacrosOrder"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/useVueDefineMacrosOrder/invalid-c.vue" "crates/biome_js_analyze/tests/specs/nursery/useVueDefineMacrosOrder/invalid-c.vue"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/useVueDefineMacrosOrder"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/useVueDefineMacrosOrder/invalid-c.vue.snap" "crates/biome_js_analyze/tests/specs/nursery/useVueDefineMacrosOrder/invalid-c.vue.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/useVueDefineMacrosOrder"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/useVueDefineMacrosOrder/invalid-custom.options.json" "crates/biome_js_analyze/tests/specs/nursery/useVueDefineMacrosOrder/invalid-custom.options.json"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/useVueDefineMacrosOrder"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/useVueDefineMacrosOrder/invalid-custom.vue" "crates/biome_js_analyze/tests/specs/nursery/useVueDefineMacrosOrder/invalid-custom.vue"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/useVueDefineMacrosOrder"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/useVueDefineMacrosOrder/invalid-custom.vue.snap" "crates/biome_js_analyze/tests/specs/nursery/useVueDefineMacrosOrder/invalid-custom.vue.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/useVueDefineMacrosOrder"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/useVueDefineMacrosOrder/invalid-single-a.vue" "crates/biome_js_analyze/tests/specs/nursery/useVueDefineMacrosOrder/invalid-single-a.vue"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/useVueDefineMacrosOrder"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/useVueDefineMacrosOrder/invalid-single-a.vue.snap" "crates/biome_js_analyze/tests/specs/nursery/useVueDefineMacrosOrder/invalid-single-a.vue.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/useVueDefineMacrosOrder"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/useVueDefineMacrosOrder/invalid-single.vue" "crates/biome_js_analyze/tests/specs/nursery/useVueDefineMacrosOrder/invalid-single.vue"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/useVueDefineMacrosOrder"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/useVueDefineMacrosOrder/invalid-single.vue.snap" "crates/biome_js_analyze/tests/specs/nursery/useVueDefineMacrosOrder/invalid-single.vue.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/useVueDefineMacrosOrder"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/useVueDefineMacrosOrder/invalid-with-defaults.vue" "crates/biome_js_analyze/tests/specs/nursery/useVueDefineMacrosOrder/invalid-with-defaults.vue"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/useVueDefineMacrosOrder"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/useVueDefineMacrosOrder/invalid-with-defaults.vue.snap" "crates/biome_js_analyze/tests/specs/nursery/useVueDefineMacrosOrder/invalid-with-defaults.vue.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/useVueDefineMacrosOrder"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/useVueDefineMacrosOrder/invalid.vue" "crates/biome_js_analyze/tests/specs/nursery/useVueDefineMacrosOrder/invalid.vue"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/useVueDefineMacrosOrder"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/useVueDefineMacrosOrder/invalid.vue.snap" "crates/biome_js_analyze/tests/specs/nursery/useVueDefineMacrosOrder/invalid.vue.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/useVueDefineMacrosOrder"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/useVueDefineMacrosOrder/valid-custom.options.json" "crates/biome_js_analyze/tests/specs/nursery/useVueDefineMacrosOrder/valid-custom.options.json"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/useVueDefineMacrosOrder"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/useVueDefineMacrosOrder/valid-custom.vue" "crates/biome_js_analyze/tests/specs/nursery/useVueDefineMacrosOrder/valid-custom.vue"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/useVueDefineMacrosOrder"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/useVueDefineMacrosOrder/valid-custom.vue.snap" "crates/biome_js_analyze/tests/specs/nursery/useVueDefineMacrosOrder/valid-custom.vue.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/useVueDefineMacrosOrder"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/useVueDefineMacrosOrder/valid.vue" "crates/biome_js_analyze/tests/specs/nursery/useVueDefineMacrosOrder/valid.vue"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/useVueDefineMacrosOrder"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/useVueDefineMacrosOrder/valid.vue.snap" "crates/biome_js_analyze/tests/specs/nursery/useVueDefineMacrosOrder/valid.vue.snap"

# Rebuild the test binary after copying test files
# Touch the test spec files to ensure cargo detects changes
touch crates/biome_js_analyze/tests/spec_tests.rs
cargo test -p biome_js_analyze --no-run 2>&1 | grep -v "^warning:" || true

# Run tests for the useVueDefineMacrosOrder rule
# The tests are auto-generated from the specs directory by the tests_macros::gen_tests! macro
test_output=$(cargo test -p biome_js_analyze --test spec_tests use_vue_define_macros_order -- --nocapture 2>&1)
test_status=$?
echo "$test_output"

# Check if any tests actually ran
total_tests=$(echo "$test_output" | grep "^running [0-9]* tests" | awk '{sum += $2} END {print sum}')
if [ "$total_tests" = "0" ] || [ -z "$total_tests" ]; then
  echo "ERROR: No tests ran. Test files may be missing." >&2
  echo 0 > /logs/verifier/reward.txt
  exit 1
fi

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
