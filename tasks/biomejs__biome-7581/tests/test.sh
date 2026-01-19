#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_css_analyze/tests/specs/suspicious/noDuplicateProperties"
cp "/tests/crates/biome_css_analyze/tests/specs/suspicious/noDuplicateProperties/invalid.css" "crates/biome_css_analyze/tests/specs/suspicious/noDuplicateProperties/invalid.css"
mkdir -p "crates/biome_css_analyze/tests/specs/suspicious/noDuplicateProperties"
cp "/tests/crates/biome_css_analyze/tests/specs/suspicious/noDuplicateProperties/invalid.css.snap" "crates/biome_css_analyze/tests/specs/suspicious/noDuplicateProperties/invalid.css.snap"
mkdir -p "crates/biome_css_analyze/tests/specs/suspicious/noDuplicateProperties"
cp "/tests/crates/biome_css_analyze/tests/specs/suspicious/noDuplicateProperties/valid.css" "crates/biome_css_analyze/tests/specs/suspicious/noDuplicateProperties/valid.css"
mkdir -p "crates/biome_css_analyze/tests/specs/suspicious/noDuplicateProperties"
cp "/tests/crates/biome_css_analyze/tests/specs/suspicious/noDuplicateProperties/valid.css.snap" "crates/biome_css_analyze/tests/specs/suspicious/noDuplicateProperties/valid.css.snap"

# Run tests for the noDuplicateProperties rule
cargo test -p biome_css_analyze no_duplicate_properties -- --nocapture
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
