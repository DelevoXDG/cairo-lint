#!/bin/bash

# List of files that need fixing
FILES=(
  "src/lints/duplicate_underscore_args.rs"
  "src/lints/eq_op.rs"
  "src/lints/panic.rs"
  "src/lints/erasing_op.rs"
  "src/lints/int_op_one.rs"
  "src/lints/enum_variant_names.rs"
  "src/lints/ifs/ifs_same_cond.rs"
  "src/lints/ifs/collapsible_if_else.rs"
  "src/lints/ifs/collapsible_if.rs"
  "src/lints/ifs/equatable_if_let.rs"
  "src/lints/redundant_op.rs"
  "src/lints/double_comparison.rs"
  "src/lints/manual/manual_ok.rs"
  "src/lints/manual/manual_is.rs"
  "src/lints/manual/manual_err.rs"
  "src/lints/manual/manual_unwrap_or_default.rs"
  "src/lints/manual/manual_ok_or.rs"
  "src/lints/manual/manual_expect.rs"
  "src/lints/manual/manual_expect_err.rs"
  "src/lints/double_parens.rs"
  "src/lints/performance.rs"
  "src/lints/loops/loop_match_pop_front.rs"
  "src/lints/loops/loop_for_while.rs"
  "src/lints/single_match.rs"
  "src/lints/breaks.rs"
)

for file in "${FILES[@]}"; do
  echo "Processing $file..."
  
  # Read the file
  content=$(cat "$file")
  
  # Replace all occurrences of the pattern using awk for better multiline handling
  new_content=$(awk '
    /PluginDiagnostic \{/ {
      in_struct = 1
    }
    in_struct && /note: None,/ {
      sub(/note: None,/, "note: None,\n                span: None,")
      in_struct = 0
    }
    in_struct && /note: None\n/ {
      sub(/note: None\n/, "note: None,\n                span: None,\n")
      in_struct = 0
    }
    in_struct && /end_ptr: None,/ && !/span: None,/ {
      sub(/end_ptr: None,/, "end_ptr: None,\n                span: None,")
      in_struct = 0
    }
    {print}
  ' <<< "$content")
  
  # Write the content back to the file
  echo "$new_content" > "$file"
  
  echo "Done with $file"
done

echo "All files processed" 