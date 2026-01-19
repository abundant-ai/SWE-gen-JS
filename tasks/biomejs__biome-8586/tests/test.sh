#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_html_analyze/tests/specs/nursery/useVueConsistentVBindStyle"
cp "/tests/crates/biome_html_analyze/tests/specs/nursery/useVueConsistentVBindStyle/invalid.vue" "crates/biome_html_analyze/tests/specs/nursery/useVueConsistentVBindStyle/invalid.vue"
mkdir -p "crates/biome_html_analyze/tests/specs/nursery/useVueConsistentVBindStyle"
cp "/tests/crates/biome_html_analyze/tests/specs/nursery/useVueConsistentVBindStyle/invalid.vue.snap" "crates/biome_html_analyze/tests/specs/nursery/useVueConsistentVBindStyle/invalid.vue.snap"
mkdir -p "crates/biome_html_analyze/tests/specs/nursery/useVueConsistentVBindStyle"
cp "/tests/crates/biome_html_analyze/tests/specs/nursery/useVueConsistentVBindStyle/longhand-invalid.options.json" "crates/biome_html_analyze/tests/specs/nursery/useVueConsistentVBindStyle/longhand-invalid.options.json"
mkdir -p "crates/biome_html_analyze/tests/specs/nursery/useVueConsistentVBindStyle"
cp "/tests/crates/biome_html_analyze/tests/specs/nursery/useVueConsistentVBindStyle/longhand-invalid.vue" "crates/biome_html_analyze/tests/specs/nursery/useVueConsistentVBindStyle/longhand-invalid.vue"
mkdir -p "crates/biome_html_analyze/tests/specs/nursery/useVueConsistentVBindStyle"
cp "/tests/crates/biome_html_analyze/tests/specs/nursery/useVueConsistentVBindStyle/longhand-invalid.vue.snap" "crates/biome_html_analyze/tests/specs/nursery/useVueConsistentVBindStyle/longhand-invalid.vue.snap"
mkdir -p "crates/biome_html_analyze/tests/specs/nursery/useVueConsistentVBindStyle"
cp "/tests/crates/biome_html_analyze/tests/specs/nursery/useVueConsistentVBindStyle/longhand-valid.options.json" "crates/biome_html_analyze/tests/specs/nursery/useVueConsistentVBindStyle/longhand-valid.options.json"
mkdir -p "crates/biome_html_analyze/tests/specs/nursery/useVueConsistentVBindStyle"
cp "/tests/crates/biome_html_analyze/tests/specs/nursery/useVueConsistentVBindStyle/longhand-valid.vue" "crates/biome_html_analyze/tests/specs/nursery/useVueConsistentVBindStyle/longhand-valid.vue"
mkdir -p "crates/biome_html_analyze/tests/specs/nursery/useVueConsistentVBindStyle"
cp "/tests/crates/biome_html_analyze/tests/specs/nursery/useVueConsistentVBindStyle/longhand-valid.vue.snap" "crates/biome_html_analyze/tests/specs/nursery/useVueConsistentVBindStyle/longhand-valid.vue.snap"
mkdir -p "crates/biome_html_analyze/tests/specs/nursery/useVueConsistentVBindStyle"
cp "/tests/crates/biome_html_analyze/tests/specs/nursery/useVueConsistentVBindStyle/valid.vue" "crates/biome_html_analyze/tests/specs/nursery/useVueConsistentVBindStyle/valid.vue"
mkdir -p "crates/biome_html_analyze/tests/specs/nursery/useVueConsistentVBindStyle"
cp "/tests/crates/biome_html_analyze/tests/specs/nursery/useVueConsistentVBindStyle/valid.vue.snap" "crates/biome_html_analyze/tests/specs/nursery/useVueConsistentVBindStyle/valid.vue.snap"
mkdir -p "crates/biome_html_analyze/tests/specs/nursery/useVueConsistentVOnStyle"
cp "/tests/crates/biome_html_analyze/tests/specs/nursery/useVueConsistentVOnStyle/invalid.vue" "crates/biome_html_analyze/tests/specs/nursery/useVueConsistentVOnStyle/invalid.vue"
mkdir -p "crates/biome_html_analyze/tests/specs/nursery/useVueConsistentVOnStyle"
cp "/tests/crates/biome_html_analyze/tests/specs/nursery/useVueConsistentVOnStyle/invalid.vue.snap" "crates/biome_html_analyze/tests/specs/nursery/useVueConsistentVOnStyle/invalid.vue.snap"
mkdir -p "crates/biome_html_analyze/tests/specs/nursery/useVueConsistentVOnStyle"
cp "/tests/crates/biome_html_analyze/tests/specs/nursery/useVueConsistentVOnStyle/longhand-invalid.options.json" "crates/biome_html_analyze/tests/specs/nursery/useVueConsistentVOnStyle/longhand-invalid.options.json"
mkdir -p "crates/biome_html_analyze/tests/specs/nursery/useVueConsistentVOnStyle"
cp "/tests/crates/biome_html_analyze/tests/specs/nursery/useVueConsistentVOnStyle/longhand-invalid.vue" "crates/biome_html_analyze/tests/specs/nursery/useVueConsistentVOnStyle/longhand-invalid.vue"
mkdir -p "crates/biome_html_analyze/tests/specs/nursery/useVueConsistentVOnStyle"
cp "/tests/crates/biome_html_analyze/tests/specs/nursery/useVueConsistentVOnStyle/longhand-invalid.vue.snap" "crates/biome_html_analyze/tests/specs/nursery/useVueConsistentVOnStyle/longhand-invalid.vue.snap"
mkdir -p "crates/biome_html_analyze/tests/specs/nursery/useVueConsistentVOnStyle"
cp "/tests/crates/biome_html_analyze/tests/specs/nursery/useVueConsistentVOnStyle/longhand-valid.options.json" "crates/biome_html_analyze/tests/specs/nursery/useVueConsistentVOnStyle/longhand-valid.options.json"
mkdir -p "crates/biome_html_analyze/tests/specs/nursery/useVueConsistentVOnStyle"
cp "/tests/crates/biome_html_analyze/tests/specs/nursery/useVueConsistentVOnStyle/longhand-valid.vue" "crates/biome_html_analyze/tests/specs/nursery/useVueConsistentVOnStyle/longhand-valid.vue"
mkdir -p "crates/biome_html_analyze/tests/specs/nursery/useVueConsistentVOnStyle"
cp "/tests/crates/biome_html_analyze/tests/specs/nursery/useVueConsistentVOnStyle/longhand-valid.vue.snap" "crates/biome_html_analyze/tests/specs/nursery/useVueConsistentVOnStyle/longhand-valid.vue.snap"
mkdir -p "crates/biome_html_analyze/tests/specs/nursery/useVueConsistentVOnStyle"
cp "/tests/crates/biome_html_analyze/tests/specs/nursery/useVueConsistentVOnStyle/valid.vue" "crates/biome_html_analyze/tests/specs/nursery/useVueConsistentVOnStyle/valid.vue"
mkdir -p "crates/biome_html_analyze/tests/specs/nursery/useVueConsistentVOnStyle"
cp "/tests/crates/biome_html_analyze/tests/specs/nursery/useVueConsistentVOnStyle/valid.vue.snap" "crates/biome_html_analyze/tests/specs/nursery/useVueConsistentVOnStyle/valid.vue.snap"

# Run the specific test for biome_html_analyze
cargo test -p biome_html_analyze -- --nocapture
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
