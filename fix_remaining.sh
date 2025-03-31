#!/bin/bash

# Create a temporary file for each source file
for file in $(grep -l "PluginDiagnostic {" $(find src -name "*.rs" -type f)); do
  # Check if the file contains PluginDiagnostic but doesn't have the span field
  if ! grep -q "span: None" "$file"; then
    echo "Fixing $file"
    
    # Add span: None, before the closing brace of PluginDiagnostic
    sed -E 's/(PluginDiagnostic \{[^}]*)(note: [^}]*\})/\1note: \2/g; s/(note: [^,}]*)(})/\1,\n                    span: None\2/g' "$file" > "${file}.fixed"
    
    # Attempt another pattern if first didn't succeed
    if ! grep -q "span: None" "${file}.fixed"; then
      sed -E 's/(PluginDiagnostic \{[^}]*)(end_ptr: [^}]*\})/\1end_ptr: \2/g; s/(end_ptr: [^,}]*)(})/\1,\n                    span: None\2/g' "$file" > "${file}.fixed"
    fi
    
    # Check if fix worked
    if grep -q "span: None" "${file}.fixed"; then
      mv "${file}.fixed" "$file"
      echo "  Success"
    else
      rm "${file}.fixed"
      echo "  Failed - will fix manually"
    fi
  fi
done 