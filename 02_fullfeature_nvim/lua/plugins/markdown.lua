-- Everything markdown-authoring-specific: concealment/rendering, live preview,
-- table formatting, auto-list continuation, table of contents, front matter,
-- and distraction-free writing mode.
return {

  -- Concealment: render **bold**, _italic_, headings, bullets etc. as
  -- formatted text in-buffer instead of showing raw markdown symbols.
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    ft = { "markdown" },
    opts = {},
  },

  -- Live-reloading browser preview with scroll sync.
  -- Requires `npm`/`yarn` on PATH the first time, to build the preview app.
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    -- A plain shell command instead of vim.fn["mkdp#util#install"](): lazy.nvim
    -- runs `build` right after cloning, before the plugin is on runtimepath,
    -- so the Vimscript autoload function isn't sourced yet and errors with
    -- "Unknown function: mkdp#util#install". The npm install achieves the
    -- same result without depending on the plugin being loaded first.
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_auto_close = false
    end,
    keys = {
      { "<leader>p", "<cmd>MarkdownPreviewToggle<CR>", desc = "Toggle markdown live preview" },
    },
  },

  -- Auto-align markdown tables as you type/edit them.
  {
    "dhruvasagar/vim-table-mode",
    ft = { "markdown" },
    init = function()
      vim.g.table_mode_corner = "|" -- keep standard markdown table borders
    end,
    keys = {
      { "<leader>tm", "<cmd>TableModeToggle<CR>", desc = "Toggle table mode" },
    },
  },

  -- Auto-continue bullet/numbered lists on <CR>, and support renumbering.
  {
    "gaoDean/autolist.nvim",
    ft = { "markdown" },
    config = function()
      require("autolist").setup()
      -- Buffer-local maps must be set per markdown buffer: `config` only runs
      -- once (for whichever buffer triggered the lazy load), so setting them
      -- here directly left every later markdown buffer without them.
      local function set_maps(buf)
        local map = function(mode, lhs, rhs) vim.keymap.set(mode, lhs, rhs, { buffer = buf }) end
        map("i", "<CR>", "<CR><cmd>AutolistNewBullet<cr>")
        map("n", "o", "o<cmd>AutolistNewBullet<cr>")
        map("n", "<CR>", "<cmd>AutolistToggleCheckbox<cr><CR>")
        map("n", "<C-r>", "<cmd>AutolistRecalculate<cr>")
      end
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function(ev) set_maps(ev.buf) end,
      })
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.bo[buf].filetype == "markdown" then set_maps(buf) end
      end
    end,
  },

  -- Table of contents generation from headings, kept in sync.
  {
    "hedyhli/markdown-toc.nvim",
    ft = { "markdown" },
    cmd = { "Mtoc" },
    opts = {},
    keys = {
      { "<leader>tc", "<cmd>Mtoc insert<CR>", desc = "Insert/update table of contents" },
    },
  },

  -- Distraction-free / zen writing mode.
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      window = { width = 90 },
    },
    keys = {
      { "<leader>z", "<cmd>ZenMode<CR>", desc = "Toggle zen (distraction-free) mode" },
    },
  },
  -- Word count / reading time is a statusline component, added in ui.lua.
}
