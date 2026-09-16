# Basic Vim Markdown Setup

A minimal, low-maintenance markdown editing setup for plain Vim — install and
forget, not an ecosystem to manage.

## Quick start

```bash
./setup.sh
```

Checks you have `vim`, `pandoc`, and `wkhtmltopdf`, then symlinks `vimrc` to
`~/.vimrc` (backing up any existing one first, with confirmation).

Then open the example file to see it in action:

```bash
vim example_template.md
```

## What you get

- Markdown syntax highlighting — headings, bold/italic/strikethrough, list
  markers, blockquotes, horizontal rules, links, and code all explicitly
  coloured, in matching **light and dark themes** (`<leader>d` to toggle)
- Spell-check on by default in markdown files
- One-key preview to browser (`<leader>p`, via Pandoc)
- One-key PDF export (`<leader>e`, via Pandoc + wkhtmltopdf)
- Everything else is just standard Vim — no plugin manager, no extra ecosystem

Leader is `\` (backslash) by default.

## Files

| File                  | Purpose                                                        |
|-----------------------|-----------------------------------------------------------------|
| `vimrc`               | The actual config                                              |
| `setup.sh`            | Checks dependencies and symlinks `vimrc` to `~/.vimrc`          |
| `example_template.md` | Every markdown element styled at once, plus a shortcut cheat-sheet |
| `vim_shortcuts.html`  | Full searchable shortcut reference, setup instructions (Linux/Windows), and a features explainer — open in any browser |

## Requirements

`vim`, `pandoc`, `wkhtmltopdf`. See `vim_shortcuts.html` for install commands
on Linux and Windows.

## Want more?

Table auto-formatting, live-reloading preview, a table of contents, link
checking, LSP autocomplete, git integration, and more live in the companion
[full-feature Neovim setup](../02_fullfeature_nvim/README.md) — more moving
parts, more capability.
