#!/bin/bash

# Build docs using uv
echo "Installing dependencies with uv..."
uv sync --group docs --all-extras --no-extra krisp --no-extra gstreamer

# Check if sphinx-build is available
if ! uv run sphinx-build --version &> /dev/null; then
    echo "Error: sphinx-build is not available" >&2
    exit 1
fi

# Clean previous build
rm -rf _build

echo "Building documentation..."
# Build docs matching ReadTheDocs configuration
uv run sphinx-build -b html -d _build/doctrees . _build/html -W --keep-going

if [ $? -eq 0 ]; then
    echo "Documentation built successfully!"
    # Open docs (MacOS)
    open _build/html/index.html
else
    echo "Documentation build failed!" >&2
    exit 1
fi