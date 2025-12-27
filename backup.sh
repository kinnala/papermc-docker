#!/usr/bin/env bash
set -euo pipefail

# Create a new directory named with the current date and time
backup_dir="$(date '+%Y-%m-%d_%H-%M-%S')"
mkdir -p "varmuuskopiot/$backup_dir"

# Copy contents of worlds/ and plugins/ recursively into the new directory
for src in worlds plugins; do
  if [[ -d "$src" ]]; then
    mkdir -p "varmuuskopiot/$backup_dir/$src"
    cp -a "$src/." "varmuuskopiot/$backup_dir/$src/"
  else
    echo "Warning: '$src' directory not found, skipping." >&2
  fi
done

echo "Backup created at: varmuuskopiot/$backup_dir"
