#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_html_analyze/tests/specs/nursery/useVueVForKey"
cp "/tests/crates/biome_html_analyze/tests/specs/nursery/useVueVForKey/invalid.vue" "crates/biome_html_analyze/tests/specs/nursery/useVueVForKey/invalid.vue"
mkdir -p "crates/biome_html_analyze/tests/specs/nursery/useVueVForKey"
cp "/tests/crates/biome_html_analyze/tests/specs/nursery/useVueVForKey/invalid.vue.snap" "crates/biome_html_analyze/tests/specs/nursery/useVueVForKey/invalid.vue.snap"
mkdir -p "crates/biome_html_analyze/tests/specs/nursery/useVueVForKey"
cp "/tests/crates/biome_html_analyze/tests/specs/nursery/useVueVForKey/valid.vue" "crates/biome_html_analyze/tests/specs/nursery/useVueVForKey/valid.vue"
mkdir -p "crates/biome_html_analyze/tests/specs/nursery/useVueVForKey"
cp "/tests/crates/biome_html_analyze/tests/specs/nursery/useVueVForKey/valid.vue.snap" "crates/biome_html_analyze/tests/specs/nursery/useVueVForKey/valid.vue.snap"

# Run the specific test for biome_html_analyze
cargo test -p biome_html_analyze -- --nocapture
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
