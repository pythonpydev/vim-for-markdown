-- Static HTML/PDF export (via Pandoc), spell-check/wrap defaults, and simple
-- internal link/anchor checking + jump-to-file for markdown links.
-- Loaded directly from init.lua (not a lazy.nvim plugin spec) so it's always
-- available regardless of plugin load order/triggers.

local group = vim.api.nvim_create_augroup("markdown_setup", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = "markdown",
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en_gb"
    vim.opt_local.wrap = true
    vim.opt_local.conceallevel = 2
    -- lets `gf` resolve bare `[text](other-file)` links without extension
    vim.opt_local.suffixesadd:append(".md")
    vim.opt_local.includeexpr = "substitute(v:fname,'#.*','','')"
  end,
})

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
