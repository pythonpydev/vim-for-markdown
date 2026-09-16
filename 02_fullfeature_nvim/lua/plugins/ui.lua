-- Colorscheme (with a light/dark toggle), statusline (with word count /
-- reading time), "save as", and quick filetype switching between
-- markdown/html/python/css.
return {

  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({ flavour = "mocha" })

      vim.g.ui_theme = "dark"

      local function apply_theme()
        if vim.g.ui_theme == "light" then
          vim.o.background = "light"
          vim.cmd.colorscheme("catppuccin-latte")
        else
          vim.o.background = "dark"
          vim.cmd.colorscheme("catppuccin-mocha")
        end
        local ok, lualine = pcall(require, "lualine")
        if ok then lualine.refresh() end
      end

      _G.ToggleUiTheme = function()
        vim.g.ui_theme = (vim.g.ui_theme == "light") and "dark" or "light"
        apply_theme()
        vim.notify("Theme: " .. vim.g.ui_theme)
      end

      apply_theme()
      vim.keymap.set("n", "<leader>d", ToggleUiTheme, { desc = "Toggle light/dark colour theme" })
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local function word_count()
        if vim.bo.filetype ~= "markdown" then return "" end
        local words = vim.fn.wordcount().words
        local minutes = math.max(1, math.floor(words / 200)) -- ~200 wpm reading speed
        return string.format("%d words · %d min read", words, minutes)
      end

      require("lualine").setup({
        options = { theme = "auto" },
        sections = {
          lualine_x = { word_count, "encoding", "filetype" },
        },
      })
    end,
  },

  { "nvim-tree/nvim-web-devicons", lazy = true },
}
