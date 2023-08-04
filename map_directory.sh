#!/bin/bash

path=$1
output_file="file_tree.txt"

# Check that a path was provided
if [ -z "$path" ]; then
  echo "Please provide a directory path"
  echo "Usage: $0 directory_path"
  exit
fi

# Check that the path exists and is a directory
if [ ! -d "$path" ]; then
  echo "$path is not a valid directory"
  exit  
fi

# Map the directory recursively and write to the output file
map_dir() {
  local indent=$1
  local dir=$2
  for file in "$dir"/*; do 
    if [ -d "$file" ]; then
      # Directory, map recursively
      echo "$indent|-----> $(basename "$file")" >> "$output_file"
      map_dir "$indent|   " "$file"  
    else    
      # File, print file name
      echo "$indent|-----> $(basename "$file")" >> "$output_file"
    fi  
  done
}

# Clear the output file if it exists
> "$output_file"

# Print mapping  
echo "$(basename "$path")" >> "$output_file"
map_dir "" "$path"

