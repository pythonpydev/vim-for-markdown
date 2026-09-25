# Vim Shortcuts Reference

Full command reference for the enhanced Vim markdown setup

## Setup Instructions

### Linux

1.  Install Vim, Pandoc, a PDF engine, and fzf:

        sudo apt install vim pandoc wkhtmltopdf fzf

    (Debian/Ubuntu; use your distro's package manager equivalent otherwise, e.g. `dnf`, `pacman`. `fzf` powers `<leader>ff`/`<leader>sa`; everything else still works without it, those two just won't.)

2.  Run the bundled setup script from inside this folder — it checks the dependencies above and symlinks `vimrc` to `~/.vimrc` (backing up any existing one first, with confirmation):

        ./setup.sh

    Or do it by hand instead:

        ln -s /home/ed/MEGA/app/vim_for_markdown/03_vim_enhanced/vimrc ~/.vimrc

    Or, if you already have a `~/.vimrc` and don't want to replace it, add this line to the end of it instead:

        source /home/ed/MEGA/app/vim_for_markdown/03_vim_enhanced/vimrc

3.  Open a markdown file to confirm it works:

        vim notes.md

    Spell-check and markdown highlighting should be active automatically. Try `<leader>p` to preview in browser, `<leader>e` to export to PDF, and `<leader>ff` to fuzzy-find a file (default leader is `\`).

### Windows

1.  Install Vim — download the installer from [vim.org](https://www.vim.org/download.php), or via a package manager:

        winget install vim.vim

2.  Install Pandoc, a PDF engine, and fzf:

        winget install --id JohnMacFarlane.Pandoc
        winget install --id wkhtmltopdf.wkhtmltopdf
        winget install --id junegunn.fzf

    Ensure all three are added to your `PATH` (the installers usually do this automatically; if `pandoc --version` in a new terminal fails, add their install folders to PATH manually). fzf's own Vim plugin usually installs to `~/.fzf` on Windows too — the runtimepath detection in `vimrc` already checks that path.

3.  Find/create your Vim config file. On Windows this is usually:

        $HOME\_vimrc

    (often `C:\Users\<you>\_vimrc`). Add this line to it, pointing at wherever you've placed this project's `vimrc` file (adjust the path, using forward slashes even on Windows):

        source C:/path/to/vim_for_markdown/03_vim_enhanced/vimrc

4.  Open a markdown file to confirm it works:

        vim notes.md

    The preview/export commands use `xdg-open` to launch the browser, which is Linux-specific — see the note below for the one line to change on Windows.

**Note:** the bundled `vimrc` opens previews with `xdg-open` (Linux). On Windows, edit the `MarkdownPreview()` function in `vimrc` and replace `xdg-open` with `start` (or `cmd /c start`) so it opens in your default browser.

## What This Setup Gives You

Once `vimrc` is loaded, opening any `.md` / `.markdown` file in Vim automatically enables the following — no extra commands needed:

- **Markdown syntax highlighting** — headings, bold/italic/strikethrough, list markers, blockquotes, horizontal rules, links, and code are all explicitly coloured (not just left at Vim's uncoloured defaults), in matching light and dark themes. Toggle between them with `<leader>d`. Open `example_template.md` in this folder to see every element styled at once.
- **Word wrap tuned for prose** — `wrap` and `linebreak` are set for markdown files so long lines wrap at word boundaries instead of mid-word, matching how prose is usually edited (unlike Vim's code-editing defaults).
- **Spell-check on by default** — misspelled words are underlined as you type (British English dictionary by default; change `spelllang` in `vimrc` for another variant). Use `]s` / `[s` to jump between misspelled words and `z=` for suggestions. Toggle it off entirely with `<leader>s` if it gets in the way.
- **Fuzzy file finding** — `<leader>ff` opens fzf to fuzzy-search and open any file in the project (needs the `fzf` package installed).
- **Fuzzy "save as"** — `<leader>sa` browses to a folder with fzf, then prompts for just the filename, instead of typing/tab-completing a whole path.
- **One-key browser preview** — `<leader>p` renders the current file to HTML (via Pandoc) and opens it in your default browser, so you can see headings, tables, code blocks etc. rendered properly rather than as raw markdown syntax. Re-run it any time to refresh after edits. Saves unsaved changes first, and reports an error instead of opening a missing file if Pandoc fails (e.g. on an unsaved-to-disk buffer).
- **One-key PDF export** — `<leader>e` converts the current file straight to a shareable PDF (via Pandoc + wkhtmltopdf), written alongside the source file.
- **One-key table skeleton** — `<leader>t` inserts a simple 2-column, header + 2-data-row markdown table below the current line, so you don't have to remember the pipe/dash syntax from scratch.
- **Current line number stands out** — the active line's number is shown bold bright red on a lime green background, in both light and dark themes, so you can spot your cursor's row at a glance.
- **Auto-continuing bullet lists and blockquotes** — pressing Enter on a `- item` line starts the next line with `- ` at the same indent, in any file type (plain notes, YAML lists, ...). In markdown `* ` / `+ ` bullets continue too, and `- [ ]` task items continue as unchecked. Pressing Enter on an empty bullet removes it, ending the list. In markdown, blockquotes continue too: Enter on a `> text` line starts the next with `> ` (nested `>> ` kept); Enter on an empty `> ` turns it into a bare `>` paragraph separator, and a second empty `> ` ends the quote. (Consecutive `> ` lines render as one paragraph, so use that `>` separator, or end a line with `\`, to keep lines apart.)
- **All of standard Vim** — since this is plain Vim with a small config layered on top (not a distribution or heavy plugin stack), every normal Vim shortcut below still works exactly as usual, in any file type.

This builds on the basic Vim setup with just the two features (fuzzy file finding, fuzzy save-as) worth the one extra dependency (fzf). For everything else — live-reloading preview, table auto-formatting, a table of contents, link checking, autocomplete, git integration — see the companion full-feature Neovim setup instead.

## Modes

|          |                                |
|----------|--------------------------------|
| `i`      | Insert before cursor           |
| `I`      | Insert at start of line        |
| `a`      | Insert after cursor (append)   |
| `A`      | Insert at end of line          |
| `o`      | Open new line below and insert |
| `O`      | Open new line above and insert |
| `Esc`    | Return to Normal mode          |
| `v`      | Visual mode (character-wise)   |
| `V`      | Visual line mode               |
| `Ctrl-v` | Visual block mode              |
| `R`      | Replace mode                   |
| `gi`     | Insert at last insert position |
| `:`      | Command-line mode              |

## Cursor Movement (basic)

|           |                                             |
|-----------|---------------------------------------------|
| `h j k l` | Left, down, up, right                       |
| `w`       | Next word start                             |
| `W`       | Next WORD start (whitespace-separated)      |
| `e`       | End of word                                 |
| `E`       | End of WORD                                 |
| `b`       | Back to word start                          |
| `B`       | Back to WORD start                          |
| `ge`      | Back to end of previous word                |
| `0`       | Start of line                               |
| `^`       | First non-blank character of line           |
| `$`       | End of line                                 |
| `g_`      | Last non-blank character of line            |
| `f{char}` | Jump to next occurrence of char             |
| `F{char}` | Jump to previous occurrence of char         |
| `t{char}` | Jump till before next occurrence of char    |
| `T{char}` | Jump till after previous occurrence of char |
| `;`       | Repeat last f/t/F/T                         |
| `,`       | Repeat last f/t/F/T in opposite direction   |

## Cursor Movement (lines & screen)

|            |                                   |
|------------|-----------------------------------|
| `gg`       | Go to first line of file          |
| `G`        | Go to last line of file           |
| `{n}G`     | Go to line n                      |
| `{n}%`     | Go to n% through file             |
| `H`        | Top of screen                     |
| `M`        | Middle of screen                  |
| `L`        | Bottom of screen                  |
| `Ctrl-d`   | Scroll half page down             |
| `Ctrl-u`   | Scroll half page up               |
| `Ctrl-f`   | Scroll full page down             |
| `Ctrl-b`   | Scroll full page up               |
| `Ctrl-e`   | Scroll down one line              |
| `Ctrl-y`   | Scroll up one line                |
| `zz`       | Center current line on screen     |
| `zt`       | Current line to top of screen     |
| `zb`       | Current line to bottom of screen  |
| `{`        | Previous paragraph/blank line     |
| `}`        | Next paragraph/blank line         |
| `(`        | Previous sentence                 |
| `)`        | Next sentence                     |
| `%`        | Jump to matching bracket/paren    |
| `Ctrl-o`   | Jump to older cursor position     |
| `Ctrl-i`   | Jump to newer cursor position     |
| ``` `` ``` | Jump to position before last jump |

## Editing / Deleting

|              |                                       |
|--------------|---------------------------------------|
| `x`          | Delete character under cursor         |
| `X`          | Delete character before cursor        |
| `dd`         | Delete (cut) current line             |
| `{n}dd`      | Delete n lines                        |
| `dw`         | Delete to next word start             |
| `de`         | Delete to end of word                 |
| `d$` / `D`   | Delete to end of line                 |
| `d0`         | Delete to start of line               |
| `dgg`        | Delete to start of file               |
| `dG`         | Delete to end of file                 |
| `d{motion}`  | Delete over any motion (generic)      |
| `cc` / `S`   | Change (delete + insert) whole line   |
| `cw`         | Change to next word start             |
| `C`          | Change to end of line                 |
| `c{motion}`  | Change over any motion (generic)      |
| `r{char}`    | Replace single character              |
| `R`          | Enter Replace mode                    |
| `s`          | Delete character and insert           |
| `~`          | Toggle case of character under cursor |
| `g~{motion}` | Toggle case over motion               |
| `gu{motion}` | Lowercase over motion                 |
| `gU{motion}` | Uppercase over motion                 |
| `J`          | Join line below with current line     |
| `gJ`         | Join lines without adding space       |
| `u`          | Undo                                  |
| `Ctrl-r`     | Redo                                  |
| `.`          | Repeat last change                    |

## Copy / Paste (Yank)

|             |                                                  |
|-------------|--------------------------------------------------|
| `yy` / `Y`  | Yank (copy) current line                         |
| `{n}yy`     | Yank n lines                                     |
| `yw`        | Yank word                                        |
| `y$`        | Yank to end of line                              |
| `y{motion}` | Yank over any motion (generic)                   |
| `p`         | Paste after cursor / below line                  |
| `P`         | Paste before cursor / above line                 |
| `gp`        | Paste after, cursor moves after new text         |
| `]p`        | Paste with indent adjusted                       |
| `"{reg}y`   | Yank into named register                         |
| `"{reg}p`   | Paste from named register                        |
| `"0p`       | Paste from yank register (unaffected by deletes) |

## Visual Mode

|                  |                                       |
|------------------|---------------------------------------|
| `v`              | Start character-wise visual selection |
| `V`              | Start line-wise visual selection      |
| `Ctrl-v`         | Start block-wise visual selection     |
| `o`              | Move to other end of selection        |
| `gv`             | Reselect last visual selection        |
| `d` / `x`        | Delete selection                      |
| `y`              | Yank selection                        |
| `c`              | Change selection                      |
| `>`              | Indent selection                      |
| `<`              | Un-indent selection                   |
| `=`              | Auto-indent selection                 |
| `U`              | Uppercase selection                   |
| `u`              | Lowercase selection                   |
| `J`              | Join selected lines                   |
| `I` (block mode) | Insert before block on all lines      |
| `A` (block mode) | Append after block on all lines       |

## Search & Replace

|                     |                                         |
|---------------------|-----------------------------------------|
| `/pattern`          | Search forward                          |
| `?pattern`          | Search backward                         |
| `n`                 | Repeat search, same direction           |
| `N`                 | Repeat search, opposite direction       |
| `*`                 | Search forward for word under cursor    |
| `#`                 | Search backward for word under cursor   |
| `:noh`              | Clear search highlighting               |
| `:%s/old/new/g`     | Replace all occurrences in file         |
| `:%s/old/new/gc`    | Replace all, with confirmation          |
| `:s/old/new/g`      | Replace all occurrences in current line |
| `:'<,'>s/old/new/g` | Replace within visual selection         |

## Files & Buffers

|                    |                                   |
|--------------------|-----------------------------------|
| `:w`               | Write (save) file                 |
| `:w {file}`        | Save as                           |
| `:q`               | Quit                              |
| `:q!`              | Quit without saving               |
| `:wq` / `ZZ`       | Save and quit                     |
| `ZQ`               | Quit without saving (like :q!)    |
| `:e {file}`        | Edit (open) a file                |
| `:e!`              | Reload file, discarding changes   |
| `:bn`              | Next buffer                       |
| `:bp`              | Previous buffer                   |
| `:bd`              | Delete (close) buffer             |
| `:ls` / `:buffers` | List open buffers                 |
| `:b {n}`           | Switch to buffer n                |
| `Ctrl-^`           | Switch to alternate (last) buffer |

## Windows & Tabs

|                        |                                   |
|------------------------|-----------------------------------|
| `:split` / `Ctrl-w s`  | Horizontal split                  |
| `:vsplit` / `Ctrl-w v` | Vertical split                    |
| `Ctrl-w w`             | Cycle to next window              |
| `Ctrl-w h/j/k/l`       | Move to window left/down/up/right |
| `Ctrl-w q`             | Close current window              |
| `Ctrl-w o`             | Close all other windows           |
| `Ctrl-w =`             | Equalize window sizes             |
| `Ctrl-w {+/-}`         | Increase/decrease window height   |
| `:tabnew`              | Open new tab                      |
| `gt`                   | Next tab                          |
| `gT`                   | Previous tab                      |
| `{n}gt`                | Go to tab n                       |
| `:tabclose`            | Close current tab                 |

## Marks & Registers

|              |                                       |
|--------------|---------------------------------------|
| `m{a-z}`     | Set mark at cursor position           |
| `'{a-z}`     | Jump to line of mark                  |
| `` `{a-z} `` | Jump to exact position of mark        |
| `''`         | Jump back to line before last jump    |
| `:marks`     | List all marks                        |
| `:reg`       | List all registers                    |
| `qa`         | Start recording macro into register a |
| `q`          | Stop recording macro                  |
| `@a`         | Play macro from register a            |
| `@@`         | Repeat last played macro              |
| `{n}@a`      | Play macro n times                    |

## Text Objects (used with d/c/y/v)

|                                                                                             |                                |
|---------------------------------------------------------------------------------------------|--------------------------------|
| `iw`                                                                                        | Inner word                     |
| `aw`                                                                                        | A word (incl. trailing space)  |
| `is`                                                                                        | Inner sentence                 |
| `as`                                                                                        | A sentence                     |
| `ip`                                                                                        | Inner paragraph                |
| `ap`                                                                                        | A paragraph                    |
| `i"` / `i'`                                                                                 | Inner quoted string            |
| `a"` / `a'`                                                                                 | A quoted string (incl. quotes) |
| `i(` / `ib`                                                                                 | Inner parentheses              |
| `a(` / `ab`                                                                                 | A parentheses block            |
| `i{` / `iB`                                                                                 | Inner braces                   |
| `a{` / `aB`                                                                                 | A braces block                 |
| `i[`                                                                                        | Inner brackets                 |
| `a[`                                                                                        | A brackets block               |
| `it`                                                                                        | Inner tag (e.g. HTML)          |
| `at`                                                                                        | A tag block                    |
| Example: `di"` deletes inside quotes, `ca(` changes a parenthesised block including parens. |                                |

## Indentation

|                        |                         |
|------------------------|-------------------------|
| `>>`                   | Indent current line     |
| `<<`                   | Un-indent current line  |
| `={motion}`            | Auto-indent over motion |
| `gg=G`                 | Auto-indent entire file |
| `Ctrl-t` (insert mode) | Indent current line     |
| `Ctrl-d` (insert mode) | Un-indent current line  |

## Folding

|              |                          |
|--------------|--------------------------|
| `zf{motion}` | Create fold over motion  |
| `zo`         | Open fold                |
| `zc`         | Close fold               |
| `za`         | Toggle fold              |
| `zR`         | Open all folds           |
| `zM`         | Close all folds          |
| `zd`         | Delete fold under cursor |
| `zj`         | Move to next fold        |
| `zk`         | Move to previous fold    |

## Spell-check

|                |                                                |
|----------------|------------------------------------------------|
| `:set spell`   | Enable spell-checking                          |
| `:set nospell` | Disable spell-checking                         |
| `]s`           | Jump to next misspelled word                   |
| `[s`           | Jump to previous misspelled word               |
| `z=`           | Suggest corrections for word under cursor      |
| `zg`           | Add word to spell-check dictionary (good word) |
| `zw`           | Mark word as wrong (bad word)                  |
| `zug`          | Undo adding word to dictionary                 |

## This Setup's Custom Shortcuts

|                      |                                                                                                                |
|----------------------|----------------------------------------------------------------------------------------------------------------|
| `Enter` (insert mode) | On a `- item` line, start the next line with `- ` (same indent; `*`/`+` too in markdown). On an empty bullet, remove it to end the list. In markdown, a `> quote` line continues with `> `; Enter on an empty `> ` makes a `>` paragraph separator, a second one ends the quote |
| `o` (normal mode) | Open a line below, continuing the current line's bullet/blockquote the same way as `Enter` |
| `<leader>s`          | Toggle spell-check on/off (leader = `\` by default)                                                            |
| `<leader>w`          | Toggle the 80-column limit (textwidth + guide line) on/off                                                     |
| `<leader>q`          | Reflow current paragraph to 80 columns (fixes existing/pasted text; textwidth only wraps as you actively type) |
| `<leader>80`         | Reflow the whole file to 80 columns                                                                            |
| `<leader>d`          | Toggle light/dark colour theme                                                                                 |
| `<leader>p`          | Preview current markdown file in browser (via pandoc); saves unsaved changes first and reports an error instead of opening a missing file if pandoc fails |
| `<leader>e`          | Export current markdown file to PDF (via pandoc + wkhtmltopdf)                                                 |
| `<leader>t`          | Insert a simple 2-column table skeleton (header + 2 data rows) below the current line                         |
| `<leader>h`          | Open this shortcut reference (vim_shortcuts.md)                                                                |
| `<leader>r`          | Force a full terminal repaint (fixes stray red blocks/redraw glitches some terminals leave behind)             |
| `<leader>ff`         | Fuzzy-find and open a file (via fzf; needs the `fzf` package installed)                                        |
| `<leader>sa`         | Save as — browse to a folder with fzf, then type just the filename                                             |
| `:MarkdownPreview`   | Same as `<leader>p`, callable directly                                                                        |
| `:MarkdownInsertTable` | Same as `<leader>t`, callable directly                                                                      |
| `:MarkdownExportPdf` | Same as `<leader>e`, callable directly                                                                        |
| `:MarkdownHelp`      | Same as `<leader>h`, callable directly                                                                        |
| `:RefreshTerminal`   | Same as `<leader>r`, callable directly                                                                        |
| `:MarkdownFuzzyFind` | Same as `<leader>ff`, callable directly                                                                       |
| `:MarkdownSaveAs`    | Same as `<leader>sa`, callable directly                                                                       |

## Miscellaneous

|                 |                                              |
|-----------------|----------------------------------------------|
| `Ctrl-a`        | Increment number under/after cursor          |
| `Ctrl-x`        | Decrement number under/after cursor          |
| `:!{cmd}`       | Run external shell command                   |
| `:r !{cmd}`     | Insert output of shell command into buffer   |
| `Ctrl-g`        | Show file name and cursor position           |
| `:set nu`       | Show line numbers                            |
| `:set rnu`      | Show relative line numbers                   |
| `K`             | Look up keyword under cursor (man page/help) |
| `:help {topic}` | Open built-in help for topic                 |

Vim Shortcuts Reference — part of the Enhanced Vim Markdown Setup project.
