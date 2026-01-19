#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_cli/tests/cases"
cp "/tests/crates/biome_cli/tests/cases/handle_astro_files.rs" "crates/biome_cli/tests/cases/handle_astro_files.rs"
mkdir -p "crates/biome_cli/tests/cases"
cp "/tests/crates/biome_cli/tests/cases/handle_svelte_files.rs" "crates/biome_cli/tests/cases/handle_svelte_files.rs"
mkdir -p "crates/biome_cli/tests/cases"
cp "/tests/crates/biome_cli/tests/cases/handle_vue_files.rs" "crates/biome_cli/tests/cases/handle_vue_files.rs"
mkdir -p "crates/biome_cli/tests/snapshots/main_cases_handle_astro_files"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_handle_astro_files/embedded_bindings_are_tracked_correctly.snap" "crates/biome_cli/tests/snapshots/main_cases_handle_astro_files/embedded_bindings_are_tracked_correctly.snap"
mkdir -p "crates/biome_cli/tests/snapshots/main_cases_handle_astro_files"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_handle_astro_files/full_support.snap" "crates/biome_cli/tests/snapshots/main_cases_handle_astro_files/full_support.snap"
mkdir -p "crates/biome_cli/tests/snapshots/main_cases_handle_astro_files"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_handle_astro_files/no_unused_imports_is_not_triggered_in_snippet_sources.snap" "crates/biome_cli/tests/snapshots/main_cases_handle_astro_files/no_unused_imports_is_not_triggered_in_snippet_sources.snap"
mkdir -p "crates/biome_cli/tests/snapshots/main_cases_handle_astro_files"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_handle_astro_files/use_const_not_triggered_in_snippet_sources.snap" "crates/biome_cli/tests/snapshots/main_cases_handle_astro_files/use_const_not_triggered_in_snippet_sources.snap"
mkdir -p "crates/biome_cli/tests/snapshots/main_cases_handle_svelte_files"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_handle_svelte_files/full_support.snap" "crates/biome_cli/tests/snapshots/main_cases_handle_svelte_files/full_support.snap"
mkdir -p "crates/biome_cli/tests/snapshots/main_cases_handle_svelte_files"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_handle_svelte_files/full_support_ts.snap" "crates/biome_cli/tests/snapshots/main_cases_handle_svelte_files/full_support_ts.snap"
mkdir -p "crates/biome_cli/tests/snapshots/main_cases_handle_svelte_files"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_handle_svelte_files/no_unused_imports_is_not_triggered_in_snippet_sources.snap" "crates/biome_cli/tests/snapshots/main_cases_handle_svelte_files/no_unused_imports_is_not_triggered_in_snippet_sources.snap"
mkdir -p "crates/biome_cli/tests/snapshots/main_cases_handle_svelte_files"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_handle_svelte_files/use_const_not_triggered_in_snippet_sources.snap" "crates/biome_cli/tests/snapshots/main_cases_handle_svelte_files/use_const_not_triggered_in_snippet_sources.snap"
mkdir -p "crates/biome_cli/tests/snapshots/main_cases_handle_vue_files"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_handle_vue_files/embedded_bindings_are_tracked_correctly.snap" "crates/biome_cli/tests/snapshots/main_cases_handle_vue_files/embedded_bindings_are_tracked_correctly.snap"
mkdir -p "crates/biome_cli/tests/snapshots/main_cases_handle_vue_files"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_handle_vue_files/full_support.snap" "crates/biome_cli/tests/snapshots/main_cases_handle_vue_files/full_support.snap"
mkdir -p "crates/biome_cli/tests/snapshots/main_cases_handle_vue_files"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_handle_vue_files/full_support_jsx.snap" "crates/biome_cli/tests/snapshots/main_cases_handle_vue_files/full_support_jsx.snap"
mkdir -p "crates/biome_cli/tests/snapshots/main_cases_handle_vue_files"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_handle_vue_files/full_support_ts.snap" "crates/biome_cli/tests/snapshots/main_cases_handle_vue_files/full_support_ts.snap"
mkdir -p "crates/biome_cli/tests/snapshots/main_cases_handle_vue_files"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_handle_vue_files/full_support_tsx.snap" "crates/biome_cli/tests/snapshots/main_cases_handle_vue_files/full_support_tsx.snap"
mkdir -p "crates/biome_cli/tests/snapshots/main_cases_handle_vue_files"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_handle_vue_files/no_unused_imports_is_not_triggered_in_snippet_sources.snap" "crates/biome_cli/tests/snapshots/main_cases_handle_vue_files/no_unused_imports_is_not_triggered_in_snippet_sources.snap"
mkdir -p "crates/biome_cli/tests/snapshots/main_cases_handle_vue_files"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_handle_vue_files/use_const_not_triggered_in_snippet_sources.snap" "crates/biome_cli/tests/snapshots/main_cases_handle_vue_files/use_const_not_triggered_in_snippet_sources.snap"
mkdir -p "crates/biome_cli/tests/snapshots/main_cases_handle_vue_files"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_handle_vue_files/use_import_type_works_as_expected.snap" "crates/biome_cli/tests/snapshots/main_cases_handle_vue_files/use_import_type_works_as_expected.snap"

# Run the specific tests for the three test modules affected by this PR
# The tests are in cases::handle_astro_files, cases::handle_svelte_files, and cases::handle_vue_files
# cargo test doesn't support multiple filters, so we run them sequentially
cargo test -p biome_cli cases::handle_astro_files -- --nocapture && \
cargo test -p biome_cli cases::handle_svelte_files -- --nocapture && \
cargo test -p biome_cli cases::handle_vue_files -- --nocapture
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
