# Full-Feature Neovim Markdown Setup

## Introduction

A feature-rich markdown editing/viewing environment built on Neovim, using Lua config and a plugin manager. This is the ambitious counterpart to the [basic Vim setup](../01_basic_vim/CLAUDE.md) — more moving parts, but covers the full feature wishlist.

See the parent [CLAUDE.md](../CLAUDE.md) for the vim vs nvim vs gvim evaluation that led to choosing Neovim here.

## Features

Core:
- standard vim shortcuts
- text formatting to highlight markdown symbols/keywords
- markdown preview (live-reloading, scroll-synced, in browser)
- export to html, pdf

Extended (from the fuller feature brainstorm):
- an easy way to open files, navigate to a file and open it
- an easy way to save as
- switch between html formatting, python formatting, css formatting
- autocomplete for html/python files (via built-in LSP)
- spell-check
- table formatting (auto-align markdown tables)
- auto-list continuation (Enter continues bullet/numbered lists)
- folding by heading
- distraction-free / zen writing mode
- word count / reading time
- concealment of markdown syntax (hide/render ** and _ instead of showing raw symbols)
- table of contents generation from headings
- link/anchor checking (internal links and jump-to-definition between files)
- snippets for common markdown boilerplate (tables, code fences, front matter)
- syntax-highlighted code blocks in preview
- git integration (diff/blame/gutter signs)
- session persistence (reopen last file/cursor position)
- front matter support (YAML syntax highlighting/folding)

## Task

1. Provide a list of possible Neovim plugins/utilities per feature above, to select from. — done, see plugin choices below.
2. Write a Lua-based Neovim config implementing the selected features, with a plugin manager (e.g. lazy.nvim). — done.
3. Set up LSP servers needed for HTML/Python autocomplete. — done, via mason.nvim.
4. Produce an HTML help file listing shortcuts, setup instructions, and features/capabilities. — done, see `nvim_shortcuts.html`.

## Files

- `init.lua` — entry point; loads options, bootstraps lazy.nvim, loads keymaps and the markdown-tools module.
- `lua/config/options.lua` — core editor options (leader = `<Space>`, numbers, clipboard, etc).
- `lua/config/lazy.lua` — bootstraps the lazy.nvim plugin manager.
- `lua/config/keymaps.lua` — keymaps not owned by a specific plugin (save, quit, spell toggle, filetype switching, window navigation, terminal-repaint fix). Save-as lives in `lua/plugins/editor.lua` instead, alongside the telescope-file-browser.nvim dependency it needs.
- `lua/config/lists.lua` — Enter-key continuation shared by two `<CR>` maps: `- ` bullets in any filetype (global map in `keymaps.lua`), and markdown blockquotes (`> `, nested `>> `, `> - item`; empty `> ` becomes a `>` paragraph separator, a second one ends the quote) via the markdown buffer map in `lua/plugins/markdown.lua`, which falls back to autolist.nvim for ordinary lists.
- `lua/config/markdown-tools.lua` — HTML/PDF export commands (via Pandoc), internal link/anchor checking, and `<leader>t`/`:MarkdownInsertTable` (a simple 2-column, header + 2-data-row table skeleton, mirroring the same shortcut in the basic/enhanced Vim setups — vim-table-mode's `<leader>tm` still auto-aligns it as you edit); loaded directly (not as a lazy plugin) so it's always available.
- `lua/plugins/treesitter.lua` — nvim-treesitter (main branch/new API) for real syntax highlighting, folding by heading, and yaml front-matter injection.
- `lua/plugins/markdown.lua` — render-markdown.nvim (concealment), markdown-preview.nvim (live browser preview), vim-table-mode (table formatting), autolist.nvim (list continuation), markdown-toc.nvim (ToC), zen-mode.nvim (distraction-free mode).
- `lua/plugins/lsp.lua` — mason.nvim + mason-lspconfig + nvim-lspconfig (html, cssls, pyright, marksman) + nvim-cmp + LuaSnip for autocomplete/snippets.
- `lua/plugins/editor.lua` — telescope.nvim (file finding/navigation) + telescope-file-browser.nvim (visual folder browsing for save-as), gitsigns.nvim (git integration), persistence.nvim (session persistence).
- `lua/plugins/ui.lua` — catppuccin colorscheme with a light/dark toggle (`<leader>d`, Latte/Mocha), lualine statusline with a word-count/reading-time component, and `LineNr`/`CursorLineNr` styled from Catppuccin's own palette (`subtext0` for ordinary numbers — the default `overlay0` read too faint in Mocha; a bold `green`/`base` pair for the current line) so the active line's number stands out in both flavours. `cursorline`/`cursorlineopt=number` (in `lua/config/options.lua`) restrict the highlight to the number column only.
- `nvim_shortcuts.html` — searchable full shortcut reference, setup instructions (Linux/Windows), and a features/capabilities explainer.
- `setup.sh` — checks dependencies (including tree-sitter-cli, offering to install it via npm), and symlinks this whole directory to `~/.config/nvim` (backing up any existing config first, with confirmation). Run with `./setup.sh`. Linux-only (see `nvim_shortcuts.html` for manual Windows steps). Tested in a sandboxed `$HOME`: handles no existing config and re-running (idempotent, no-op).
- `example_template.md` — reference markdown file covering every styled element plus a checklist and shortcut cheat-sheet, adapted from the basic Vim setup's version for this project's features (Space leader, table-mode, live preview, zen mode, link checking — no light/dark theme toggle here, that's basic-Vim-specific).

## Required external tools (beyond Neovim itself)

- `git` — plugin installation
- `pandoc` + `wkhtmltopdf` — HTML/PDF export
- `tree-sitter` CLI (`npm install -g tree-sitter-cli`) — required by nvim-treesitter's main branch to compile parsers; a C compiler (`gcc`/`cc`) is also needed for that compile step
- `node`/`npm` — builds markdown-preview.nvim's preview app on first install
- Language servers (`html`, `cssls`, `pyright`, `marksman`) are installed automatically by mason.nvim on first launch — this takes a minute or two and needs network access

## Verification performed

Bootstrapped the full config headlessly in an isolated `XDG_*` sandbox (`/tmp`, not part of this project), confirmed: lazy.nvim installs all plugins without errors, treesitter highlighting attaches on a markdown buffer, spell-check is on by default, and the custom `:MarkdownCheckLinks`/`:MarkdownExportHtml`/`:MarkdownExportPdf` commands work. Not yet verified interactively in a real terminal — do that before relying on it daily.
