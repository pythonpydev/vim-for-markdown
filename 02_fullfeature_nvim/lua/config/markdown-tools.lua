-- Static HTML/PDF export (via Pandoc), spell-check/wrap defaults, and simple
-- internal link/anchor checking + jump-to-file for markdown links.
-- Loaded directly from init.lua (not a lazy.nvim plugin spec) so it's always
-- available regardless of plugin load order/triggers.

local group = vim.api.nvim_create_augroup("markdown_setup", { clear = true })

-- Personal dictionary (zg/zw) lives inside this synced config (stdpath("config")
-- is ~/.config/nvim, symlinked to this project by setup.sh) instead of the
-- default ~/.local/share/nvim/site/spell/en.utf-8.add, so words added on one
-- machine show up on every other machine this config is symlinked on. To go
-- back to Neovim's default (local-only, not synced), delete the
-- "vim.opt_local.spellfile = spellfile" line below.
local spellfile = vim.fn.stdpath("config") .. "/spell/en.utf-8.add"
vim.fn.mkdir(vim.fn.fnamemodify(spellfile, ":h"), "p")

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = "markdown",
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en_gb"
    vim.opt_local.spellfile = spellfile
    vim.opt_local.wrap = true
    vim.opt_local.conceallevel = 2
    -- 80-character line width: textwidth makes Neovim insert a real line
    -- break as you type past column 80 (<leader>gq/<leader>gG reflows text
    -- that's already there, e.g. pasted); colorcolumn draws a guide line at
    -- column 81 (one past the limit, so it doesn't sit on top of a character
    -- at column 80 itself), coloured bright red per-theme in
    -- lua/plugins/ui.lua. Toggle the whole thing off/on with <leader>tw.
    vim.opt_local.textwidth = 80
    vim.opt_local.colorcolumn = "81"
    -- lets `gf` resolve bare `[text](other-file)` links without extension
    vim.opt_local.suffixesadd:append(".md")
    vim.opt_local.includeexpr = "substitute(v:fname,'#.*','','')"
  end,
})

-- Toggle the 80-column limit itself on/off (does not undo any reflowing
-- already done — that's just u like any other edit).
vim.api.nvim_create_user_command("MarkdownToggleWrapLimit", function()
  if vim.opt_local.textwidth:get() == 80 then
    vim.opt_local.textwidth = 0
    vim.opt_local.colorcolumn = ""
    vim.notify("80-column limit: off")
  else
    vim.opt_local.textwidth = 80
    vim.opt_local.colorcolumn = "81"
    vim.notify("80-column limit: on")
  end
end, {})

-- Export current file to a standalone HTML file and open in browser.
vim.api.nvim_create_user_command("MarkdownExportHtml", function()
  local src = vim.fn.expand("%:p")
  local out = vim.fn.expand("%:p:r") .. "_export.html"
  vim.fn.system({ "pandoc", src, "-s", "-o", out })
  if vim.v.shell_error ~= 0 then
    vim.notify("HTML export failed", vim.log.levels.ERROR)
    return
  end
  vim.fn.jobstart({ "xdg-open", out }, { detach = true })
  vim.notify("Exported to " .. out)
end, {})

-- Export current file to PDF via Pandoc + wkhtmltopdf.
vim.api.nvim_create_user_command("MarkdownExportPdf", function()
  local src = vim.fn.expand("%:p")
  local out = vim.fn.expand("%:p:r") .. ".pdf"
  vim.fn.system({ "pandoc", src, "--pdf-engine=wkhtmltopdf", "-o", out })
  if vim.v.shell_error ~= 0 then
    vim.notify("PDF export failed", vim.log.levels.ERROR)
    return
  end
  vim.notify("Exported to " .. out)
end, {})

-- Check that every [text](#anchor) link resolves to a heading in this buffer.
vim.api.nvim_create_user_command("MarkdownCheckLinks", function()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local anchors, broken = {}, {}
  for _, line in ipairs(lines) do
    local heading = line:match("^#+%s+(.*)")
    if heading then
      local slug = heading:lower():gsub("[^%w%s%-]", ""):gsub("%s+", "-")
      anchors[slug] = true
    end
  end
  for i, line in ipairs(lines) do
    for target in line:gmatch("%]%(#([%w%-]+)%)") do
      if not anchors[target] then
        table.insert(broken, string.format("line %d: #%s", i, target))
      end
    end
  end
  if #broken == 0 then
    vim.notify("All internal links resolve.")
  else
    vim.notify("Broken internal links:\n" .. table.concat(broken, "\n"), vim.log.levels.WARN)
  end
end, {})

vim.keymap.set("n", "<leader>eh", "<cmd>MarkdownExportHtml<CR>", { desc = "Export markdown to HTML and open in browser" })
vim.keymap.set("n", "<leader>ep", "<cmd>MarkdownExportPdf<CR>", { desc = "Export markdown to PDF" })
vim.keymap.set("n", "<leader>lc", "<cmd>MarkdownCheckLinks<CR>", { desc = "Check internal markdown links" })

-- Opens the bundled shortcut reference (nvim_shortcuts.md) in a split, the
-- same way Neovim's own :help does — so :q closes just that split and drops
-- you back on whatever you had open, instead of replacing your only window
-- (which would make :q close Neovim itself). stdpath("config") is
-- ~/.config/nvim, symlinked to this project by setup.sh, so this resolves
-- regardless of cwd. (nvim_shortcuts.html is still there too, for a full
-- searchable browser reference — preview this .md with <leader>p for an
-- HTML render.)
vim.api.nvim_create_user_command("MarkdownHelp", function()
  vim.cmd.split(vim.fn.stdpath("config") .. "/nvim_shortcuts.md")
end, {})
vim.keymap.set("n", "<leader>h", "<cmd>MarkdownHelp<CR>", { desc = "Open shortcut reference" })
