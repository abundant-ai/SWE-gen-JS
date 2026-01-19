#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_css_analyze/tests"
cp "/tests/crates/biome_css_analyze/tests/spec_tests.rs" "crates/biome_css_analyze/tests/spec_tests.rs"
mkdir -p "crates/biome_graphql_analyze/tests"
cp "/tests/crates/biome_graphql_analyze/tests/spec_tests.rs" "crates/biome_graphql_analyze/tests/spec_tests.rs"
mkdir -p "crates/biome_js_analyze/tests"
cp "/tests/crates/biome_js_analyze/tests/spec_tests.rs" "crates/biome_js_analyze/tests/spec_tests.rs"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/useConsistentArrowReturn"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/useConsistentArrowReturn/always.invalid.js" "crates/biome_js_analyze/tests/specs/nursery/useConsistentArrowReturn/always.invalid.js"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/useConsistentArrowReturn"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/useConsistentArrowReturn/always.invalid.js.snap" "crates/biome_js_analyze/tests/specs/nursery/useConsistentArrowReturn/always.invalid.js.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/useConsistentArrowReturn"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/useConsistentArrowReturn/always.invalid.options.json" "crates/biome_js_analyze/tests/specs/nursery/useConsistentArrowReturn/always.invalid.options.json"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/useConsistentArrowReturn"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/useConsistentArrowReturn/always.valid.js" "crates/biome_js_analyze/tests/specs/nursery/useConsistentArrowReturn/always.valid.js"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/useConsistentArrowReturn"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/useConsistentArrowReturn/always.valid.js.snap" "crates/biome_js_analyze/tests/specs/nursery/useConsistentArrowReturn/always.valid.js.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/useConsistentArrowReturn"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/useConsistentArrowReturn/always.valid.options.json" "crates/biome_js_analyze/tests/specs/nursery/useConsistentArrowReturn/always.valid.options.json"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/useConsistentArrowReturn"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/useConsistentArrowReturn/never.invalid.js" "crates/biome_js_analyze/tests/specs/nursery/useConsistentArrowReturn/never.invalid.js"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/useConsistentArrowReturn"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/useConsistentArrowReturn/never.invalid.js.snap" "crates/biome_js_analyze/tests/specs/nursery/useConsistentArrowReturn/never.invalid.js.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/useConsistentArrowReturn"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/useConsistentArrowReturn/never.invalid.options.json" "crates/biome_js_analyze/tests/specs/nursery/useConsistentArrowReturn/never.invalid.options.json"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/useConsistentArrowReturn"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/useConsistentArrowReturn/never.valid.js" "crates/biome_js_analyze/tests/specs/nursery/useConsistentArrowReturn/never.valid.js"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/useConsistentArrowReturn"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/useConsistentArrowReturn/never.valid.js.snap" "crates/biome_js_analyze/tests/specs/nursery/useConsistentArrowReturn/never.valid.js.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/useConsistentArrowReturn"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/useConsistentArrowReturn/never.valid.options.json" "crates/biome_js_analyze/tests/specs/nursery/useConsistentArrowReturn/never.valid.options.json"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/useConsistentArrowReturn"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/useConsistentArrowReturn/requireReturn.invalid.js" "crates/biome_js_analyze/tests/specs/nursery/useConsistentArrowReturn/requireReturn.invalid.js"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/useConsistentArrowReturn"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/useConsistentArrowReturn/requireReturn.invalid.js.snap" "crates/biome_js_analyze/tests/specs/nursery/useConsistentArrowReturn/requireReturn.invalid.js.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/useConsistentArrowReturn"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/useConsistentArrowReturn/requireReturn.invalid.options.json" "crates/biome_js_analyze/tests/specs/nursery/useConsistentArrowReturn/requireReturn.invalid.options.json"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/useConsistentArrowReturn"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/useConsistentArrowReturn/requireReturn.valid.js" "crates/biome_js_analyze/tests/specs/nursery/useConsistentArrowReturn/requireReturn.valid.js"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/useConsistentArrowReturn"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/useConsistentArrowReturn/requireReturn.valid.js.snap" "crates/biome_js_analyze/tests/specs/nursery/useConsistentArrowReturn/requireReturn.valid.js.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/useConsistentArrowReturn"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/useConsistentArrowReturn/requireReturn.valid.options.json" "crates/biome_js_analyze/tests/specs/nursery/useConsistentArrowReturn/requireReturn.valid.options.json"
mkdir -p "crates/biome_js_transform/tests"
cp "/tests/crates/biome_js_transform/tests/spec_tests.rs" "crates/biome_js_transform/tests/spec_tests.rs"
mkdir -p "crates/biome_json_analyze/tests"
cp "/tests/crates/biome_json_analyze/tests/spec_tests.rs" "crates/biome_json_analyze/tests/spec_tests.rs"

# Run specific tests for this PR
cargo test -p biome_js_analyze --test spec_tests use_consistent_arrow_return -- --nocapture
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
