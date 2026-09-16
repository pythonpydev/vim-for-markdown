-- File navigation, git integration, session persistence.
return {

  -- Fuzzy file finder / navigation ("an easy way to open files, navigate to
  -- a file and open it").
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find file" },
      { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Grep in project" },
      { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Find buffer" },
      { "<leader>fr", "<cmd>Telescope oldfiles<CR>", desc = "Recent files" },
    },
  },

  -- Git integration: diff/blame/hunk signs in the gutter.
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },

  -- Session persistence: reopen last file/cursor position/layout.
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
    keys = {
      { "<leader>ss", function() require("persistence").load() end, desc = "Restore session" },
      { "<leader>sl", function() require("persistence").load({ last = true }) end, desc = "Restore last session" },
    },
  },
}
