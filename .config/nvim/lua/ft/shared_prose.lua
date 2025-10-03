local M = {}

-- public API
function M.apply_common()
  vim.opt_local.expandtab = true
  vim.opt_local.shiftwidth = 2
  vim.opt_local.tabstop = 2
  vim.opt_local.softtabstop = 2
  vim.opt_local.textwidth = 100
  vim.opt_local.colorcolumn = "100"
  vim.opt_local.wrap = true
  vim.opt_local.linebreak = true
  vim.opt_local.spell = true
  vim.opt_local.spelllang = "en_gb,es,sv"
  vim.opt_local.conceallevel = 2
end

function M.apply_commentstring(ft)
  local cs = {
    tex = "%% %s",
    bib = "%% %s",
    typst = "// %s",
    markdown = "<!-- %s -->",
  }
  if cs[ft] then
    vim.opt_local.commentstring = cs[ft]
  end
end

return M
