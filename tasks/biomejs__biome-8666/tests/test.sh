#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_html_analyze/tests/specs/a11y/noRedundantAlt"
cp "/tests/crates/biome_html_analyze/tests/specs/a11y/noRedundantAlt/invalid.html" "crates/biome_html_analyze/tests/specs/a11y/noRedundantAlt/invalid.html"
mkdir -p "crates/biome_html_analyze/tests/specs/a11y/noRedundantAlt"
cp "/tests/crates/biome_html_analyze/tests/specs/a11y/noRedundantAlt/invalid.html.snap" "crates/biome_html_analyze/tests/specs/a11y/noRedundantAlt/invalid.html.snap"
mkdir -p "crates/biome_html_analyze/tests/specs/a11y/noRedundantAlt"
cp "/tests/crates/biome_html_analyze/tests/specs/a11y/noRedundantAlt/invalid.vue" "crates/biome_html_analyze/tests/specs/a11y/noRedundantAlt/invalid.vue"
mkdir -p "crates/biome_html_analyze/tests/specs/a11y/noRedundantAlt"
cp "/tests/crates/biome_html_analyze/tests/specs/a11y/noRedundantAlt/invalid.vue.snap" "crates/biome_html_analyze/tests/specs/a11y/noRedundantAlt/invalid.vue.snap"
mkdir -p "crates/biome_html_analyze/tests/specs/a11y/noRedundantAlt"
cp "/tests/crates/biome_html_analyze/tests/specs/a11y/noRedundantAlt/valid.html" "crates/biome_html_analyze/tests/specs/a11y/noRedundantAlt/valid.html"
mkdir -p "crates/biome_html_analyze/tests/specs/a11y/noRedundantAlt"
cp "/tests/crates/biome_html_analyze/tests/specs/a11y/noRedundantAlt/valid.html.snap" "crates/biome_html_analyze/tests/specs/a11y/noRedundantAlt/valid.html.snap"
mkdir -p "crates/biome_html_analyze/tests/specs/a11y/noRedundantAlt"
cp "/tests/crates/biome_html_analyze/tests/specs/a11y/noRedundantAlt/valid.vue" "crates/biome_html_analyze/tests/specs/a11y/noRedundantAlt/valid.vue"
mkdir -p "crates/biome_html_analyze/tests/specs/a11y/noRedundantAlt"
cp "/tests/crates/biome_html_analyze/tests/specs/a11y/noRedundantAlt/valid.vue.snap" "crates/biome_html_analyze/tests/specs/a11y/noRedundantAlt/valid.vue.snap"

# Run the snapshot tests for the biome_html_analyze package
# These tests verify the noRedundantAlt rule for HTML accessibility
cargo test -p biome_html_analyze -- --nocapture
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
