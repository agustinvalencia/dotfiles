-- lua/config/wrapping.lua
-- Auto wrap policy + reliable reflow (ignores LSP/formatters when reflowing)

-- ---------------------------------------------------------------------------
-- Settings & toggles
-- ---------------------------------------------------------------------------
vim.g.wrap_auto_enabled = true -- global automation on/off
vim.g.prose_wrap_mode = "hard" -- "hard" (textwidth=100) or "soft"
vim.g.wrap_auto_reflow_on_save = true -- reflow prose automatically on save

local PROSE_FT = {
  markdown = true,
  typst = true,
  tex = true,
  plaintex = true,
  rst = true,
  asciidoc = true,
  gitcommit = true,
  text = true,
}
local PROSE_EXT = { md = true, typ = true, tex = true, rst = true, adoc = true, txt = true }

local SKIP_BUFTYPE = {
  acwrite = true,
  help = true,
  nofile = true,
  nowrite = true,
  prompt = true,
  quickfix = true,
  terminal = true,
}

-- ---------------------------------------------------------------------------
-- Helpers
-- ---------------------------------------------------------------------------
local function should_skip(bufnr)
  if not vim.api.nvim_buf_is_valid(bufnr) then
    return true
  end
  local bt = vim.bo[bufnr].buftype
  return SKIP_BUFTYPE[bt] or false
end

local function is_prose(bufnr)
  local ft = vim.bo[bufnr].filetype
  if PROSE_FT[ft] then
    return true
  end
  local name = vim.api.nvim_buf_get_name(bufnr)
  local ext = name:match("%.([%w]+)$")
  return ext and PROSE_EXT[ext] or false
end

-- Preserve & restore window view and cursor
local function preserve_view(fn)
  local ok, view = pcall(vim.fn.winsaveview)
  local cur = vim.api.nvim_win_get_cursor(0)
  local ret = { pcall(fn) }
  if ok then
    pcall(vim.fn.winrestview, view)
  end
  pcall(vim.api.nvim_win_set_cursor, 0, cur)
  return unpack(ret)
end

-- Run a function with internal formatter (disable LSP/formatprg temporarily)
local function with_internal_formatter(bufnr, fn)
  local save_expr = vim.bo[bufnr].formatexpr
  local save_prg = vim.bo[bufnr].formatprg
  vim.bo[bufnr].formatexpr = ""
  vim.bo[bufnr].formatprg = ""
  local ok, err = preserve_view(fn)
  vim.bo[bufnr].formatexpr = save_expr
  vim.bo[bufnr].formatprg = save_prg
  if not ok then
    vim.notify("Reflow error: " .. tostring(err), vim.log.levels.ERROR)
  end
end

-- ---------------------------------------------------------------------------
-- Policy application
-- ---------------------------------------------------------------------------
local function set_prose_opts_hard()
  local o = vim.opt_local
  o.wrap = false
  o.linebreak = false
  o.breakindent = true
  o.textwidth = 100
  o.colorcolumn = "100"
  o.joinspaces = false
  vim.opt_local.formatoptions:remove("l")
  vim.opt_local.formatoptions:append("tcqrnj") -- t=auto-wrap to textwidth
end

local function set_prose_opts_soft()
  local o = vim.opt_local
  o.wrap = true
  o.linebreak = true
  o.breakindent = true
  o.textwidth = 0
  o.colorcolumn = ""
  o.joinspaces = false
  vim.opt_local.formatoptions:remove("t")
  vim.opt_local.formatoptions:append("cqrnj")
end

local function set_code_opts()
  local o = vim.opt_local
  o.wrap = false
  o.linebreak = false
  o.breakindent = false
  o.textwidth = 0
  o.colorcolumn = "100"
  o.joinspaces = false
end

local function apply_wrap_policy(bufnr)
  if not vim.g.wrap_auto_enabled then
    return
  end
  if should_skip(bufnr) then
    return
  end
  if is_prose(bufnr) then
    if vim.g.prose_wrap_mode == "hard" then
      set_prose_opts_hard()
    else
      set_prose_opts_soft()
    end
  else
    set_code_opts()
  end
end

-- ---------------------------------------------------------------------------
-- Reflow (format to textwidth), using internal formatter
-- ---------------------------------------------------------------------------
local function reflow_range(sline, eline)
  with_internal_formatter(0, function()
    vim.cmd(string.format("silent! %d,%dgq", sline, eline))
  end)
end

local function reflow_paragraph()
  with_internal_formatter(0, function()
    vim.cmd("silent! normal! gqap")
  end)
end

local function reflow_buffer_plain()
  local tw = vim.bo.textwidth
  if tw == 0 then
    vim.notify("Reflow aborted: textwidth=0", vim.log.levels.WARN)
    return
  end
  with_internal_formatter(0, function()
    vim.cmd("silent! keepjumps keeppatterns normal! gggqG")
  end)
end

-- Markdown-smart reflow: skip fenced code and table-like lines
local function reflow_markdown_smart()
  if vim.bo.filetype ~= "markdown" then
    reflow_buffer_plain()
    return
  end
  local tw = vim.bo.textwidth
  if tw == 0 then
    vim.notify("Reflow aborted: textwidth=0", vim.log.levels.WARN)
    return
  end

  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local in_code, start_idx = false, nil

  local function is_blank(s)
    return s:match("^%s*$") ~= nil
  end
  local function is_fence(s)
    return s:match("^%s*```") or s:match("^%s*~~~")
  end
  local function is_table_line(s)
    return s:find("|", 1, true) ~= nil or s:match("^%s*%|?-+[%|:%- ]*-+%|?%s*$") ~= nil
  end
  local function flush_paragraph(s_idx, e_idx)
    if not s_idx or not e_idx or e_idx < s_idx then
      return
    end
    reflow_range(s_idx, e_idx)
  end

  with_internal_formatter(0, function()
    for i = 1, #lines do
      local s = lines[i]
      if is_fence(s) then
        if not in_code and start_idx then
          flush_paragraph(start_idx, i - 1)
          start_idx = nil
        end
        in_code = not in_code
      elseif in_code or is_table_line(s) then
        if start_idx then
          flush_paragraph(start_idx, i - 1)
          start_idx = nil
        end
      else
        if is_blank(s) then
          flush_paragraph(start_idx, i - 1)
          start_idx = nil
        else
          start_idx = start_idx or i
        end
      end
    end
    flush_paragraph(start_idx, #lines)
  end)
end

-- ---------------------------------------------------------------------------
-- Commands & keymaps
-- ---------------------------------------------------------------------------
vim.api.nvim_create_user_command("WrapAutoToggle", function()
  vim.g.wrap_auto_enabled = not vim.g.wrap_auto_enabled
  if vim.g.wrap_auto_enabled then
    apply_wrap_policy(0)
  end
  vim.notify("Auto wrap: " .. (vim.g.wrap_auto_enabled and "ON" or "OFF"))
end, {})

vim.api.nvim_create_user_command("ProseWrapModeToggle", function()
  vim.g.prose_wrap_mode = (vim.g.prose_wrap_mode == "hard") and "soft" or "hard"
  apply_wrap_policy(0)
  vim.notify("Prose wrap mode: " .. vim.g.prose_wrap_mode:upper())
end, {})

vim.api.nvim_create_user_command("ReflowParagraph", reflow_paragraph, {})
vim.api.nvim_create_user_command("ReflowBuffer", reflow_buffer_plain, {})
vim.api.nvim_create_user_command("ReflowMarkdownSmart", reflow_markdown_smart, {})

vim.keymap.set("n", "<leader>aw", "<cmd>WrapAutoToggle<CR>", { desc = "Toggle auto wrap policy" })
vim.keymap.set("n", "<leader>pm", "<cmd>ProseWrapModeToggle<CR>", { desc = "Toggle prose wrap mode (hard/soft)" })
vim.keymap.set("n", "<leader>rp", "<cmd>ReflowParagraph<CR>", { desc = "Reflow paragraph to textwidth" })
vim.keymap.set("n", "<leader>rb", "<cmd>ReflowBuffer<CR>", { desc = "Reflow entire buffer to textwidth" })
vim.keymap.set("n", "<leader>rm", "<cmd>ReflowMarkdownSmart<CR>", { desc = "Reflow Markdown (smart)" })

-- ---------------------------------------------------------------------------
-- Autocmds: apply policy on enter/filetype; reflow on save for prose
-- ---------------------------------------------------------------------------
local grp = vim.api.nvim_create_augroup("WrapAutoPolicy", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
  group = grp,
  callback = function(args)
    pcall(apply_wrap_policy, args.buf)
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  group = grp,
  callback = function(args)
    if not vim.g.wrap_auto_reflow_on_save then
      return
    end
    if not vim.g.wrap_auto_enabled then
      return
    end
    local bufnr = args.buf
    if should_skip(bufnr) or not is_prose(bufnr) then
      return
    end
    if vim.g.prose_wrap_mode ~= "hard" then
      return
    end
    if vim.bo[bufnr].textwidth == 0 then
      return
    end

    if vim.bo[bufnr].filetype == "markdown" then
      reflow_markdown_smart()
    else
      reflow_buffer_plain()
    end
  end,
})
