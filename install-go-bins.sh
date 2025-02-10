#!/bin/bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

TARGET_DIR="$HOME/bin"

if [ ! -d "$TARGET_DIR" ]; then
  mkdir -p "$TARGET_DIR"
  if [ $? -ne 0 ]; then
    echo "Error: Failed to create $TARGET_DIR." >&2
    exit 1
  fi
fi

# Find all .go files under go-bins/cmd/** and iterate over them
find "$SCRIPT_DIR/gobins/cmd" -type f -name "*.go" | while read -r GO_FILE; do
  BINARY_NAME=$(basename "${GO_FILE%.*}") # Extract the binary name without extension

  echo "Building the $BINARY_NAME binary..."
  go build -o "$SCRIPT_DIR/$BINARY_NAME" "$GO_FILE"

  if [ $? -ne 0 ]; then
    echo "Error: Failed to build the $BINARY_NAME binary." >&2
    exit 1
  fi

  if [ -f "$TARGET_DIR/$BINARY_NAME" ]; then
    echo "$BINARY_NAME binary already exists in $TARGET_DIR. Overriding it..."
    rm "$TARGET_DIR/$BINARY_NAME"
    if [ $? -ne 0 ]; then
      echo "Error: Failed to remove existing $BINARY_NAME binary." >&2
      exit 1
    fi
  fi

  echo "Moving the $BINARY_NAME binary to $TARGET_DIR..."
  mv "$SCRIPT_DIR/$BINARY_NAME" "$TARGET_DIR/"

  if [ $? -ne 0 ]; then
    echo "Error: Failed to move the $BINARY_NAME binary to $TARGET_DIR." >&2
    exit 1
  fi

  # Ensure the binary is executable
  echo "Setting execute permissions for the $BINARY_NAME binary..."
  chmod +x "$TARGET_DIR/$BINARY_NAME"

  if [ $? -eq 0 ]; then
    echo "Installation of $BINARY_NAME complete. Make sure $TARGET_DIR is in your PATH."
  else
    echo "Error: Failed to set execute permissions for $BINARY_NAME." >&2
    exit 1
  fi
done

