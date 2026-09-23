# Heading 1

## Heading 2

### Heading 3

#### Heading 4

##### Heading 5

###### Heading 6

Regular paragraph text, for comparison against everything below. This line
should just look like normal text — no special colouring.

**Bold text** and *italic text* and ***bold italic text*** and ~~strikethrough text~~.

- Bullet item one
- Bullet item two
  - Nested bullet
- Bullet item three

1. Numbered item one
2. Numbered item two
3. Numbered item three

> This is a blockquote. It should be styled differently from regular
> paragraph text (green/italic in the light theme).

Horizontal rule below:

---

Inline `code span` in the middle of a sentence.

Fenced code block:

```
def hello():
    print("hello, world")
```

An example table:

| Name    | Role          | Years |
|---------|---------------|-------|
| Alice   | Engineer      | 5     |
| Bob     | Designer      | 3     |
| Carol   | Product       | 7     |

An example hyperlink: [Vim homepage](https://www.vim.org)

An automatic link: <https://www.vim.org>

---

## Checklist: does the colour scheme look right?

- [ ] Headings 1–6 are bold and coloured (red in light mode, red/orange in dark mode)
- [ ] `#` heading markers are a muted shade of the heading colour
- [ ] **Bold** text is blue
- [ ] *Italic* text is a muted purple/magenta
- [ ] ~~Strikethrough~~ text is grey with a line through it
- [ ] Bullet markers (`-`) and numbered markers (`1.`) are orange/yellow
- [ ] Blockquote text is green and italic
- [ ] The horizontal rule (`---`) is magenta/purple
- [ ] Inline `code` and fenced code blocks have a shaded background and green text
- [ ] The link text is blue and underlined; the URL itself is teal/cyan
- [ ] Table renders as plain text with visible `|` column separators (Vim has no built-in table rendering — `vim-table-mode`-style auto-alignment is a full-feature-Neovim thing, not part of this setup)

---

## Shortcuts to try on this file

Leader is `\` (backslash) by default.

| Shortcut     | Action                                                |
|--------------|--------------------------------------------------------|
| `\p`         | Render this file to HTML and open it in your browser   |
| `\e`         | Export this file to PDF                                |
| `\s`         | Toggle spell-check on/off                               |
| `\d`         | Toggle between light and dark colour theme              |
| `\ff`        | Fuzzy-find and open a file (needs `fzf` installed)      |
| `\sa`        | Save as, browsing to a folder with fzf                  |
| `]s` / `[s`  | Jump to next / previous misspelled word                 |
| `z=`         | Suggest spelling corrections for word under cursor      |

See `vim_shortcuts.html` (or `\h` inside Vim) for the full shortcut reference.
