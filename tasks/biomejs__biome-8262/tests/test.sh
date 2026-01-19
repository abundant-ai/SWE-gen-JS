#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_cli/tests/snapshots/main_cases_handle_astro_files"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_handle_astro_files/full_support.snap" "crates/biome_cli/tests/snapshots/main_cases_handle_astro_files/full_support.snap"
mkdir -p "crates/biome_cli/tests/snapshots/main_cases_handle_svelte_files"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_handle_svelte_files/full_support.snap" "crates/biome_cli/tests/snapshots/main_cases_handle_svelte_files/full_support.snap"
mkdir -p "crates/biome_cli/tests/snapshots/main_cases_handle_svelte_files"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_handle_svelte_files/full_support_ts.snap" "crates/biome_cli/tests/snapshots/main_cases_handle_svelte_files/full_support_ts.snap"
mkdir -p "crates/biome_cli/tests/snapshots/main_cases_handle_vue_files"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_handle_vue_files/full_support.snap" "crates/biome_cli/tests/snapshots/main_cases_handle_vue_files/full_support.snap"
mkdir -p "crates/biome_cli/tests/snapshots/main_cases_handle_vue_files"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_handle_vue_files/full_support_ts.snap" "crates/biome_cli/tests/snapshots/main_cases_handle_vue_files/full_support_ts.snap"
mkdir -p "crates/biome_html_analyze/tests/specs/a11y/useHtmlLang"
cp "/tests/crates/biome_html_analyze/tests/specs/a11y/useHtmlLang/invalid.html" "crates/biome_html_analyze/tests/specs/a11y/useHtmlLang/invalid.html"
mkdir -p "crates/biome_html_analyze/tests/specs/a11y/useHtmlLang"
cp "/tests/crates/biome_html_analyze/tests/specs/a11y/useHtmlLang/invalid.html.snap" "crates/biome_html_analyze/tests/specs/a11y/useHtmlLang/invalid.html.snap"
mkdir -p "crates/biome_html_analyze/tests/specs/a11y/useHtmlLang"
cp "/tests/crates/biome_html_analyze/tests/specs/a11y/useHtmlLang/valid.html" "crates/biome_html_analyze/tests/specs/a11y/useHtmlLang/valid.html"
mkdir -p "crates/biome_html_analyze/tests/specs/a11y/useHtmlLang"
cp "/tests/crates/biome_html_analyze/tests/specs/a11y/useHtmlLang/valid.html.snap" "crates/biome_html_analyze/tests/specs/a11y/useHtmlLang/valid.html.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/a11y/useHtmlLang"
cp "/tests/crates/biome_js_analyze/tests/specs/a11y/useHtmlLang/invalid.jsx.snap" "crates/biome_js_analyze/tests/specs/a11y/useHtmlLang/invalid.jsx.snap"

# Run the specific tests for useHtmlLang
# The tests are in crates/biome_html_analyze/tests/specs/a11y/useHtmlLang/ and crates/biome_js_analyze/tests/specs/a11y/useHtmlLang/
cargo test -p biome_html_analyze use_html_lang -- --nocapture
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
