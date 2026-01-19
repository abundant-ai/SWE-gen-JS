#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_html_analyze/tests/specs/nursery/noDuplicateAttributes"
cp "/tests/crates/biome_html_analyze/tests/specs/nursery/noDuplicateAttributes/invalid.html" "crates/biome_html_analyze/tests/specs/nursery/noDuplicateAttributes/invalid.html"
mkdir -p "crates/biome_html_analyze/tests/specs/nursery/noDuplicateAttributes"
cp "/tests/crates/biome_html_analyze/tests/specs/nursery/noDuplicateAttributes/invalid.html.snap" "crates/biome_html_analyze/tests/specs/nursery/noDuplicateAttributes/invalid.html.snap"
mkdir -p "crates/biome_html_analyze/tests/specs/nursery/noDuplicateAttributes"
cp "/tests/crates/biome_html_analyze/tests/specs/nursery/noDuplicateAttributes/invalid.vue" "crates/biome_html_analyze/tests/specs/nursery/noDuplicateAttributes/invalid.vue"
mkdir -p "crates/biome_html_analyze/tests/specs/nursery/noDuplicateAttributes"
cp "/tests/crates/biome_html_analyze/tests/specs/nursery/noDuplicateAttributes/invalid.vue.snap" "crates/biome_html_analyze/tests/specs/nursery/noDuplicateAttributes/invalid.vue.snap"
mkdir -p "crates/biome_html_analyze/tests/specs/nursery/noDuplicateAttributes"
cp "/tests/crates/biome_html_analyze/tests/specs/nursery/noDuplicateAttributes/valid.html" "crates/biome_html_analyze/tests/specs/nursery/noDuplicateAttributes/valid.html"
mkdir -p "crates/biome_html_analyze/tests/specs/nursery/noDuplicateAttributes"
cp "/tests/crates/biome_html_analyze/tests/specs/nursery/noDuplicateAttributes/valid.html.snap" "crates/biome_html_analyze/tests/specs/nursery/noDuplicateAttributes/valid.html.snap"
mkdir -p "crates/biome_html_analyze/tests/specs/nursery/noDuplicateAttributes"
cp "/tests/crates/biome_html_analyze/tests/specs/nursery/noDuplicateAttributes/valid.vue" "crates/biome_html_analyze/tests/specs/nursery/noDuplicateAttributes/valid.vue"
mkdir -p "crates/biome_html_analyze/tests/specs/nursery/noDuplicateAttributes"
cp "/tests/crates/biome_html_analyze/tests/specs/nursery/noDuplicateAttributes/valid.vue.snap" "crates/biome_html_analyze/tests/specs/nursery/noDuplicateAttributes/valid.vue.snap"

# Run the snapshot tests for the biome_html_analyze package
# These tests verify the noDuplicateAttributes rule for HTML
cargo test -p biome_html_analyze -- --nocapture
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
