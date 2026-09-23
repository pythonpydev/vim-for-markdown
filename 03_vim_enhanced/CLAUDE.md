# Enhanced Vim Markdown Setup

## Introduction

The [basic Vim setup](../01_basic_vim/CLAUDE.md), plus fuzzy file finding and
a fuzzy-browse "save as" — created after using the full-feature Neovim
setup's Telescope-based `<leader>ff`/`<leader>sa` and finding those two
specific features too useful to live without in Vim. Everything else is
identical to the basic setup; this is a strict superset, not a rewrite.

Still no plugin manager: `fzf` ships its own Vim plugin (`:FZF`, `fzf#run()`)
alongside its CLI binary, so `vimrc` just adds that plugin's directory to
Vim's runtimepath — no vim-plug, no vendored plugin repo.

## Features

Everything from the basic setup, plus:

- fuzzy file finding (`<leader>ff`, via fzf's bundled `:FZF` command)
- fuzzy "save as" (`<leader>sa`) — browse to a folder with fzf, then a small
  prompt (pre-filled with the current filename) for just the filename

## Non-goals

Same as the [basic setup](../01_basic_vim/CLAUDE.md#non-goals) — this is
still meant to stay lightweight. Anything beyond "fuzzy find a file" and
"fuzzy browse to save" belongs in the
[full-feature Neovim setup](../02_fullfeature_nvim/CLAUDE.md) instead.

## Task

1. Copy the basic Vim setup as a starting point. — done, see `vimrc` (kept
   in sync feature-for-feature with `../01_basic_vim/vimrc`, only the fzf
   section, project-relative paths, and the `<leader>h`/theme-state-file
   filenames differ).
2. Add fuzzy file finding equivalent to the Neovim setup's `<leader>ff`. —
   done, via fzf's own bundled Vim plugin (no separate `fzf.vim` needed for
   this — the base `fzf` package's `plugin/fzf.vim` already provides
   `:FZF`).
3. Add a fuzzy-browse "save as" equivalent to the Neovim setup's
   `<leader>sa` (telescope-file-browser). — done, via `fzf#run()` browsing
   `find . -type d` from the current file's directory, then an `input()`
   prompt for the filename.
4. Gracefully degrade when `fzf` isn't installed (rather than erroring). —
   done: `<leader>ff`/`<leader>sa` check `exists(':FZF')`/`exists('*fzf#run')`
   first and print a message instead of throwing a raw Vim error.

## Files

Same as the [basic setup](../01_basic_vim/CLAUDE.md#files), with its own
copies of `vimrc`, `vim_shortcuts.md`/`.html`, `example_template.md`,
`setup.sh`, and `spell/` (this project's personal dictionary is separate
from the basic setup's — only one of the two is ever the active `~/.vimrc`,
so there's no real need to share one).

- `setup.sh` — like the basic setup's, but treats `fzf` as optional: missing
  `vim`/`pandoc`/`wkhtmltopdf` still aborts, missing `fzf` just warns (since
  everything except `<leader>ff`/`<leader>sa` works fine without it).

## Custom keybindings (defined in `vimrc`)

All of the [basic setup's](../01_basic_vim/CLAUDE.md#custom-keybindings-defined-in-vimrc)
(`<leader>s`, `<leader>w`, `<leader>q`, `<leader>80`, `<leader>d`, `<leader>p`,
`<leader>e`, `<leader>t`, `<leader>h`, `<leader>r`), plus:

- `<leader>ff` (`:MarkdownFuzzyFind`) — fuzzy-find and open a file via fzf
- `<leader>sa` (`:MarkdownSaveAs`) — fuzzy-browse to a folder via fzf, then
  prompt for the filename and `:saveas`

## fzf integration

`vimrc` searches a short list of common install locations
(`/usr/share/doc/fzf/examples` for Debian/Ubuntu's `fzf` package, `~/.fzf`
for the upstream git-clone installer, and the Homebrew paths on macOS) for
`plugin/fzf.vim`, and adds the first match to `runtimepath`. This mirrors
how the basic setup resolves its own project directory — no hardcoded
absolute path, so the same `vimrc` works across machines with fzf installed
via different methods.

`<leader>sa`'s directory browser runs `find . -type d` rooted at the current
file's directory (via `fzf#run()`'s `dir` option, which temporarily `:lcd`s
there — confirmed via the plugin's own source comments — so the sink
receives a path resolvable with `fnamemodify(selected, ':p')`). Selecting a
directory (or the `.` entry for "here") opens an `input()` prompt pre-filled
with `<dir>/<current filename>`, matching the basic setup's plain
`<leader>e`/`<leader>p` UX of editable-prefilled-prompt rather than a raw
picker with no chance to adjust the name.
