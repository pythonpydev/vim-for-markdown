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

-- Save as: prompts for a new filename, pre-filled with the current one.
map("n", "<leader>sa", function()
  local current = vim.fn.expand("%:p")
  vim.ui.input({ prompt = "Save as: ", default = current, completion = "file" }, function(path)
    if path and path ~= "" then
      vim.cmd("saveas " .. vim.fn.fnameescape(path))
    end
  end)
end, { desc = "Save as..." })

-- Quick filetype switching (markdown docs that embed html/python/css snippets
-- sometimes need to briefly force filetype for editing convenience/autocomplete).
map("n", "<leader>fh", "<cmd>set filetype=html<CR>", { desc = "Switch filetype to HTML" })
map("n", "<leader>fp", "<cmd>set filetype=python<CR>", { desc = "Switch filetype to Python" })
map("n", "<leader>fc", "<cmd>set filetype=css<CR>", { desc = "Switch filetype to CSS" })
map("n", "<leader>fm", "<cmd>set filetype=markdown<CR>", { desc = "Switch filetype back to Markdown" })

-- Window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })
