#!/bin/bash

# Find all files with PluginDiagnostic initializations
find src -name "*.rs" -type f -exec grep -l "PluginDiagnostic {" {} \; | while read file; do
  # For each file, modify the PluginDiagnostic initializations
  sed -i '' -E 's/(PluginDiagnostic \{[^}]*)(note: [^,}]*,?)([^}]*\})/\1\2\n                span: None,\3/g' "$file"
  sed -i '' -E 's/(PluginDiagnostic \{[^}]*)(note: [^,}]*,?)([^}]*\})/\1\2\n                span: None,\3/g' "$file"
  
  # Handle cases where there's no note field
  sed -i '' -E 's/(PluginDiagnostic \{[^}]*)(end_ptr: [^,}]*,?)([^}]*\})/\1\2\n                span: None,\3/g' "$file"
  
  # Make sure we didn't miss any
  if grep -q "PluginDiagnostic {" "$file" && ! grep -q "span: None" "$file"; then
    echo "Warning: Could not add span field to all PluginDiagnostic instances in $file"
  fi
done

echo "Done fixing PluginDiagnostic structs" 