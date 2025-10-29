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
  vim.opt_local.conceallevel = 2
  vim.opt_local.spell = false
  vim.opt_local.spelllang = "en_gb"
  vim.b.ltex_language = "en-GB"
  vim.opt_local.spellfile:append(vim.fn.stdpath("config") .. "/spell/en.utf-8.add")
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
