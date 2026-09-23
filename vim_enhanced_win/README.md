# Enhanced Vim Markdown Setup — Windows Port

A native-Windows-11 port of [`03_vim_enhanced`](../03_vim_enhanced/README.md):
the basic Vim setup plus fuzzy file finding and a fuzzy-browse "save as" (via
fzf). Same features, same keybindings — only the parts of the Linux version
that don't work on Windows Vim were changed. See `vim_shortcuts.md`'s
"Differences from the Linux setup" section for the full list.

Targets **native Windows Vim** (the vim.org/winget installer), not Vim
running inside WSL or Git Bash — those already behave like Linux and can
just use `03_vim_enhanced` directly.

## Quick start

```powershell
.\setup.ps1
```

Checks you have `vim`, `pandoc`, and `wkhtmltopdf` (required) and `fzf`
(optional — everything except `<leader>ff`/`<leader>sa` works without it),
then points your Vim config (`$HOME\_vimrc`) at this project's `vimrc` via a
`source` line (backing up any existing `_vimrc` first, with confirmation).

If PowerShell blocks the script from running, either:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\setup.ps1
```

or right-click `setup.ps1` → "Run with PowerShell".

Then open the example file to see it in action:

```powershell
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
follow you to every machine this `vimrc` is sourced on. This dictionary is
separate from every other sub-project's — none of them share one.

If you'd rather keep it local to one machine only, remove the
`spellfile=...` part of the `autocmd FileType markdown` line in `vimrc`.

## Files

| File                  | Purpose                                                        |
|-----------------------|-----------------------------------------------------------------|
| `vimrc`               | The actual config                                              |
| `setup.ps1`           | Checks dependencies and points `$HOME\_vimrc` at this project's `vimrc` |
| `example_template.md` | Every markdown element styled at once, plus a shortcut cheat-sheet |
| `vim_shortcuts.md`    | Quick shortcut reference — open in Vim itself with `<leader>h` |
| `vim_shortcuts.html`  | Full searchable shortcut reference, setup instructions, and a features explainer — open in any browser |

## Requirements

`vim`, `pandoc`, `wkhtmltopdf`, and `fzf` (optional — see "What you get"
above). All installable via `winget`; see `vim_shortcuts.html` for exact
commands. `fzf`'s Vim plugin needs a separate git clone to `~/.fzf` — see
`vim_shortcuts.html`, step 2 — since the `winget`/Scoop packages only ship
the `fzf.exe` binary.

**System clipboard (`clipboard=unnamedplus`, `"+y`/`"+p`):** works out of the
box with the standard `vim.org`/`winget` Vim build, which bundles gvim and
is compiled with `+clipboard`. Confirm with:

```powershell
vim --version | findstr clipboard
```

You want `+clipboard` (not `-clipboard`).

## Which sub-project should be my Vim config?

This is a strict Windows port of `03_vim_enhanced` — same features, same
keybindings. Use this one on native Windows Vim; use
[`03_vim_enhanced`](../03_vim_enhanced/README.md) instead if you're running
Vim inside WSL or Git Bash (those are Linux-like environments already, and
that version's `setup.sh`/symlink approach works fine there). Only one
`_vimrc`/`.vimrc` is active at a time.

## Want more?

Table auto-formatting, live-reloading preview, a table of contents, link
checking, LSP autocomplete, git integration, and more live in the companion
[full-feature Neovim setup](../02_fullfeature_nvim/README.md) — more moving
parts, more capability. (That setup was itself only verified headlessly, not
yet interactively on Windows — see its CLAUDE.md.)
