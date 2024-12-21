#!/bin/bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

BINARIES=("title-case" "wrap-text")

TARGET_DIR="$HOME/bin"

if [ ! -d "$TARGET_DIR" ]; then
  mkdir -p "$TARGET_DIR"
  if [ $? -ne 0 ]; then
    echo "Error: Failed to create $TARGET_DIR." >&2
    exit 1
  fi
fi

for BINARY in "${BINARIES[@]}"; do
  echo "Building the $BINARY binary..."
  go build -o "$SCRIPT_DIR/$BINARY" "$SCRIPT_DIR/go-bins/$BINARY.go"

  if [ $? -ne 0 ]; then
    echo "Error: Failed to build the $BINARY binary." >&2
    exit 1
  fi

  if [ -f "$TARGET_DIR/$BINARY" ]; then
    echo "$BINARY binary already exists in $TARGET_DIR. Overriding it..."
    rm "$TARGET_DIR/$BINARY"
    if [ $? -ne 0 ]; then
      echo "Error: Failed to remove existing $BINARY binary." >&2
      exit 1
    fi
  fi

  echo "Moving the $BINARY binary to $TARGET_DIR..."
  mv "$SCRIPT_DIR/$BINARY" "$TARGET_DIR/"

  if [ $? -ne 0 ]; then
    echo "Error: Failed to move the $BINARY binary to $TARGET_DIR." >&2
    exit 1
  fi

  # Ensure the binary is executable
  echo "Setting execute permissions for the $BINARY binary..."
  chmod +x "$TARGET_DIR/$BINARY"

  if [ $? -eq 0 ]; then
    echo "Installation of $BINARY complete. Make sure $TARGET_DIR is in your PATH."
  else
    echo "Error: Failed to set execute permissions for $BINARY." >&2
    exit 1
  fi

done

