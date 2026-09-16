-- Core editor options

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

opt.number = true
opt.relativenumber = true
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
