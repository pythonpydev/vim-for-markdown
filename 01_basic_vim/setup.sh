#!/usr/bin/env bash
# Sets up the basic Vim markdown config by symlinking it to ~/.vimrc.
# Safe to re-run: it won't overwrite an existing ~/.vimrc without asking,
# and does nothing destructive without confirmation.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VIMRC_SRC="$SCRIPT_DIR/vimrc"
VIMRC_DEST="$HOME/.vimrc"

echo "== Basic Vim Markdown Setup =="

# --- Check dependencies -----------------------------------------------
missing=()
for cmd in vim pandoc wkhtmltopdf; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    missing+=("$cmd")
  fi
done

if [ ${#missing[@]} -gt 0 ]; then
  echo "Missing required tools: ${missing[*]}"
  echo "Install them first, e.g. on Debian/Ubuntu:"
  echo "  sudo apt install ${missing[*]}"
  echo "(see vim_shortcuts.html for other platforms)"
  exit 1
fi
echo "Found: vim, pandoc, wkhtmltopdf"

# --- Link vimrc ---------------------------------------------------------
if [ -L "$VIMRC_DEST" ] && [ "$(readlink -f "$VIMRC_DEST")" = "$(readlink -f "$VIMRC_SRC")" ]; then
  echo "$VIMRC_DEST already points to this project's vimrc — nothing to do."
elif [ -e "$VIMRC_DEST" ]; then
  backup="$VIMRC_DEST.bak.$(date +%Y%m%d%H%M%S)"
  read -r -p "$VIMRC_DEST already exists. Back it up to $backup and replace with a symlink? [y/N] " reply
  if [[ "$reply" =~ ^[Yy]$ ]]; then
    mv "$VIMRC_DEST" "$backup"
    ln -s "$VIMRC_SRC" "$VIMRC_DEST"
    echo "Backed up old config to $backup and linked $VIMRC_DEST -> $VIMRC_SRC"
  else
    echo "Skipped. To use this config without replacing your vimrc, add this line to the end of $VIMRC_DEST instead:"
    echo "  source $VIMRC_SRC"
    exit 0
  fi
else
  ln -s "$VIMRC_SRC" "$VIMRC_DEST"
  echo "Linked $VIMRC_DEST -> $VIMRC_SRC"
fi

echo
echo "Done. Open a markdown file to try it:"
echo "  vim notes.md"
echo "Leader is \\  —  \\p previews in browser, \\e exports to PDF, \\s toggles spell-check."
echo "Full shortcut reference: $SCRIPT_DIR/vim_shortcuts.html"
