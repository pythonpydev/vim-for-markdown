# Full-Feature Neovim Markdown Setup

A feature-rich markdown editing/viewing environment built on Neovim, with a
Lua config and `lazy.nvim` as the plugin manager. The ambitious counterpart
to the [basic Vim setup](../01_basic_vim/README.md) — more moving parts, but
covers the full feature wishlist.

## Quick start

```bash
./setup.sh
```

Checks dependencies (`nvim`, `git`, `pandoc`, `wkhtmltopdf`, `node`, `npm`,
`gcc`), offers to install the Tree-sitter CLI via npm if missing, then
symlinks this whole directory to `~/.config/nvim` (backing up any existing
config first, with confirmation).

Then launch Neovim once and wait — on first run `lazy.nvim` clones every
plugin and `mason.nvim` installs the language servers automatically (needs
network access, takes a minute or two):

```bash
nvim
```

Open the example file to see it in action:

```bash
nvim example_template.md
```

## What you get

- Real syntax highlighting via Treesitter (markdown, embedded HTML/CSS/Python/YAML)
- 80-character line width — hard-wraps as you type, with a red guide line at
  column 81; `<leader>gq` reflows the current paragraph and `<leader>gG`
  reflows the whole file (for existing or pasted text); `<leader>tw` toggles
  the limit off/on entirely
- Concealment / rendered markdown (headings, bold/italic, bullets shown formatted, not raw)
- Light/dark colour theme toggle (`<leader>d`, Catppuccin Latte/Mocha)
- Live-reloading, scroll-synced browser preview (`<leader>p`)
- Static HTML/PDF export (`<leader>eh` / `<leader>ep`, via Pandoc)
- Table auto-formatting (`<leader>tm`); `<leader>t` inserts a simple 2-column
  table skeleton to get started
- Current line number highlighted in a theme-matched Catppuccin green, bold,
  in both light and dark themes
- Auto-continuing lists, folding by heading, distraction-free mode (`<leader>z`)
- Word count / reading time in the statusline
- Table of contents generation (`<leader>tc`)
- Internal link checking (`<leader>lc`) and `gf` to jump between markdown files
- Snippets and LSP-powered autocomplete for HTML/CSS/Python (`gd`, `K`)
- Git integration, session persistence, fuzzy file finding (`<leader>ff`)
- "Save as" with a visual folder browser (`<leader>sa`, via telescope-file-browser)

Leader is `Space` (not `\` — this differs from the basic Vim setup).

## Personal spell-check dictionary

Words you approve with `zg` (or mark wrong with `zw`) are saved to
`spell/en.utf-8.add` inside this project, not Neovim's usual location — since
`setup.sh` symlinks this whole directory to `~/.config/nvim` and that lives in
a synced folder (e.g. MEGA), this makes your dictionary follow you to every
machine you symlink this config on.

If you'd rather keep it local to one machine only, remove the
`vim.opt_local.spellfile = spellfile` line in
`lua/config/markdown-tools.lua`. Neovim's actual default (what you get
without that override) is `~/.local/share/nvim/site/spell/en.utf-8.add`.

## Files

| Path                          | Purpose                                                          |
|-------------------------------|-------------------------------------------------------------------|
| `init.lua`                    | Entry point — loads options, bootstraps `lazy.nvim`, loads keymaps |
| `lua/config/`                 | Core options, keymaps, and the markdown export/link-check commands |
| `lua/plugins/`                | Plugin specs: treesitter, markdown tooling, LSP, editor, UI        |
| `setup.sh`                    | Checks dependencies and symlinks this project to `~/.config/nvim`  |
| `example_template.md`         | Every feature exercised at once, plus a shortcut cheat-sheet       |
| `nvim_shortcuts.md`           | Quick shortcut reference — open in Neovim itself with `<leader>h` |
| `nvim_shortcuts.html`         | Full searchable shortcut reference, setup instructions (Linux/Windows), and a features explainer — open in any browser |

## Requirements

`nvim` (0.11+/0.12), `git`, `pandoc`, `wkhtmltopdf`, `node`/`npm`, a C
compiler (`gcc`), and the Tree-sitter CLI (`npm install -g tree-sitter-cli`
— required by nvim-treesitter to compile parsers). See `nvim_shortcuts.html`
for install commands on Linux and Windows.

## Want something simpler?

If this is too much to maintain, the companion
[basic Vim setup](../01_basic_vim/README.md) covers highlighting, preview,
export, and spell-check with a single small config file and no plugin
manager.
