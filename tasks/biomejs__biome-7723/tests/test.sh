#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_cli/tests/cases"
cp "/tests/crates/biome_cli/tests/cases/css_parsing.rs" "crates/biome_cli/tests/cases/css_parsing.rs"
cp "/tests/crates/biome_cli/tests/cases/format_with_errors.rs" "crates/biome_cli/tests/cases/format_with_errors.rs"
cp "/tests/crates/biome_cli/tests/cases/json_parsing.rs" "crates/biome_cli/tests/cases/json_parsing.rs"
cp "/tests/crates/biome_cli/tests/cases/mod.rs" "crates/biome_cli/tests/cases/mod.rs"

mkdir -p "crates/biome_cli/tests/snapshots/main_cases_css_parsing"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_css_parsing/check_combined_css_parser_flags.snap" "crates/biome_cli/tests/snapshots/main_cases_css_parsing/check_combined_css_parser_flags.snap"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_css_parsing/check_combined_format_with_errors_and_css_modules.snap" "crates/biome_cli/tests/snapshots/main_cases_css_parsing/check_combined_format_with_errors_and_css_modules.snap"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_css_parsing/check_css_parse_css_modules_false.snap" "crates/biome_cli/tests/snapshots/main_cases_css_parsing/check_css_parse_css_modules_false.snap"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_css_parsing/check_css_parse_css_modules_true.snap" "crates/biome_cli/tests/snapshots/main_cases_css_parsing/check_css_parse_css_modules_true.snap"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_css_parsing/check_css_parse_respects_config_css_modules.snap" "crates/biome_cli/tests/snapshots/main_cases_css_parsing/check_css_parse_respects_config_css_modules.snap"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_css_parsing/check_css_parse_respects_config_tailwind_directives.snap" "crates/biome_cli/tests/snapshots/main_cases_css_parsing/check_css_parse_respects_config_tailwind_directives.snap"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_css_parsing/check_css_parse_tailwind_directives_false.snap" "crates/biome_cli/tests/snapshots/main_cases_css_parsing/check_css_parse_tailwind_directives_false.snap"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_css_parsing/check_css_parse_tailwind_directives_true.snap" "crates/biome_cli/tests/snapshots/main_cases_css_parsing/check_css_parse_tailwind_directives_true.snap"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_css_parsing/check_css_parser_flags_override_config.snap" "crates/biome_cli/tests/snapshots/main_cases_css_parsing/check_css_parser_flags_override_config.snap"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_css_parsing/ci_css_parse_tailwind_directives_true.snap" "crates/biome_cli/tests/snapshots/main_cases_css_parsing/ci_css_parse_tailwind_directives_true.snap"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_css_parsing/format_css_parse_css_modules_true.snap" "crates/biome_cli/tests/snapshots/main_cases_css_parsing/format_css_parse_css_modules_true.snap"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_css_parsing/format_css_parse_tailwind_directives_true.snap" "crates/biome_cli/tests/snapshots/main_cases_css_parsing/format_css_parse_tailwind_directives_true.snap"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_css_parsing/lint_css_parse_css_modules_true.snap" "crates/biome_cli/tests/snapshots/main_cases_css_parsing/lint_css_parse_css_modules_true.snap"

mkdir -p "crates/biome_cli/tests/snapshots/main_cases_format_with_errors"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_format_with_errors/check_format_with_errors_false.snap" "crates/biome_cli/tests/snapshots/main_cases_format_with_errors/check_format_with_errors_false.snap"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_format_with_errors/check_format_with_errors_overrides_config.snap" "crates/biome_cli/tests/snapshots/main_cases_format_with_errors/check_format_with_errors_overrides_config.snap"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_format_with_errors/check_format_with_errors_respects_config_false.snap" "crates/biome_cli/tests/snapshots/main_cases_format_with_errors/check_format_with_errors_respects_config_false.snap"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_format_with_errors/check_format_with_errors_respects_config_true.snap" "crates/biome_cli/tests/snapshots/main_cases_format_with_errors/check_format_with_errors_respects_config_true.snap"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_format_with_errors/check_format_with_errors_true.snap" "crates/biome_cli/tests/snapshots/main_cases_format_with_errors/check_format_with_errors_true.snap"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_format_with_errors/ci_format_with_errors_false.snap" "crates/biome_cli/tests/snapshots/main_cases_format_with_errors/ci_format_with_errors_false.snap"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_format_with_errors/ci_format_with_errors_true.snap" "crates/biome_cli/tests/snapshots/main_cases_format_with_errors/ci_format_with_errors_true.snap"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_format_with_errors/format_format_with_errors_false.snap" "crates/biome_cli/tests/snapshots/main_cases_format_with_errors/format_format_with_errors_false.snap"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_format_with_errors/format_format_with_errors_true.snap" "crates/biome_cli/tests/snapshots/main_cases_format_with_errors/format_format_with_errors_true.snap"

mkdir -p "crates/biome_cli/tests/snapshots/main_cases_json_parsing"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_json_parsing/check_combined_json_parser_flags.snap" "crates/biome_cli/tests/snapshots/main_cases_json_parsing/check_combined_json_parser_flags.snap"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_json_parsing/check_json_parse_allow_comments_false.snap" "crates/biome_cli/tests/snapshots/main_cases_json_parsing/check_json_parse_allow_comments_false.snap"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_json_parsing/check_json_parse_allow_comments_true.snap" "crates/biome_cli/tests/snapshots/main_cases_json_parsing/check_json_parse_allow_comments_true.snap"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_json_parsing/check_json_parse_allow_trailing_commas_false.snap" "crates/biome_cli/tests/snapshots/main_cases_json_parsing/check_json_parse_allow_trailing_commas_false.snap"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_json_parsing/check_json_parse_allow_trailing_commas_true.snap" "crates/biome_cli/tests/snapshots/main_cases_json_parsing/check_json_parse_allow_trailing_commas_true.snap"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_json_parsing/check_json_parse_respects_config_allow_comments.snap" "crates/biome_cli/tests/snapshots/main_cases_json_parsing/check_json_parse_respects_config_allow_comments.snap"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_json_parsing/check_json_parse_respects_config_allow_trailing_commas.snap" "crates/biome_cli/tests/snapshots/main_cases_json_parsing/check_json_parse_respects_config_allow_trailing_commas.snap"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_json_parsing/check_json_parser_flags_override_config.snap" "crates/biome_cli/tests/snapshots/main_cases_json_parsing/check_json_parser_flags_override_config.snap"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_json_parsing/ci_json_parse_allow_comments_true.snap" "crates/biome_cli/tests/snapshots/main_cases_json_parsing/ci_json_parse_allow_comments_true.snap"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_json_parsing/format_json_parse_allow_comments_true.snap" "crates/biome_cli/tests/snapshots/main_cases_json_parsing/format_json_parse_allow_comments_true.snap"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_json_parsing/format_json_parse_allow_trailing_commas_true.snap" "crates/biome_cli/tests/snapshots/main_cases_json_parsing/format_json_parse_allow_trailing_commas_true.snap"
cp "/tests/crates/biome_cli/tests/snapshots/main_cases_json_parsing/lint_json_parse_allow_comments_true.snap" "crates/biome_cli/tests/snapshots/main_cases_json_parsing/lint_json_parse_allow_comments_true.snap"

mkdir -p "crates/biome_cli/tests/snapshots/main_commands_check"
cp "/tests/crates/biome_cli/tests/snapshots/main_commands_check/check_help.snap" "crates/biome_cli/tests/snapshots/main_commands_check/check_help.snap"

mkdir -p "crates/biome_cli/tests/snapshots/main_commands_ci"
cp "/tests/crates/biome_cli/tests/snapshots/main_commands_ci/ci_help.snap" "crates/biome_cli/tests/snapshots/main_commands_ci/ci_help.snap"

mkdir -p "crates/biome_cli/tests/snapshots/main_commands_format"
cp "/tests/crates/biome_cli/tests/snapshots/main_commands_format/format_help.snap" "crates/biome_cli/tests/snapshots/main_commands_format/format_help.snap"

mkdir -p "crates/biome_cli/tests/snapshots/main_commands_lint"
cp "/tests/crates/biome_cli/tests/snapshots/main_commands_lint/lint_help.snap" "crates/biome_cli/tests/snapshots/main_commands_lint/lint_help.snap"

# Rebuild the test binary after copying test files
# Touch the test files to ensure cargo detects changes
touch crates/biome_cli/tests/cases/css_parsing.rs
touch crates/biome_cli/tests/cases/format_with_errors.rs
touch crates/biome_cli/tests/cases/json_parsing.rs
cargo test -p biome_cli --no-run 2>&1 | grep -v "^warning:" || true

# Run tests for biome_cli
# The tests are in crates/biome_cli/tests/cases/ and include css_parsing, format_with_errors, and json_parsing
test_output=$(cargo test -p biome_cli --test main -- --nocapture 2>&1)
test_status=$?
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
