# Enhanced Vim Markdown Setup

The [basic Vim setup](../01_basic_vim/README.md) plus fuzzy file finding and a
fuzzy-browse "save as" (via fzf) — the two features that turned out to be
worth the one extra dependency after trying the full-feature Neovim setup.
Still no plugin manager: fzf ships its own Vim plugin alongside the CLI tool,
so `vimrc` just points Vim's runtimepath at it.

## Quick start

```bash
./setup.sh
```

Checks you have `vim`, `pandoc`, and `wkhtmltopdf` (required), and `fzf`
(optional — everything except `<leader>ff`/`<leader>sa` works without it),
then symlinks `vimrc` to `~/.vimrc` (backing up any existing one first, with
confirmation).

Then open the example file to see it in action:

```bash
vim example_template.md
```

## What you get

Everything in the [basic setup](../01_basic_vim/README.md#what-you-get), plus:

- Fuzzy file finding (`<leader>ff`, via fzf) — "an easy way to open files,
  navigate to a file and open it"
- Fuzzy "save as" (`<leader>sa`) — browse to a folder with fzf, then type
  just the filename, instead of typing/tab-completing a whole path

Leader is `\` (backslash) by default.

## Personal spell-check dictionary

Words you approve with `zg` (or mark wrong with `zw`) are saved to
`spell/en.utf-8.add` inside this project, not Vim's usual location — since
`vimrc` lives in a synced folder (e.g. MEGA), this makes your dictionary
follow you to every machine you symlink `vimrc` on. This dictionary is
separate from the basic setup's — the two projects don't share one, since
only one of them is ever your active `~/.vimrc` at a time.

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

`vim`, `pandoc`, `wkhtmltopdf`, and `fzf` (optional — see "What you get"
above). See `vim_shortcuts.html` for install commands on Linux and Windows.

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

## Which Vim project should be my `~/.vimrc`?

Only one of [`01_basic_vim`](../01_basic_vim/README.md) or this project can
be symlinked as `~/.vimrc` at a time (running either `setup.sh` re-points the
symlink). Since this is a strict superset of the basic setup — same
everything, plus two extra features gated behind one optional dependency —
there's little reason to prefer the basic one once `fzf` is installed.
Fall back to the basic setup only if you'd rather not have `fzf` on the
machine at all.

## Want more?

Table auto-formatting, live-reloading preview, a table of contents, link
checking, LSP autocomplete, git integration, and more live in the companion
[full-feature Neovim setup](../02_fullfeature_nvim/README.md) — more moving
parts, more capability.
