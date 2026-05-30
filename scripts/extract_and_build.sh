#!/usr/bin/env bash
set -euo pipefail

# Run from repo root: bash scripts/extract_and_build.sh
REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO_ROOT"

ZIP_NAME="longwoodgeek-games-site-starter.zip"
TARGET_DIR="site"

if [ ! -f "$ZIP_NAME" ]; then
  echo "Error: ZIP not found at $REPO_ROOT/$ZIP_NAME"
  exit 1
fi

mkdir -p "$TARGET_DIR"

echo "Extracting $ZIP_NAME -> $TARGET_DIR/"
unzip -o "$ZIP_NAME" -d "$TARGET_DIR"

echo "Contents of $TARGET_DIR/ (top-level):"
ls -la "$TARGET_DIR" | sed -n '1,200p'

# Detect whether the extracted content is a prebuilt static site
if [ -f "$TARGET_DIR/index.html" ]; then
  echo "Detected prebuilt static site (index.html present). Skipping MkDocs build."
  exit 0
fi

# If mkdocs.yml exists in the repo, attempt to build
if [ -f mkdocs.yml ]; then
  if command -v mkdocs >/dev/null 2>&1; then
    echo "Running mkdocs build..."
    mkdocs build
    echo "mkdocs build finished. Public site in the configured site_dir (default: site/)."
  else
    echo "mkdocs not found. To install: pip install --user mkdocs"
    echo "Then run: mkdocs build"
    exit 0
  fi
else
  echo "No mkdocs.yml found in repo root. If this is a source folder for another generator, build accordingly."
fi
