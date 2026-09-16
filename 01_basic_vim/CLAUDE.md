# Basic Vim Markdown Setup

## Introduction

A minimal, low-maintenance markdown editing setup using plain Vim. The goal is "install and forget" — a small config with just a few plugins, not an ecosystem to manage.

## Features

- standard vim shortcuts (Vim defaults, no relearning)
- markdown syntax highlighting (built-in / `vim-markdown`)
- preview to browser (render markdown to HTML and open in browser)
- export to PDF (via Pandoc or similar, from the same HTML/markdown pipeline)
- spell-check (`:set spell`), if it can be added without complicating the setup

## Non-goals

Anything from the full feature list (table formatting, ToC generation, LSP autocomplete, live scroll-synced preview, snippets, session persistence, etc.) belongs in the [full-feature Neovim setup](../02_fullfeature_nvim/CLAUDE.md) instead. If a feature here starts requiring extra plugin managers or complex config, it should be deferred to that project rather than added here.

## Task

1. Write a small Vim config (`.vimrc` or scoped config file) enabling markdown syntax highlighting and spell-check. — done, see `vimrc`.
2. Add a command/keybinding to render the current markdown file to HTML and open it in the default browser. — done.
3. Add a command/keybinding to export the current markdown file to PDF. — done.
4. Produce an HTML help file listing the full set of Vim shortcuts. — done, see `vim_shortcuts.html`.

## Files

- `vimrc` — the config. Source it from `~/.vimrc` (`source /home/ed/MEGA/app/vim_for_markdown/01_basic_vim/vimrc`) or symlink it directly as `~/.vimrc`. Requires `pandoc` and `wkhtmltopdf` on PATH (both confirmed installed).
- `vim_shortcuts.html` — searchable full Vim shortcut reference, open in any browser.
- `setup.sh` — checks dependencies and symlinks `vimrc` to `~/.vimrc` (backing up any existing one first, with confirmation). Run with `./setup.sh`. Tested in a sandboxed `$HOME`: handles no existing vimrc, an existing vimrc (backup+replace), and re-running (idempotent, no-op). Actually run against the user's real `~/.vimrc` on 2026-09-16 — backed it up to `~/.vimrc.bak.20260916125245` (their prior attempt: Notepad++-style theme, `vim-markdown-preview` plugin, F5/F6/F7 bindings).
- `example_template.md` — a reference markdown file covering every styled element (headings, bold/italic/strikethrough, lists, blockquote, rule, code, table, links) plus a checklist and a shortcut cheat-sheet, for visually verifying the colour scheme after setup.

## Custom keybindings (defined in `vimrc`)

- `<leader>s` — toggle spell-check
- `<leader>p` (`:MarkdownPreview`) — render current `.md` file to HTML via pandoc and open in browser
- `<leader>e` (`:MarkdownExportPdf`) — export current `.md` file to PDF via pandoc + wkhtmltopdf
- `<leader>d` (`:MarkdownThemeToggle`) — toggle between light and dark colour theme

## Markdown syntax highlighting

`vimrc` defines explicit colours for Vim's real built-in markdown syntax groups (headings, bold/italic/strikethrough, list markers, blockquotes, horizontal rules, links, inline/fenced code) in two themes (light/dark), toggled with `<leader>d`. The light theme is a corrected, extended version of the user's earlier Notepad++-style scheme (backed up as above) — the original only styled headings/bold/code and referenced one non-existent-in-context group; this version covers every element and both themes.

**Important implementation detail:** Vim's own `syntax/markdown.vim` sets `hi def link` defaults the moment syntax loads for a buffer, which silently wins over any colours set earlier (verified by testing — an earlier version of this config had colours silently overridden this way). The fix is hooking `autocmd Syntax markdown` to (re)apply our theme's colours *after* the syntax file finishes loading, guaranteeing they stick. Verified via headless Vim against `example_template.md`: all groups resolve to the intended hex colours in both light and dark mode, and the toggle works.
