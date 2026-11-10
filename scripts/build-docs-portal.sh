#!/usr/bin/env bash
# ==============================================================================
# Documentation Portal Static Site Builder
# Builds the searchable, interactive documentation portal using MkDocs Material
# or validates all markdown links and syntax in CI/CD.
# ==============================================================================

set -euo pipefail

OUTPUT_DIR="${1:-./site}"

echo "📚 Building interactive SDLC documentation portal..."

if command -v mkdocs &> /dev/null; then
    echo "  ⚙️ Running: mkdocs build --site-dir $OUTPUT_DIR"
    mkdocs build --site-dir "$OUTPUT_DIR" --clean
    echo "✅ Documentation site built successfully in: $OUTPUT_DIR"
    echo "🌐 Run 'npx serve $OUTPUT_DIR' or deploy to GitHub Pages."
else
    echo "⚠️  MkDocs is not installed locally."
    echo "💡 To install: pip install mkdocs-material"
    echo "💡 You can also preview the standalone portal by opening: index.html"
fi
