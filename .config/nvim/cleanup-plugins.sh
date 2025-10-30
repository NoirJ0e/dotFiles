#!/bin/bash

# Plugin consolidation cleanup script
# This script removes individual plugin files that have been merged into user.lua
# Created: 2025-10-31

set -e  # Exit on error

PLUGIN_DIR="/Users/joexu/Repos/dotFiles/.config/nvim/lua/plugins"

echo "=========================================="
echo "  NeoVim Plugin Cleanup Script"
echo "=========================================="
echo ""
echo "This will DELETE the following plugin files:"
echo ""

# List of files to delete
FILES_TO_DELETE=(
  "auto_restore_sessions.lua"
  "avante.lua"
  "blink.lua"
  "catppuccin.lua"
  "cmp_ai.lua"
  "copilot.lua"
  "im-select.lua"
  "kanagawa.lua"
  "mappings.lua"
  "mason.lua"
  "none-ls.lua"
  "obsidian.lua"
  "snacks.lua"
  "tokyonight.lua"
  "treesitter.lua"
)

# Display files that will be deleted
for file in "${FILES_TO_DELETE[@]}"; do
  if [ -f "$PLUGIN_DIR/$file" ]; then
    echo "  ✗ $file"
  else
    echo "  ⚠ $file (not found)"
  fi
done

echo ""
echo "These files will be KEPT:"
echo "  ✓ astrocore.lua"
echo "  ✓ astrolsp.lua"
echo "  ✓ astroui.lua"
echo "  ✓ user.lua (consolidated config)"
echo ""

# Confirmation prompt
read -p "Are you sure you want to delete these files? (yes/no): " confirm

if [ "$confirm" != "yes" ]; then
  echo ""
  echo "❌ Cleanup cancelled."
  exit 0
fi

echo ""
echo "Deleting files..."
echo ""

# Delete files
deleted_count=0
for file in "${FILES_TO_DELETE[@]}"; do
  if [ -f "$PLUGIN_DIR/$file" ]; then
    rm "$PLUGIN_DIR/$file"
    echo "  ✓ Deleted: $file"
    ((deleted_count++))
  fi
done

echo ""
echo "=========================================="
echo "✅ Cleanup complete!"
echo "   Deleted: $deleted_count files"
echo "=========================================="
echo ""
echo "Next steps:"
echo "  1. Restart NeoVim"
echo "  2. Run :Lazy sync to update plugins"
echo "  3. Verify your configuration works"
echo ""
