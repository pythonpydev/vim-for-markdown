-- Custom keymaps not owned by a specific plugin spec.
-- Leader is <Space> (see lua/config/options.lua).
-- Plugin-specific keymaps live alongside their plugin spec in lua/plugins/*.lua
-- so the mapping and the plugin it depends on stay next to each other.

local map = vim.keymap.set

-- Quality of life
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- Spell-check toggle
map("n", "<leader>ts", "<cmd>set spell!<CR>", { desc = "Toggle spell-check" })

-- Fix stale terminal redraw glitches: some terminals (seen with
-- gnome-terminal/VTE) occasionally leave stray coloured cells on screen
-- after fast redraws (e.g. spell-check highlighting) that a normal redraw
-- doesn't clear, but resizing the window does. This sends the same
-- "resize" escape sequence the window manager would (shrink by one column,
-- then straight back), forcing a full repaint without actually changing
-- your terminal's size.
map("n", "<leader>rt", function()
  local lines, columns = vim.o.lines, vim.o.columns
  vim.fn.system(string.format('printf "\\e[8;%d;%dt" > /dev/tty', lines, columns - 1))
  vim.wait(100)
  vim.fn.system(string.format('printf "\\e[8;%d;%dt" > /dev/tty', lines, columns))
end, { desc = "Force a full terminal repaint (fixes stray redraw glitches)" })

-- 80-column reflow: textwidth only wraps text as you actively type it; it
-- does nothing to text that's already in the buffer (an existing file, or
-- anything pasted in). These reflow it on demand, inserting real line breaks
-- at column 80. <leader>tw toggles the limit itself off/on (see
-- lua/config/markdown-tools.lua).
map("n", "<leader>gq", "gqap", { desc = "Reflow paragraph to 80 columns" })
map("n", "<leader>gG", "gggqG", { desc = "Reflow whole file to 80 columns" })
map("n", "<leader>tw", "<cmd>MarkdownToggleWrapLimit<CR>", { desc = "Toggle 80-column wrap limit" })

-- <leader>sa (Save as) now lives in lua/plugins/editor.lua, alongside the
-- telescope-file-browser.nvim dependency it needs (browse to a folder, then
-- <C-s>, then type just the filename).

-- Quick filetype switching (markdown docs that embed html/python/css snippets
-- sometimes need to briefly force filetype for editing convenience/autocomplete).
map("n", "<leader>fh", "<cmd>set filetype=html<CR>", { desc = "Switch filetype to HTML" })
map("n", "<leader>fp", "<cmd>set filetype=python<CR>", { desc = "Switch filetype to Python" })
map("n", "<leader>fc", "<cmd>set filetype=css<CR>", { desc = "Switch filetype to CSS" })
map("n", "<leader>fm", "<cmd>set filetype=markdown<CR>", { desc = "Switch filetype back to Markdown" })

-- Bullet-list continuation outside markdown: Enter on a "- item" line (also
-- "- [ ] " task items) starts the next line with the same marker and indent,
-- in any filetype (plain notes, YAML lists, ...); Enter on a bullet with
-- nothing after the marker removes it, ending the list. Markdown buffers get
-- the richer autolist.nvim version instead (its buffer-local <CR> map in
-- lua/plugins/markdown.lua takes priority over this global one). Only "- ",
-- not "* ", since e.g. C/Java block comments already get " * " continued by
-- Neovim itself and this would double it. Only in normal file buffers, so
-- special buffers (command-line window, prompts) keep plain Enter.
map("i", "<CR>", function()
  local function feed(keys)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), "ni", false)
  end
  local line = vim.api.nvim_get_current_line()
  local indent, marker, rest = line:match("^(%s*)(%-%s+%[[ xX]%]%s+)(.*)$")
  if not indent then indent, marker, rest = line:match("^(%s*)(%-%s+)(.*)$") end
  if vim.fn.pumvisible() == 1 or not indent or vim.bo.buftype ~= "" then
    feed("<CR>")
  elseif rest == "" and vim.fn.col(".") > #line then
    vim.api.nvim_set_current_line("")
  else
    marker = marker:gsub("%[[xX]%]", "[ ]")
    feed("<CR>" .. (vim.bo.autoindent and "" or indent) .. marker)
  end
end, { desc = "Newline, continuing a '- ' bullet list" })

-- Window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })
