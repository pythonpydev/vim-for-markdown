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
- 80-character line width — hard-wraps as you type, with a red guide line at
  column 81; `<leader>q` reflows the current paragraph and `<leader>80`
  reflows the whole file (for existing or pasted text); `<leader>w` toggles
  the limit off/on entirely
- One-key preview to browser (`<leader>p`, via Pandoc) — saves unsaved
  changes first, reports an error instead of opening a missing file if
  Pandoc fails
- One-key PDF export (`<leader>e`, via Pandoc + wkhtmltopdf)
- One-key table skeleton (`<leader>t`) — inserts a simple 2-column,
  header + 2-data-row markdown table below the current line
- Current line number highlighted (bold bright red on lime green) in both
  light and dark themes
- Everything else is just standard Vim — no plugin manager, no extra ecosystem

Leader is `\` (backslash) by default.

## Personal spell-check dictionary

Words you approve with `zg` (or mark wrong with `zw`) are saved to
`spell/en.utf-8.add` inside this project, not Vim's usual location — since
`vimrc` lives in a synced folder (e.g. MEGA), this makes your dictionary
follow you to every machine you symlink `vimrc` on.

If you'd rather keep it local to one machine only, remove the `spellfile=...`
part of the `autocmd FileType markdown` line in `vimrc`. Vim's actual default
(what you get without that override) is `~/.vim/spell/en.utf-8.add`.

## Files

| File                  | Purpose                                                        |
|-----------------------|-----------------------------------------------------------------|
| `vimrc`               | The actual config                                              |
| `setup.sh`            | Checks dependencies and symlinks `vimrc` to `~/.vimrc`          |
| `example_template.md` | Every markdown element styled at once, plus a shortcut cheat-sheet |
| `vim_shortcuts.md`    | Quick shortcut reference — open in Vim itself with `<leader>h` |
| `vim_shortcuts.html`  | Full searchable shortcut reference, setup instructions (Linux/Windows), and a features explainer — open in any browser |

## Requirements

`vim`, `pandoc`, `wkhtmltopdf`. See `vim_shortcuts.html` for install commands
on Linux and Windows.

**System clipboard (`clipboard=unnamedplus`, `"+y`/`"+p`):** on Debian/Ubuntu
the default `vim` package is built *without* clipboard support (`vim
--version` shows `-clipboard`), which makes `unnamedplus` silently do
nothing — `yy`/`p` still work, they just won't reach other applications.
Fix:

```bash
sudo apt install vim-gtk3
sudo update-alternatives --set vim /usr/bin/vim.gtk3
```

(`vim-gtk3` provides the `+clipboard` build; `update-alternatives` may need
pointing at it explicitly if `vim` is in manual mode.) Confirm with `vim
--version | grep clipboard` — you want `+clipboard` and `+xterm_clipboard`.

## Want more?

Table auto-formatting, live-reloading preview, a table of contents, link
checking, LSP autocomplete, git integration, and more live in the companion
[full-feature Neovim setup](../02_fullfeature_nvim/README.md) — more moving
parts, more capability.
