-- Core editor options

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

opt.number = true
opt.relativenumber = true
-- Highlight the current line's number distinctly (colours set per-theme in
-- lua/plugins/ui.lua); cursorlineopt=number restricts it to the number
-- column only, so the text line itself isn't tinted.
opt.cursorline = true
opt.cursorlineopt = "number"
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.ignorecase = true
opt.smartcase = true
opt.termguicolors = true
opt.signcolumn = "yes"
opt.updatetime = 250
opt.timeoutlen = 400
opt.undofile = true
opt.splitright = true
opt.splitbelow = true
opt.scrolloff = 4
opt.conceallevel = 2 -- needed for render-markdown.nvim / concealment features

-- Prose-friendly defaults for markdown; also set per-filetype in plugins/markdown.lua
opt.linebreak = true

vim.filetype.add({
  extension = {
    md = "markdown",
    markdown = "markdown",
  },
})
