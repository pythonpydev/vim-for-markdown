-- File navigation, git integration, session persistence.
return {

  -- Fuzzy file finder / navigation ("an easy way to open files, navigate to
  -- a file and open it"), plus a tree-style browser (telescope-file-browser)
  -- used for <leader>sa ("an easy way to save as") so you can browse to a
  -- folder visually instead of typing/completing the whole path.
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
    },
    cmd = "Telescope",
    config = function()
      require("telescope").load_extension("file_browser")
    end,
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find file" },
      { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Grep in project" },
      { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Find buffer" },
      { "<leader>fr", "<cmd>Telescope oldfiles<CR>", desc = "Recent files" },
      {
        "<leader>sa",
        function()
          local bufnr = vim.api.nvim_get_current_buf()
          local original_name = vim.fn.expand("%:t")

          local function prompt_and_save(dir)
            vim.ui.input({
              prompt = "Save as: ",
              default = dir .. "/" .. original_name,
              completion = "file",
            }, function(target)
              if target and target ~= "" then
                vim.api.nvim_buf_call(bufnr, function()
                  vim.cmd("saveas " .. vim.fn.fnameescape(target))
                end)
              end
            end)
          end

          require("telescope").extensions.file_browser.file_browser({
            path = vim.fn.expand("%:p:h"),
            cwd = vim.fn.expand("%:p:h"),
            prompt_title = "Save as — browse to a folder, then <C-s>",
            attach_mappings = function(prompt_bufnr, map)
              local action_state = require("telescope.actions.state")
              local actions = require("telescope.actions")
              local function save_here()
                local dir = action_state.get_current_picker(prompt_bufnr).finder.path
                actions.close(prompt_bufnr)
                prompt_and_save(dir)
              end
              map("i", "<C-s>", save_here)
              map("n", "<C-s>", save_here)
              return true
            end,
          })
        end,
        desc = "Save as... (browse for a location)",
      },
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
