# Enhanced Vim Markdown Setup — Windows Port

## Introduction

A native-Windows-11 port of [`03_vim_enhanced`](../03_vim_enhanced/CLAUDE.md).
Same scope and features (the [basic Vim setup](../01_basic_vim/CLAUDE.md)
plus fzf-powered fuzzy file finding and fuzzy "save as"); only the parts of
the Linux `vimrc`/`setup.sh` that don't work on native Windows Vim were
changed. Created because `03_vim_enhanced` was written and tested on Linux
(`/home/ed/...` paths, `~/.vimrc` symlinking, `xdg-open`, `find`, a
GNOME-terminal-specific redraw fix) and the user wanted a working Windows 11
equivalent rather than relying on WSL/Git-Bash Vim to paper over the gap.

Targets **native Windows Vim** (the vim.org/winget installer running
directly in PowerShell/cmd/Windows Terminal) — not Vim inside WSL or Git
Bash, which already behaves like Linux and can just use `03_vim_enhanced`
unmodified.

## Non-goals

Same as [`03_vim_enhanced`'s](../03_vim_enhanced/CLAUDE.md#non-goals) — this
stays a strict feature-parity port, not a place to add anything beyond what
that project already has. New features belong in the Linux version first
(and would need their own Windows port afterwards); this project doesn't
grow independently of it.

## Task

1. Copy `03_vim_enhanced` as a starting point and identify every
   Linux/Unix-specific dependency in `vimrc` and `setup.sh`. — done, see
   "Ported/changed from Linux" below.
2. Produce a working `vimrc` for native Windows Vim, keeping every keybinding
   and feature identical except where the underlying mechanism had no
   Windows equivalent. — done.
3. Produce a Windows-native setup script (PowerShell, since `setup.sh` is
   bash) that checks dependencies and wires up the user's Vim config without
   requiring admin rights. — done, see `setup.ps1`.
4. Produce Windows-only versions of the shortcut reference and README,
   documenting the deltas from the Linux version rather than silently
   diverging. — done, see `vim_shortcuts.md`/`.html`, `README.md`.

**Not yet done:** interactive verification in a real Windows 11 terminal
(this was written from the Linux version's source plus documented Vim/
Windows behaviour, not tested against an actual Vim install on this
machine). Before relying on it daily, open `example_template.md` and check:
the colour theme renders and `<leader>d` toggles it (and persists across
restarts), `<leader>p`/`<leader>e` produce a preview/PDF, and — once fzf is
installed per the README — `<leader>ff`/`<leader>sa` both work, in
particular the `dir /b /s /ad` folder listing behind `<leader>sa`.

**Known issue — terminal cursor colour (this Windows port only, not seen on
the Linux [`03_vim_enhanced`](../03_vim_enhanced/CLAUDE.md) setup this was
ported from):** the "Cursor shape + colour (terminal)" block (`guicursor` +
`t_SI`/`t_EI`/`t_SR` sending DECSCUSR/OSC 12) did not visibly recolour the
cursor in testing under Windows Terminal running console Vim on Windows 11, even though `:echo &t_EI` correctly showed the expected escape
sequence once `_vimrc` was freshly (re)sourced — root cause not yet isolated
(candidates: that specific Windows Terminal profile/version not honouring
OSC 12, or something in the session resetting it after startup). Confirmed
working reliably in **GVim** instead, where `hi Cursor guibg=#ff8c00`
colours the GUI's own cursor directly and never touches this terminal-escape
code path at all (skipped via `if !has('gui_running')`). If console-Vim
cursor colour matters enough to chase further, start by testing the raw
escape sequence directly in Windows Terminal outside Vim:
`Write-Host -NoNewline "$([char]27)]12;#ff8c00$([char]7)"` (PowerShell) — if
that alone doesn't recolour the cursor, it's a Windows Terminal/profile
issue, not a vimrc one.

## Files

Same set as [`03_vim_enhanced`](../03_vim_enhanced/CLAUDE.md#files), with
Windows-specific replacements:

- `vimrc` — the config. Add `source C:/path/to/vim_for_markdown/vim_enhanced_win/vimrc` to `$HOME\_vimrc`, or let `setup.ps1` do it.
- `setup.ps1` — PowerShell equivalent of `setup.sh`: checks `vim`/`pandoc`/`wkhtmltopdf` (required) and `fzf` (optional, plus its separately-cloned Vim plugin) via `Get-Command`/`Test-Path`, then appends/creates a `source` line in `$HOME\_vimrc`. Unlike `setup.sh`, it never symlinks — Windows symlinks need admin rights or Developer Mode, and a `source` line achieves the same result without either.
- `vim_shortcuts.md` / `vim_shortcuts.html` — same searchable reference as the Linux version, minus `<leader>r`/`:RefreshTerminal` (not applicable), plus a "Differences from the Linux setup" section and Windows-only setup steps (the Linux version's own `vim_shortcuts.html` already had a Windows setup column drafted — this project's version supersedes that draft with the actual implementation).
- `example_template.md` — unchanged from the Linux version (no OS-specific content).
- `README.md` — Windows-specific quick start and requirements.
- `spell/` — this project's own personal dictionary (`en.utf-8.add`), created on first run; not shared with any other sub-project, including `03_vim_enhanced`.

## Ported/changed from Linux

Each change below exists because the Linux mechanism has no direct Windows
equivalent, not because the underlying feature changed:

- **Clipboard (`unnamedplus`)** — left unchanged. Unlike Linux (where `+`
  needs an X11-aware Vim build), Windows Vim maps both `+` and `*` to the
  one system clipboard as long as it's built with `+clipboard`, which the
  standard vim.org/winget installer is. No Windows-specific code needed;
  documented the `vim --version | findstr clipboard` check instead.
- **fzf plugin discovery** — the Linux `vimrc` checks four paths covering
  apt/git-clone/Homebrew installs. On Windows, `winget`/Scoop only package
  the compiled `fzf.exe` binary — `plugin/fzf.vim` (needed for Vim's `:FZF`
  command) only exists in the git repo. So the Windows `vimrc` checks a
  single path, `~/.fzf`, and the README/setup script tell the user to `git
  clone` there — same location the Linux version's own git-clone-installer
  case already used, just now the *only* case instead of one of several.
- **`<leader>sa`'s directory browser** — `find . -type d` (used as fzf's
  `source`) doesn't exist on Windows; replaced with cmd's built-in
  `dir /b /s /ad . & echo .` (bare, recurse, directories-only, then append
  a `.` entry for "here", matching the Linux version's inclusion of `.` via
  `find`'s own root argument).
- **`<leader>p` preview output path & launch command** — `/tmp/...` and
  `xdg-open ... &` are both Linux-specific. Replaced with `%TEMP%` (Vim's
  `expand('$TEMP')`) for the output path, and cmd's `start "" <file>` to
  launch the default browser (the empty `""` is a required dummy
  window-title argument for `start`, not a mistake — without it, `start`
  treats a quoted path as the title instead of the file to open).
- **Theme state file** — moved from `~/.local/state/vim_enhanced_markdown_theme`
  to `%LOCALAPPDATA%\vim_enhanced_win\theme`, the idiomatic per-user,
  per-machine state location on Windows. Still deliberately per-machine
  (unlike the spellfile, which stays inside the synced project folder).
- **Dropped `<leader>r` / `:RefreshTerminal`** — the Linux version's
  workaround targets a redraw glitch specific to some Linux terminal
  emulators (gnome-terminal/VTE leaving stray coloured cells after fast
  redraws); it relies on `/dev/tty` and `printf`, neither of which exist on
  native Windows. Not ported — if the same *symptom* turns up on Windows
  Terminal, it would need a different fix, not this one back-ported.
- **`setup.sh` → `setup.ps1`** — bash script rewritten in PowerShell.
  Beyond the language change, the linking strategy itself changed: `setup.sh`
  symlinks `~/.vimrc` outright (with backup+confirmation), which needs no
  special privilege on Linux; the Windows equivalent of that (`New-Item
  -ItemType SymbolicLink`) needs admin rights or Developer Mode enabled, so
  `setup.ps1` instead appends/creates a plain `source` line in `$HOME\_vimrc`
  — same net effect (this project's `vimrc` gets loaded), no elevated
  privileges required, and it's idempotent (checks whether the line is
  already there before adding it again).
