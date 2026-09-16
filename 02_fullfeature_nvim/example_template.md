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
> paragraph text.

Horizontal rule below:

---

Inline `code span` in the middle of a sentence.

Fenced code block:

```python
def hello():
    print("hello, world")
```

An example table (try `<leader>tm` to toggle table-mode auto-alignment,
then edit a cell and watch it realign):

| Name    | Role     | Years |
|---------|----------|-------|
| Alice   | Engineer | 5     |
| Bob     | Designer | 3     |
| Carol   | Product  | 7     |

An example hyperlink: [Neovim homepage](https://neovim.io)

An automatic link: <https://neovim.io>

---

## Checklist: does the setup look right?

- [ ] Headings 1–6 render bold/coloured, and with render-markdown.nvim the
      `#` markers are concealed/replaced with a heading icon
- [ ] **Bold**, *italic*, ~~strikethrough~~ render styled, not as raw `**`/`*`/`~~`
- [ ] Bullet markers render as a bullet glyph (concealed from raw `-`)
- [ ] Fenced code blocks are syntax-highlighted per their language (the
      python block above should highlight like real Python)
- [ ] The table's `|` columns are auto-aligned when table-mode is on
      (`<leader>tm`)
- [ ] Links are styled/underlined
- [ ] `<leader>p` opens a live, scroll-synced preview of this file in your
      browser
- [ ] `<leader>z` switches to a centered, distraction-free view of this file
- [ ] The statusline shows a word count / reading time estimate
- [ ] `<leader>lc` reports "All internal links resolve" (there are no
      `[text](#anchor)` links in this file to break, but the command should
      run without error)

---

## Shortcuts to try on this file

Leader is `Space` (not `\` — this differs from the basic Vim setup).

| Shortcut       | Action                                                |
|----------------|--------------------------------------------------------|
| `<leader>p`    | Toggle live browser preview                            |
| `<leader>eh`   | Export to HTML and open in browser                     |
| `<leader>ep`   | Export to PDF                                          |
| `<leader>tm`   | Toggle table-mode (auto-align the table above)         |
| `<leader>tc`   | Insert/update a table of contents                      |
| `<leader>z`    | Toggle zen (distraction-free) mode                     |
| `<leader>ts`   | Toggle spell-check                                     |
| `<leader>d`    | Toggle light/dark colour theme                         |
| `<leader>lc`   | Check internal `[text](#anchor)` links                 |
| `]s` / `[s`    | Jump to next / previous misspelled word                |
| `z=`           | Suggest spelling corrections for word under cursor     |
| `gd` / `K`     | Go to definition / hover docs (in HTML/CSS/Python files) |

See `nvim_shortcuts.html` in this same folder for the full shortcut reference,
setup instructions, and features list.
