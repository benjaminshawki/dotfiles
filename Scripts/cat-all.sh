#!/bin/bash

# Check if a directory path is provided as an input argument
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 /path/to/directory"
  exit 1
fi

DIR="$1" # Set DIR to the first input argument, which is the directory path

# Check if the provided directory exists
if [ ! -d "$DIR" ]; then
  echo "Directory does not exist: $DIR"
  exit 1
fi

# Use find to recursively loop through each file in the directory and its subdirectories
find "$DIR" -type f | while read file; do
  echo "---------- $file ----------" # Print the file name
  cat "$file" # Print the file content
  echo # Print a newline for readability
done

