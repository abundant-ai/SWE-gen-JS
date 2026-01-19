#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_html_analyze/tests/specs/a11y/noPositiveTabindex"
cp "/tests/crates/biome_html_analyze/tests/specs/a11y/noPositiveTabindex/invalid.html" "crates/biome_html_analyze/tests/specs/a11y/noPositiveTabindex/invalid.html"
mkdir -p "crates/biome_html_analyze/tests/specs/a11y/noPositiveTabindex"
cp "/tests/crates/biome_html_analyze/tests/specs/a11y/noPositiveTabindex/invalid.html.snap" "crates/biome_html_analyze/tests/specs/a11y/noPositiveTabindex/invalid.html.snap"
mkdir -p "crates/biome_html_analyze/tests/specs/a11y/noPositiveTabindex"
cp "/tests/crates/biome_html_analyze/tests/specs/a11y/noPositiveTabindex/valid.html" "crates/biome_html_analyze/tests/specs/a11y/noPositiveTabindex/valid.html"
mkdir -p "crates/biome_html_analyze/tests/specs/a11y/noPositiveTabindex"
cp "/tests/crates/biome_html_analyze/tests/specs/a11y/noPositiveTabindex/valid.html.snap" "crates/biome_html_analyze/tests/specs/a11y/noPositiveTabindex/valid.html.snap"

# Run the specific tests for the a11y rule affected by this PR
# The affected rule is: noPositiveTabindex
cargo test -p biome_html_analyze --test spec_tests specs::a11y -- --nocapture
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
