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
- Concealment / rendered markdown (headings, bold/italic, bullets shown formatted, not raw)
- Light/dark colour theme toggle (`<leader>d`, Catppuccin Latte/Mocha)
- Live-reloading, scroll-synced browser preview (`<leader>p`)
- Static HTML/PDF export (`<leader>eh` / `<leader>ep`, via Pandoc)
- Table auto-formatting (`<leader>tm`)
- Auto-continuing lists, folding by heading, distraction-free mode (`<leader>z`)
- Word count / reading time in the statusline
- Table of contents generation (`<leader>tc`)
- Internal link checking (`<leader>lc`) and `gf` to jump between markdown files
- Snippets and LSP-powered autocomplete for HTML/CSS/Python (`gd`, `K`)
- Git integration, session persistence, fuzzy file finding (`<leader>ff`)

Leader is `Space` (not `\` — this differs from the basic Vim setup).

## Files

| Path                          | Purpose                                                          |
|-------------------------------|-------------------------------------------------------------------|
| `init.lua`                    | Entry point — loads options, bootstraps `lazy.nvim`, loads keymaps |
| `lua/config/`                 | Core options, keymaps, and the markdown export/link-check commands |
| `lua/plugins/`                | Plugin specs: treesitter, markdown tooling, LSP, editor, UI        |
| `setup.sh`                    | Checks dependencies and symlinks this project to `~/.config/nvim`  |
| `example_template.md`         | Every feature exercised at once, plus a shortcut cheat-sheet       |
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
