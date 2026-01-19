#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_cli/tests/cases"
cp "/tests/crates/biome_cli/tests/cases/mod.rs" "crates/biome_cli/tests/cases/mod.rs"
mkdir -p "crates/biome_cli/tests/cases"
cp "/tests/crates/biome_cli/tests/cases/reporter_rdjson.rs" "crates/biome_cli/tests/cases/reporter_rdjson.rs"
mkdir -p "crates/biome_cli/tests/snapshots/main_cases_reporter_junit"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_reporter_junit/reports_diagnostics_junit_check_command.snap" "crates/biome_cli/tests/snapshots/main_cases_reporter_junit/reports_diagnostics_junit_check_command.snap"
mkdir -p "crates/biome_cli/tests/snapshots/main_cases_reporter_junit"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_reporter_junit/reports_diagnostics_junit_ci_command.snap" "crates/biome_cli/tests/snapshots/main_cases_reporter_junit/reports_diagnostics_junit_ci_command.snap"
mkdir -p "crates/biome_cli/tests/snapshots/main_cases_reporter_junit"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_reporter_junit/reports_diagnostics_junit_lint_command.snap" "crates/biome_cli/tests/snapshots/main_cases_reporter_junit/reports_diagnostics_junit_lint_command.snap"
mkdir -p "crates/biome_cli/tests/snapshots/main_cases_reporter_rdjson"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_reporter_rdjson/reports_diagnostics_rdjson_check_command.snap" "crates/biome_cli/tests/snapshots/main_cases_reporter_rdjson/reports_diagnostics_rdjson_check_command.snap"
mkdir -p "crates/biome_cli/tests/snapshots/main_cases_reporter_rdjson"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_reporter_rdjson/reports_diagnostics_rdjson_ci_command.snap" "crates/biome_cli/tests/snapshots/main_cases_reporter_rdjson/reports_diagnostics_rdjson_ci_command.snap"
mkdir -p "crates/biome_cli/tests/snapshots/main_cases_reporter_rdjson"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_reporter_rdjson/reports_diagnostics_rdjson_format_command.snap" "crates/biome_cli/tests/snapshots/main_cases_reporter_rdjson/reports_diagnostics_rdjson_format_command.snap"
mkdir -p "crates/biome_cli/tests/snapshots/main_cases_reporter_rdjson"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_reporter_rdjson/reports_diagnostics_rdjson_lint_command.snap" "crates/biome_cli/tests/snapshots/main_cases_reporter_rdjson/reports_diagnostics_rdjson_lint_command.snap"
mkdir -p "crates/biome_cli/tests/snapshots/main_commands_check"
cp "/tests/crates/biome_cli/tests/snapshots/main_commands_check/check_help.snap" "crates/biome_cli/tests/snapshots/main_commands_check/check_help.snap"
mkdir -p "crates/biome_cli/tests/snapshots/main_commands_ci"
cp "/tests/crates/biome_cli/tests/snapshots/main_commands_ci/ci_help.snap" "crates/biome_cli/tests/snapshots/main_commands_ci/ci_help.snap"
mkdir -p "crates/biome_cli/tests/snapshots/main_commands_format"
cp "/tests/crates/biome_cli/tests/snapshots/main_commands_format/format_help.snap" "crates/biome_cli/tests/snapshots/main_commands_format/format_help.snap"
mkdir -p "crates/biome_cli/tests/snapshots/main_commands_lint"
cp "/tests/crates/biome_cli/tests/snapshots/main_commands_lint/lint_help.snap" "crates/biome_cli/tests/snapshots/main_commands_lint/lint_help.snap"
mkdir -p "crates/biome_cli/tests/snapshots/main_commands_migrate"
cp "/tests/crates/biome_cli/tests/snapshots/main_commands_migrate/migrate_help.snap" "crates/biome_cli/tests/snapshots/main_commands_migrate/migrate_help.snap"
mkdir -p "crates/biome_cli/tests/snapshots/main_commands_rage"
cp "/tests/crates/biome_cli/tests/snapshots/main_commands_rage/rage_help.snap" "crates/biome_cli/tests/snapshots/main_commands_rage/rage_help.snap"

# Rebuild the test binary after copying test files
# Touch the test files to ensure cargo detects changes
touch crates/biome_cli/tests/cases/mod.rs
touch crates/biome_cli/tests/cases/reporter_rdjson.rs
cargo test -p biome_cli --no-run 2>&1 | grep -v "^warning:" || true

# Run tests for the specific test modules
test_output=""
test_status=0

# Test reporter_rdjson module (includes reporter_junit tests since they're related)
output=$(cargo test -p biome_cli --test main cases::reporter_rdjson -- --nocapture 2>&1)
status=$?
test_output+="$output"$'\n'
if [ $status -ne 0 ]; then
  test_status=$status
fi

# Test reporter_junit module
output=$(cargo test -p biome_cli --test main cases::reporter_junit -- --nocapture 2>&1)
status=$?
test_output+="$output"$'\n'
if [ $status -ne 0 ]; then
  test_status=$status
fi

# Test help commands (check, ci, format, lint, migrate, rage)
output=$(cargo test -p biome_cli --test main commands::check::check_help -- --nocapture 2>&1)
status=$?
test_output+="$output"$'\n'
if [ $status -ne 0 ]; then
  test_status=$status
fi

output=$(cargo test -p biome_cli --test main commands::ci::ci_help -- --nocapture 2>&1)
status=$?
test_output+="$output"$'\n'
if [ $status -ne 0 ]; then
  test_status=$status
fi

output=$(cargo test -p biome_cli --test main commands::format::format_help -- --nocapture 2>&1)
status=$?
test_output+="$output"$'\n'
if [ $status -ne 0 ]; then
  test_status=$status
fi

output=$(cargo test -p biome_cli --test main commands::lint::lint_help -- --nocapture 2>&1)
status=$?
test_output+="$output"$'\n'
if [ $status -ne 0 ]; then
  test_status=$status
fi

output=$(cargo test -p biome_cli --test main commands::migrate::migrate_help -- --nocapture 2>&1)
status=$?
test_output+="$output"$'\n'
if [ $status -ne 0 ]; then
  test_status=$status
fi

output=$(cargo test -p biome_cli --test main commands::rage::rage_help -- --nocapture 2>&1)
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
