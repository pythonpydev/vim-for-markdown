-- Treesitter: real syntax highlighting/folding for markdown, html, css, python,
-- plus yaml front matter injection inside markdown files.
-- Uses the new (main-branch) nvim-treesitter API: it only installs/manages
-- parsers; highlighting is started explicitly per-buffer via vim.treesitter.start().
local parsers = {
  "markdown", "markdown_inline", "html", "css", "python",
  "yaml", "lua", "vim", "vimdoc", "bash", "json",
}

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  lazy = false,
  config = function()
    local ts = require("nvim-treesitter")
    ts.setup()
    ts.install(parsers)

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "markdown", "html", "css", "python", "yaml", "lua", "vim", "bash", "json" },
      callback = function()
        pcall(vim.treesitter.start)
      end,
    })

    vim.opt.foldmethod = "expr"
    vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.opt.foldenable = false
  end,
}
