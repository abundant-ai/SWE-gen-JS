#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_js_type_info/tests"
cp "/tests/crates/biome_js_type_info/tests/local_inference.rs" "crates/biome_js_type_info/tests/local_inference.rs"
mkdir -p "crates/biome_js_type_info/tests/snapshots"
cp "/tests/crates/biome_js_type_info/tests/snapshots/infer_flattened_type_from_direct_promise_instance.snap" "crates/biome_js_type_info/tests/snapshots/infer_flattened_type_from_direct_promise_instance.snap"
mkdir -p "crates/biome_js_type_info/tests/snapshots"
cp "/tests/crates/biome_js_type_info/tests/snapshots/infer_flattened_type_from_static_promise_function.snap" "crates/biome_js_type_info/tests/snapshots/infer_flattened_type_from_static_promise_function.snap"
mkdir -p "crates/biome_js_type_info/tests/snapshots"
cp "/tests/crates/biome_js_type_info/tests/snapshots/infer_flattened_type_of_typeof_expression.snap" "crates/biome_js_type_info/tests/snapshots/infer_flattened_type_of_typeof_expression.snap"
mkdir -p "crates/biome_js_type_info/tests/snapshots"
cp "/tests/crates/biome_js_type_info/tests/snapshots/infer_resolved_type_from_direct_promise_instance.snap" "crates/biome_js_type_info/tests/snapshots/infer_resolved_type_from_direct_promise_instance.snap"
mkdir -p "crates/biome_js_type_info/tests/snapshots"
cp "/tests/crates/biome_js_type_info/tests/snapshots/infer_resolved_type_from_static_promise_function.snap" "crates/biome_js_type_info/tests/snapshots/infer_resolved_type_from_static_promise_function.snap"
mkdir -p "crates/biome_js_type_info/tests/snapshots"
cp "/tests/crates/biome_js_type_info/tests/snapshots/infer_type_of_binary_expression_eq.snap" "crates/biome_js_type_info/tests/snapshots/infer_type_of_binary_expression_eq.snap"
mkdir -p "crates/biome_js_type_info/tests/snapshots"
cp "/tests/crates/biome_js_type_info/tests/snapshots/infer_type_of_binary_expression_ne.snap" "crates/biome_js_type_info/tests/snapshots/infer_type_of_binary_expression_ne.snap"
mkdir -p "crates/biome_js_type_info/tests/snapshots"
cp "/tests/crates/biome_js_type_info/tests/snapshots/infer_type_of_literal.snap" "crates/biome_js_type_info/tests/snapshots/infer_type_of_literal.snap"
mkdir -p "crates/biome_js_type_info/tests/snapshots"
cp "/tests/crates/biome_js_type_info/tests/snapshots/infer_type_of_regex.snap" "crates/biome_js_type_info/tests/snapshots/infer_type_of_regex.snap"
mkdir -p "crates/biome_js_type_info/tests/snapshots"
cp "/tests/crates/biome_js_type_info/tests/snapshots/test_reference_to_falsy_subset_of.snap" "crates/biome_js_type_info/tests/snapshots/test_reference_to_falsy_subset_of.snap"
mkdir -p "crates/biome_module_graph/tests/snapshots"
cp "/tests/crates/biome_module_graph/tests/snapshots/test_resolve_export_type_referencing_imported_type.snap" "crates/biome_module_graph/tests/snapshots/test_resolve_export_type_referencing_imported_type.snap"
mkdir -p "crates/biome_module_graph/tests/snapshots"
cp "/tests/crates/biome_module_graph/tests/snapshots/test_resolve_export_types.snap" "crates/biome_module_graph/tests/snapshots/test_resolve_export_types.snap"
mkdir -p "crates/biome_module_graph/tests/snapshots"
cp "/tests/crates/biome_module_graph/tests/snapshots/test_resolve_exports.snap" "crates/biome_module_graph/tests/snapshots/test_resolve_exports.snap"
mkdir -p "crates/biome_module_graph/tests/snapshots"
cp "/tests/crates/biome_module_graph/tests/snapshots/test_resolve_generic_mapped_value.snap" "crates/biome_module_graph/tests/snapshots/test_resolve_generic_mapped_value.snap"
mkdir -p "crates/biome_module_graph/tests/snapshots"
cp "/tests/crates/biome_module_graph/tests/snapshots/test_resolve_generic_return_value.snap" "crates/biome_module_graph/tests/snapshots/test_resolve_generic_return_value.snap"
mkdir -p "crates/biome_module_graph/tests/snapshots"
cp "/tests/crates/biome_module_graph/tests/snapshots/test_resolve_generic_return_value_with_multiple_modules.snap" "crates/biome_module_graph/tests/snapshots/test_resolve_generic_return_value_with_multiple_modules.snap"
mkdir -p "crates/biome_module_graph/tests/snapshots"
cp "/tests/crates/biome_module_graph/tests/snapshots/test_resolve_import_as_namespace.snap" "crates/biome_module_graph/tests/snapshots/test_resolve_import_as_namespace.snap"
mkdir -p "crates/biome_module_graph/tests/snapshots"
cp "/tests/crates/biome_module_graph/tests/snapshots/test_resolve_merged_types.snap" "crates/biome_module_graph/tests/snapshots/test_resolve_merged_types.snap"
mkdir -p "crates/biome_module_graph/tests/snapshots"
cp "/tests/crates/biome_module_graph/tests/snapshots/test_resolve_multiple_reexports.snap" "crates/biome_module_graph/tests/snapshots/test_resolve_multiple_reexports.snap"
mkdir -p "crates/biome_module_graph/tests/snapshots"
cp "/tests/crates/biome_module_graph/tests/snapshots/test_resolve_promise_export.snap" "crates/biome_module_graph/tests/snapshots/test_resolve_promise_export.snap"
mkdir -p "crates/biome_module_graph/tests/snapshots"
cp "/tests/crates/biome_module_graph/tests/snapshots/test_resolve_promise_from_imported_function_returning_imported_promise_type.snap" "crates/biome_module_graph/tests/snapshots/test_resolve_promise_from_imported_function_returning_imported_promise_type.snap"
mkdir -p "crates/biome_module_graph/tests/snapshots"
cp "/tests/crates/biome_module_graph/tests/snapshots/test_resolve_promise_from_imported_function_returning_reexported_promise_type.snap" "crates/biome_module_graph/tests/snapshots/test_resolve_promise_from_imported_function_returning_reexported_promise_type.snap"
mkdir -p "crates/biome_module_graph/tests/snapshots"
cp "/tests/crates/biome_module_graph/tests/snapshots/test_resolve_recursive_looking_vfile.snap" "crates/biome_module_graph/tests/snapshots/test_resolve_recursive_looking_vfile.snap"
mkdir -p "crates/biome_module_graph/tests/snapshots"
cp "/tests/crates/biome_module_graph/tests/snapshots/test_resolve_single_reexport.snap" "crates/biome_module_graph/tests/snapshots/test_resolve_single_reexport.snap"
mkdir -p "crates/biome_module_graph/tests/snapshots"
cp "/tests/crates/biome_module_graph/tests/snapshots/test_resolve_type_of_property_with_getter.snap" "crates/biome_module_graph/tests/snapshots/test_resolve_type_of_property_with_getter.snap"
mkdir -p "crates/biome_module_graph/tests/snapshots"
cp "/tests/crates/biome_module_graph/tests/snapshots/test_resolve_type_of_this_in_class_assign.snap" "crates/biome_module_graph/tests/snapshots/test_resolve_type_of_this_in_class_assign.snap"

# Build the tests after copying test files
cargo test --no-run -p biome_js_type_info --test local_inference
cargo test --no-run -p biome_module_graph --test spec_tests

# Run specific tests from biome_js_type_info::local_inference
cargo test -p biome_js_type_info --test local_inference -- \
  infer_type_of_regex \
  infer_type_of_literal \
  infer_type_of_binary_expression_eq \
  infer_type_of_binary_expression_ne \
  infer_flattened_type_of_typeof_expression \
  infer_flattened_type_from_direct_promise_instance \
  infer_flattened_type_from_static_promise_function \
  infer_resolved_type_from_direct_promise_instance \
  infer_resolved_type_from_static_promise_function \
  test_reference_to_falsy_subset_of \
  --nocapture

# Run specific tests from biome_module_graph::spec_tests
cargo test -p biome_module_graph --test spec_tests -- \
  test_resolve_exports \
  test_resolve_export_types \
  test_resolve_generic_return_value \
  test_resolve_generic_mapped_value \
  test_resolve_generic_return_value_with_multiple_modules \
  test_resolve_import_as_namespace \
  test_resolve_type_of_property_with_getter \
  test_resolve_type_of_this_in_class_assign \
  test_resolve_promise_export \
  test_resolve_merged_types \
  test_resolve_recursive_looking_vfile \
  test_resolve_single_reexport \
  test_resolve_multiple_reexports \
  test_resolve_export_type_referencing_imported_type \
  test_resolve_promise_from_imported_function_returning_imported_promise_type \
  test_resolve_promise_from_imported_function_returning_reexported_promise_type \
  --nocapture

test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
