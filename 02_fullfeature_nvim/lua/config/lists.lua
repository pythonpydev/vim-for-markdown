-- Enter-key list/blockquote continuation, shared by the global insert-mode
-- <CR> map (lua/config/keymaps.lua, "- " bullets in any filetype) and the
-- markdown buffer-local one (lua/plugins/markdown.lua, blockquotes, falling
-- back to autolist.nvim for ordinary lists).

local M = {}

local function feed(keys)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), "ni", false)
end
M.feed = feed

-- Blockquote prefix at the start of `line` ("> ", ">> ", "> > ", with any
-- leading indent), or nil.
local function quote_prefix(line)
  local pos = line:match("^%s*()>")
  if not pos then return nil end
  pos = pos + 1
  while true do
    local nxt = line:match("^%s*()>", pos)
    if not nxt then break end
    pos = nxt + 1
  end
  if line:sub(pos, pos):match("%s") then pos = pos + 1 end
  return line:sub(1, pos - 1)
end

-- Bullet ("- item", "- [ ] item"; `class` picks which markers count) at the
-- start of `text`: returns indent, marker, rest.
local function bullet(text, class)
  local indent, marker, rest = text:match("^(%s*)(" .. class .. "%s+%[[ xX]%]%s+)(.*)$")
  if not indent then indent, marker, rest = text:match("^(%s*)(" .. class .. "%s+)(.*)$") end
  return indent, marker and marker:gsub("%[[xX]%]", "[ ]"), rest
end

local function set_line(row, text, cursor)
  vim.api.nvim_buf_set_lines(0, row - 1, row, true, { text })
  if cursor then vim.api.nvim_win_set_cursor(0, { row, #text }) end
end

-- Handle <CR> if the cursor is on a line this continues; returns false
-- (having done nothing) otherwise so the caller can fall back.
-- Markdown: blockquotes only (autolist.nvim owns ordinary lists there).
--   "> text"      -> next line starts "> " (nested ">> " / "> > " kept)
--   "> - item"    -> next line starts "> - "; empty "> - " -> back to "> "
--   empty "> "    -> becomes a bare ">" paragraph separator, next line "> "
--   2nd empty "> " in a row -> quote ends, separator becomes a blank line
-- Other filetypes: "- " bullets only (not "* ", which C/Java block comments
-- already continue themselves). Enter on an empty bullet ends the list.
function M.enter()
  if vim.fn.pumvisible() == 1 or vim.bo.buftype ~= "" then return false end
  local line = vim.api.nvim_get_current_line()
  local row = vim.api.nvim_win_get_cursor(0)[1]
  local at_end = vim.fn.col(".") > #line
  local ai = vim.bo.autoindent -- <CR> already copies the line's leading indent

  if vim.bo.filetype == "markdown" then
    local q = quote_prefix(line)
    if not q then return false end
    local qn = q:match("%s$") and q or q .. " "
    local pre = ai and qn:sub(#q:match("^%s*") + 1) or qn
    local body = line:sub(#q + 1)
    local indent, marker, rest = bullet(body, "[%-*+]")
    if indent then
      if rest == "" and at_end then
        set_line(row, qn, true)
      else
        feed("<CR>" .. pre .. indent .. marker)
      end
    elseif body:match("^%s*$") and at_end then
      local prev = row > 1 and vim.fn.getline(row - 1) or ""
      local pq = quote_prefix(prev)
      if pq and prev:sub(#pq + 1):match("^%s*$") then
        set_line(row - 1, "")
        set_line(row, "", true)
      else
        set_line(row, (q:gsub("%s+$", "")), true)
        feed("<CR>" .. pre)
      end
    else
      feed("<CR>" .. pre)
    end
    return true
  end

  local indent, marker, rest = bullet(line, "%-")
  if not indent then return false end
  if rest == "" and at_end then
    set_line(row, "", true)
  else
    feed("<CR>" .. (ai and "" or indent) .. marker)
  end
  return true
end

return M
