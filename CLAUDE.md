# Vim for Markdown

## Introduction

I really like the idea of having a lightweight app for editing and viewing markwdown files.  I am also a user of vim keyboard shortcuts (although my skills still need to be improved).

However I have previously tried to set this up with varied success.  There is also the question of which version / flavour of vim to use, e.g. vim, nvim, gvim etc.

This has been split into two separate sub-projects:

1. [`01_basic_vim/`](01_basic_vim/CLAUDE.md) — a simple, low-maintenance plain Vim setup with browser preview (HTML/PDF export) and spell-check.
2. [`02_fullfeature_nvim/`](02_fullfeature_nvim/CLAUDE.md) — a feature-rich Neovim setup covering the full wishlist below.

See each sub-project's CLAUDE.md for its specific scope and tasks.

## vim vs nvim vs gvim evaluation

**Recommendation: Neovim (nvim) in the terminal**, for the full-feature project. The basic project stays on plain Vim deliberately, since it's meant to be minimal.

Reasoning:
- Most actively-developed plugins for markdown editing (table formatting, concealment, live scroll-synced preview, ToC generation, folding by heading) target Neovim.
- Neovim has a built-in LSP client, which is the easiest path to autocomplete for HTML/Python — Vim needs a heavier bolted-on completion engine for the same result.
- Neovim configs can be written in Lua, which is easier to read/maintain/debug than long Vimscript — relevant given past setup attempts had "varied success."
- GVim was ruled out: it adds a native GUI window, which works against the "lightweight, terminal-native" goal, and offers nothing the full-feature Neovim setup (with browser-based preview) doesn't already cover.
- Trade-off: Neovim's richer ecosystem means more moving parts (plugin manager, LSP servers, Lua config) versus plain Vim's near-zero-maintenance footprint — which is exactly why the basic setup uses plain Vim instead.

## Full feature wishlist (reference)

Originally considered for one project, now split per sub-project CLAUDE.md above. Kept here for reference:

- standard vim shortcuts
- text formatting to highlight markdown symbols / keywords
- markdown preview
- export to html, pdf
- an easy way to open files, navigate to a file and open it
- an easy way to save as
- switch between html formatting, python formatting, css formatting
- autocomplete for html file or python file
- spell-check
- table formatting (auto-align markdown tables)
- auto-list continuation (Enter continues bullet/numbered lists)
- folding by heading
- distraction-free / zen writing mode
- word count / reading time
- concealment of markdown syntax (hide/render ** and _ etc. instead of showing raw symbols)
- table of contents generation from headings
- link/anchor checking (internal links and jump-to-definition between files)
- snippets for common markdown boilerplate (tables, code fences, front matter)
- live-reloading browser preview with scroll sync
- export to additional formats beyond html/pdf (e.g. docx, slides via Pandoc)
- syntax-highlighted code blocks in preview
- git integration (diff/blame/gutter signs)
- session persistence (reopen last file/cursor position)
- front matter support (YAML syntax highlighting/folding)
