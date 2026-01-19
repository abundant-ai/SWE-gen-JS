#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_js_formatter/tests/specs/js/module/import"
cp "/tests/crates/biome_js_formatter/tests/specs/js/module/import/import_call.js" "crates/biome_js_formatter/tests/specs/js/module/import/import_call.js"
mkdir -p "crates/biome_js_formatter/tests/specs/js/module/import"
cp "/tests/crates/biome_js_formatter/tests/specs/js/module/import/import_call.js.snap" "crates/biome_js_formatter/tests/specs/js/module/import/import_call.js.snap"
mkdir -p "crates/biome_js_parser/tests/js_test_suite/error"
cp "/tests/crates/biome_js_parser/tests/js_test_suite/error/import_invalid_args.js.snap" "crates/biome_js_parser/tests/js_test_suite/error/import_invalid_args.js.snap"
mkdir -p "crates/biome_js_parser/tests/js_test_suite/error"
cp "/tests/crates/biome_js_parser/tests/js_test_suite/error/import_no_meta.js.snap" "crates/biome_js_parser/tests/js_test_suite/error/import_no_meta.js.snap"
mkdir -p "crates/biome_js_parser/tests/js_test_suite/ok"
cp "/tests/crates/biome_js_parser/tests/js_test_suite/ok/import_call.js.snap" "crates/biome_js_parser/tests/js_test_suite/ok/import_call.js.snap"
mkdir -p "crates/biome_js_parser/tests/js_test_suite/ok"
cp "/tests/crates/biome_js_parser/tests/js_test_suite/ok/import_defer.js" "crates/biome_js_parser/tests/js_test_suite/ok/import_defer.js"
mkdir -p "crates/biome_js_parser/tests/js_test_suite/ok"
cp "/tests/crates/biome_js_parser/tests/js_test_suite/ok/import_defer.js.snap" "crates/biome_js_parser/tests/js_test_suite/ok/import_defer.js.snap"
mkdir -p "crates/biome_js_parser/tests/js_test_suite/ok"
cp "/tests/crates/biome_js_parser/tests/js_test_suite/ok/import_source.js" "crates/biome_js_parser/tests/js_test_suite/ok/import_source.js"
mkdir -p "crates/biome_js_parser/tests/js_test_suite/ok"
cp "/tests/crates/biome_js_parser/tests/js_test_suite/ok/import_source.js.snap" "crates/biome_js_parser/tests/js_test_suite/ok/import_source.js.snap"
mkdir -p "crates/biome_js_parser/tests/js_test_suite/ok"
cp "/tests/crates/biome_js_parser/tests/js_test_suite/ok/jsx_children_expression.jsx.snap" "crates/biome_js_parser/tests/js_test_suite/ok/jsx_children_expression.jsx.snap"
mkdir -p "crates/biome_js_parser/tests/js_test_suite/ok"
cp "/tests/crates/biome_js_parser/tests/js_test_suite/ok/ts_instantiation_expressions_1.ts.snap" "crates/biome_js_parser/tests/js_test_suite/ok/ts_instantiation_expressions_1.ts.snap"
mkdir -p "crates/biome_js_parser/tests/js_test_suite/ok"
cp "/tests/crates/biome_js_parser/tests/js_test_suite/ok/ts_instantiation_expressions_new_line.ts.snap" "crates/biome_js_parser/tests/js_test_suite/ok/ts_instantiation_expressions_new_line.ts.snap"
mkdir -p "crates/biome_js_parser/tests"
cp "/tests/crates/biome_js_parser/tests/spec_test.rs" "crates/biome_js_parser/tests/spec_test.rs"

# Run specific tests for this PR
# The PR modifies the quick_test function in spec_test.rs to test the new import.defer syntax
# We run quick_test with --ignored flag since it's marked with #[ignore]
cargo test -p biome_js_parser quick_test -- --ignored --nocapture
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
