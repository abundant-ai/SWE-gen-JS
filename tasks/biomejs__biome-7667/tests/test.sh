#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_cli/tests/snapshots/main_cases_assist"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_assist/assist_emit_diagnostic_but_doesnt_block.snap" "crates/biome_cli/tests/snapshots/main_cases_assist/assist_emit_diagnostic_but_doesnt_block.snap"
mkdir -p "crates/biome_cli/tests/snapshots/main_cases_vcs_ignored_files"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_vcs_ignored_files/ignore_vcs_ignored_file_via_cli.snap" "crates/biome_cli/tests/snapshots/main_cases_vcs_ignored_files/ignore_vcs_ignored_file_via_cli.snap"
mkdir -p "crates/biome_cli/tests/snapshots/main_commands_check"
cp "/tests/crates/biome_cli/tests/snapshots/main_commands_check/print_json.snap" "crates/biome_cli/tests/snapshots/main_commands_check/print_json.snap"
mkdir -p "crates/biome_cli/tests/snapshots/main_commands_check"
cp "/tests/crates/biome_cli/tests/snapshots/main_commands_check/print_json_pretty.snap" "crates/biome_cli/tests/snapshots/main_commands_check/print_json_pretty.snap"
mkdir -p "crates/biome_cli/tests/snapshots/main_commands_check"
cp "/tests/crates/biome_cli/tests/snapshots/main_commands_check/should_not_disable_recommended_rules_for_a_group.snap" "crates/biome_cli/tests/snapshots/main_commands_check/should_not_disable_recommended_rules_for_a_group.snap"
mkdir -p "crates/biome_cli/tests/snapshots/main_commands_format"
cp "/tests/crates/biome_cli/tests/snapshots/main_commands_format/print_json.snap" "crates/biome_cli/tests/snapshots/main_commands_format/print_json.snap"
mkdir -p "crates/biome_cli/tests/snapshots/main_commands_format"
cp "/tests/crates/biome_cli/tests/snapshots/main_commands_format/print_json_pretty.snap" "crates/biome_cli/tests/snapshots/main_commands_format/print_json_pretty.snap"
mkdir -p "crates/biome_cli/tests/snapshots/main_commands_lint"
cp "/tests/crates/biome_cli/tests/snapshots/main_commands_lint/downgrade_severity_info.snap" "crates/biome_cli/tests/snapshots/main_commands_lint/downgrade_severity_info.snap"
mkdir -p "crates/biome_cli/tests/snapshots/main_commands_lint"
cp "/tests/crates/biome_cli/tests/snapshots/main_commands_lint/lint_only_rule_with_config.snap" "crates/biome_cli/tests/snapshots/main_commands_lint/lint_only_rule_with_config.snap"
mkdir -p "crates/biome_cli/tests/snapshots/main_commands_lint"
cp "/tests/crates/biome_cli/tests/snapshots/main_commands_lint/lint_only_rule_with_recommended_disabled.snap" "crates/biome_cli/tests/snapshots/main_commands_lint/lint_only_rule_with_recommended_disabled.snap"
mkdir -p "crates/biome_cli/tests/snapshots/main_commands_lint"
cp "/tests/crates/biome_cli/tests/snapshots/main_commands_lint/linter_can_resolve_imported_symbols.snap" "crates/biome_cli/tests/snapshots/main_commands_lint/linter_can_resolve_imported_symbols.snap"
mkdir -p "crates/biome_cli/tests/snapshots/main_commands_lint"
cp "/tests/crates/biome_cli/tests/snapshots/main_commands_lint/linter_enables_project_domain_based_on_extended_config.snap" "crates/biome_cli/tests/snapshots/main_commands_lint/linter_enables_project_domain_based_on_extended_config.snap"
mkdir -p "crates/biome_cli/tests/snapshots/main_commands_lint"
cp "/tests/crates/biome_cli/tests/snapshots/main_commands_lint/should_not_disable_recommended_rules_for_a_group.snap" "crates/biome_cli/tests/snapshots/main_commands_lint/should_not_disable_recommended_rules_for_a_group.snap"
mkdir -p "crates/biome_cli/tests/snapshots/main_commands_lint"
cp "/tests/crates/biome_cli/tests/snapshots/main_commands_lint/should_report_when_schema_version_mismatch.snap" "crates/biome_cli/tests/snapshots/main_commands_lint/should_report_when_schema_version_mismatch.snap"

# Rebuild the test binary after copying test files
# Touch the test files to ensure cargo detects changes
touch crates/biome_cli/tests/snapshots/main_cases_assist/assist_emit_diagnostic_but_doesnt_block.snap
cargo test -p biome_cli --no-run 2>&1 | grep -v "^warning:" || true

# Run tests for the specific test functions
test_output=""
test_status=0

# Run specific tests by name
output=$(cargo test -p biome_cli assist_emit_diagnostic_but_doesnt_block -- --nocapture 2>&1)
status=$?
test_output+="$output"$'\n'
if [ $status -ne 0 ]; then
  test_status=$status
fi

output=$(cargo test -p biome_cli ignore_vcs_ignored_file_via_cli -- --nocapture 2>&1)
status=$?
test_output+="$output"$'\n'
if [ $status -ne 0 ]; then
  test_status=$status
fi

output=$(cargo test -p biome_cli print_json -- --nocapture 2>&1)
status=$?
test_output+="$output"$'\n'
if [ $status -ne 0 ]; then
  test_status=$status
fi

output=$(cargo test -p biome_cli print_json_pretty -- --nocapture 2>&1)
status=$?
test_output+="$output"$'\n'
if [ $status -ne 0 ]; then
  test_status=$status
fi

output=$(cargo test -p biome_cli should_not_disable_recommended_rules_for_a_group -- --nocapture 2>&1)
status=$?
test_output+="$output"$'\n'
if [ $status -ne 0 ]; then
  test_status=$status
fi

output=$(cargo test -p biome_cli downgrade_severity_info -- --nocapture 2>&1)
status=$?
test_output+="$output"$'\n'
if [ $status -ne 0 ]; then
  test_status=$status
fi

output=$(cargo test -p biome_cli lint_only_rule_with_config -- --nocapture 2>&1)
status=$?
test_output+="$output"$'\n'
if [ $status -ne 0 ]; then
  test_status=$status
fi

output=$(cargo test -p biome_cli lint_only_rule_with_recommended_disabled -- --nocapture 2>&1)
status=$?
test_output+="$output"$'\n'
if [ $status -ne 0 ]; then
  test_status=$status
fi

output=$(cargo test -p biome_cli linter_can_resolve_imported_symbols -- --nocapture 2>&1)
status=$?
test_output+="$output"$'\n'
if [ $status -ne 0 ]; then
  test_status=$status
fi

output=$(cargo test -p biome_cli linter_enables_project_domain_based_on_extended_config -- --nocapture 2>&1)
status=$?
test_output+="$output"$'\n'
if [ $status -ne 0 ]; then
  test_status=$status
fi

output=$(cargo test -p biome_cli should_report_when_schema_version_mismatch -- --nocapture 2>&1)
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
