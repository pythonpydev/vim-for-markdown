# Vim for Markdown

Two Vim/Neovim configs for editing and viewing markdown, built to two
different levels of ambition — pick whichever fits how much setup you're
willing to maintain.

## Projects

| | [`01_basic_vim/`](01_basic_vim/README.md) | [`02_fullfeature_nvim/`](02_fullfeature_nvim/README.md) |
|---|---|---|
| Editor | Vim | Neovim |
| Philosophy | Minimal, install-and-forget | Full-featured, more moving parts |
| Config | Single `vimrc` file | Lua config with `lazy.nvim` plugin manager |
| Leader key | `\` | `Space` |
| Highlights | Syntax highlighting, light/dark toggle, spell-check, browser preview, PDF export | All of that, plus Treesitter, LSP autocomplete, live scroll-synced preview, table auto-formatting, ToC generation, link checking, git integration, session persistence, and more |

Each has its own `setup.sh`, an `example_template.md` to check the install
worked, and a searchable HTML shortcut/setup reference — see their READMEs
for details.

## Which one should I use?

Start with the basic Vim setup if you want something that works immediately
with almost no maintenance burden. Move to the full-feature Neovim setup if
you want IDE-like features and don't mind a bit more upkeep (a plugin
manager, language servers, more dependencies).

See [`01_basic_vim/CLAUDE.md`](01_basic_vim/CLAUDE.md) and
[`02_fullfeature_nvim/CLAUDE.md`](02_fullfeature_nvim/CLAUDE.md) for the full
feature lists, and the root [`CLAUDE.md`](CLAUDE.md) for the reasoning behind
choosing Vim vs. Neovim vs. GVim for these two projects.
