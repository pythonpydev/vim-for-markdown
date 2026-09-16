#!/usr/bin/env bash
# Sets up the full-feature Neovim markdown config by symlinking it to
# ~/.config/nvim. Safe to re-run: it won't overwrite an existing config
# without asking, and does nothing destructive without confirmation.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NVIM_CONFIG_DEST="$HOME/.config/nvim"

echo "== Full-Feature Neovim Markdown Setup =="

# --- Check dependencies -----------------------------------------------
missing=()
for cmd in nvim git pandoc wkhtmltopdf node npm gcc; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    missing+=("$cmd")
  fi
done

if [ ${#missing[@]} -gt 0 ]; then
  echo "Missing required tools: ${missing[*]}"
  echo "Install them first, e.g. on Debian/Ubuntu:"
  echo "  sudo apt install neovim git pandoc wkhtmltopdf nodejs npm build-essential"
  echo "(see nvim_shortcuts.html for other platforms)"
  exit 1
fi
echo "Found: nvim, git, pandoc, wkhtmltopdf, node, npm, gcc"

# --- Tree-sitter CLI (needed by nvim-treesitter to compile parsers) -----
if ! command -v tree-sitter >/dev/null 2>&1; then
  read -r -p "tree-sitter CLI not found (needed to compile syntax parsers). Install with 'npm install -g tree-sitter-cli'? [y/N] " reply
  if [[ "$reply" =~ ^[Yy]$ ]]; then
    npm install -g tree-sitter-cli
  else
    echo "Skipping. Install it yourself later with: npm install -g tree-sitter-cli"
  fi
else
  echo "Found: tree-sitter CLI"
fi

# --- Link config ---------------------------------------------------------
if [ -L "$NVIM_CONFIG_DEST" ] && [ "$(readlink -f "$NVIM_CONFIG_DEST")" = "$(readlink -f "$SCRIPT_DIR")" ]; then
  echo "$NVIM_CONFIG_DEST already points to this project — nothing to do."
elif [ -e "$NVIM_CONFIG_DEST" ]; then
  backup="$NVIM_CONFIG_DEST.bak.$(date +%Y%m%d%H%M%S)"
  read -r -p "$NVIM_CONFIG_DEST already exists. Back it up to $backup and replace with a symlink? [y/N] " reply
  if [[ "$reply" =~ ^[Yy]$ ]]; then
    mv "$NVIM_CONFIG_DEST" "$backup"
    ln -s "$SCRIPT_DIR" "$NVIM_CONFIG_DEST"
    echo "Backed up old config to $backup and linked $NVIM_CONFIG_DEST -> $SCRIPT_DIR"
  else
    echo "Skipped. Run this config in isolation instead, without touching ~/.config/nvim:"
    echo "  NVIM_APPNAME=nvim-markdown nvim   (after symlinking this dir to ~/.config/nvim-markdown)"
    exit 0
  fi
else
  mkdir -p "$(dirname "$NVIM_CONFIG_DEST")"
  ln -s "$SCRIPT_DIR" "$NVIM_CONFIG_DEST"
  echo "Linked $NVIM_CONFIG_DEST -> $SCRIPT_DIR"
fi

echo
echo "Done. Launch Neovim once to let it install plugins and language servers"
echo "(needs network access, takes a minute or two):"
echo "  nvim"
echo "Then open a markdown file:"
echo "  nvim notes.md"
echo "Leader is Space  —  <Space>p previews live, <Space>eh/<Space>ep export HTML/PDF."
echo "Full shortcut reference: $SCRIPT_DIR/nvim_shortcuts.html"
