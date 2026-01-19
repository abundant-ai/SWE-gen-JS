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
mkdir -p "crates/biome_cli/tests/cases"
cp "/tests/crates/biome_cli/tests/cases/indent_script_and_style.rs" "crates/biome_cli/tests/cases/indent_script_and_style.rs"
mkdir -p "crates/biome_cli/tests/commands"
cp "/tests/crates/biome_cli/tests/commands/format.rs" "crates/biome_cli/tests/commands/format.rs"
mkdir -p "crates/biome_cli/tests/snapshots/main_cases_handle_astro_files"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_handle_astro_files/check_stdin_successfully.snap" "crates/biome_cli/tests/snapshots/main_cases_handle_astro_files/check_stdin_successfully.snap"
mkdir -p "crates/biome_cli/tests/snapshots/main_cases_handle_astro_files"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_handle_astro_files/check_stdin_write_successfully.snap" "crates/biome_cli/tests/snapshots/main_cases_handle_astro_files/check_stdin_write_successfully.snap"
mkdir -p "crates/biome_cli/tests/snapshots/main_cases_handle_astro_files"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_handle_astro_files/check_stdin_write_unsafe_successfully.snap" "crates/biome_cli/tests/snapshots/main_cases_handle_astro_files/check_stdin_write_unsafe_successfully.snap"
mkdir -p "crates/biome_cli/tests/snapshots/main_cases_handle_astro_files"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_handle_astro_files/format_astro_carriage_return_line_feed_files.snap" "crates/biome_cli/tests/snapshots/main_cases_handle_astro_files/format_astro_carriage_return_line_feed_files.snap"
mkdir -p "crates/biome_cli/tests/snapshots/main_cases_handle_astro_files"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_handle_astro_files/format_empty_astro_files_write.snap" "crates/biome_cli/tests/snapshots/main_cases_handle_astro_files/format_empty_astro_files_write.snap"
mkdir -p "crates/biome_cli/tests/snapshots/main_cases_handle_astro_files"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_handle_astro_files/format_stdin_successfully.snap" "crates/biome_cli/tests/snapshots/main_cases_handle_astro_files/format_stdin_successfully.snap"
mkdir -p "crates/biome_cli/tests/snapshots/main_cases_handle_astro_files"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_handle_astro_files/full_support.snap" "crates/biome_cli/tests/snapshots/main_cases_handle_astro_files/full_support.snap"
mkdir -p "crates/biome_cli/tests/snapshots/main_cases_handle_astro_files"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_handle_astro_files/lint_and_fix_astro_files.snap" "crates/biome_cli/tests/snapshots/main_cases_handle_astro_files/lint_and_fix_astro_files.snap"
mkdir -p "crates/biome_cli/tests/snapshots/main_cases_handle_astro_files"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_handle_astro_files/lint_astro_files.snap" "crates/biome_cli/tests/snapshots/main_cases_handle_astro_files/lint_astro_files.snap"
mkdir -p "crates/biome_cli/tests/snapshots/main_cases_handle_astro_files"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_handle_astro_files/lint_stdin_write_unsafe_successfully.snap" "crates/biome_cli/tests/snapshots/main_cases_handle_astro_files/lint_stdin_write_unsafe_successfully.snap"
mkdir -p "crates/biome_cli/tests/snapshots/main_cases_handle_astro_files"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_handle_astro_files/sorts_imports_check.snap" "crates/biome_cli/tests/snapshots/main_cases_handle_astro_files/sorts_imports_check.snap"
mkdir -p "crates/biome_cli/tests/snapshots/main_cases_handle_astro_files"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_handle_astro_files/sorts_imports_write.snap" "crates/biome_cli/tests/snapshots/main_cases_handle_astro_files/sorts_imports_write.snap"
mkdir -p "crates/biome_cli/tests/snapshots/main_cases_handle_svelte_files"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_handle_svelte_files/full_support.snap" "crates/biome_cli/tests/snapshots/main_cases_handle_svelte_files/full_support.snap"
mkdir -p "crates/biome_cli/tests/snapshots/main_cases_handle_svelte_files"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_handle_svelte_files/full_support_ts.snap" "crates/biome_cli/tests/snapshots/main_cases_handle_svelte_files/full_support_ts.snap"
mkdir -p "crates/biome_cli/tests/snapshots/main_cases_handle_svelte_files"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_handle_svelte_files/lint_stdin_write_successfully.snap" "crates/biome_cli/tests/snapshots/main_cases_handle_svelte_files/lint_stdin_write_successfully.snap"
mkdir -p "crates/biome_cli/tests/snapshots/main_cases_handle_svelte_files"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_handle_svelte_files/sorts_imports_check.snap" "crates/biome_cli/tests/snapshots/main_cases_handle_svelte_files/sorts_imports_check.snap"

# Rebuild the test binary after copying test files
# Touch the test files to ensure cargo detects changes
touch crates/biome_cli/tests/cases/handle_astro_files.rs
touch crates/biome_cli/tests/cases/handle_svelte_files.rs
touch crates/biome_cli/tests/cases/handle_vue_files.rs
touch crates/biome_cli/tests/cases/indent_script_and_style.rs
touch crates/biome_cli/tests/commands/format.rs
cargo test -p biome_cli --no-run 2>&1 | grep -v "^warning:" || true

# Run tests for the specific test modules
# Run each test module separately since cargo test doesn't accept multiple test names
test_output=""
test_status=0

# Test handle_astro_files module
output=$(cargo test -p biome_cli --test main cases::handle_astro_files -- --nocapture 2>&1)
status=$?
test_output+="$output"$'\n'
if [ $status -ne 0 ]; then
  test_status=$status
fi

# Test handle_svelte_files module
output=$(cargo test -p biome_cli --test main cases::handle_svelte_files -- --nocapture 2>&1)
status=$?
test_output+="$output"$'\n'
if [ $status -ne 0 ]; then
  test_status=$status
fi

# Test handle_vue_files module (exclude full_support tests as they're not part of this PR)
output=$(cargo test -p biome_cli --test main cases::handle_vue_files -- --nocapture --skip full_support 2>&1)
status=$?
test_output+="$output"$'\n'
if [ $status -ne 0 ]; then
  test_status=$status
fi

# Test indent_script_and_style module
output=$(cargo test -p biome_cli --test main cases::indent_script_and_style -- --nocapture 2>&1)
status=$?
test_output+="$output"$'\n'
if [ $status -ne 0 ]; then
  test_status=$status
fi

# Test format command (exclude tests not related to this PR)
output=$(cargo test -p biome_cli --test main commands::format -- --nocapture --skip format_help --skip html_enabled_by_default 2>&1)
status=$?
test_output+="$output"$'\n'
if [ $status -ne 0 ]; then
  test_status=$status
fi

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
