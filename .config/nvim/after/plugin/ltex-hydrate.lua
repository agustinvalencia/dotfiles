-- after/plugin/ltex-hydrate.lua
-- Merge external dictionary files into ltex.dictionary every time the client attaches.

local function read_lines(path)
  if vim.fn.filereadable(path) ~= 1 then
    return {}
  end
  local out = {}
  for _, line in ipairs(vim.fn.readfile(path)) do
    line = (line or ""):gsub("%s+$", "")
    if line ~= "" and not line:match("^#") then
      table.insert(out, line)
    end
  end
  return out
end

local function uinsert(t, v)
  for _, x in ipairs(t) do
    if x == v then
      return
    end
  end
  table.insert(t, v)
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("LtexHydrate", { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client or client.name ~= "ltex" or client._ltex_hydrated then
      return
    end
    client._ltex_hydrated = true

    -- prepare settings table
    client.config.settings = client.config.settings or {}
    client.config.settings.ltex = client.config.settings.ltex or {}
    local ltex = client.config.settings.ltex
    ltex.dictionary = ltex.dictionary or {}

    local cfg = vim.fn.stdpath("config")
    local langs = { "en-GB", "es-ES", "sv-SE" }

    for _, lang in ipairs(langs) do
      local file = string.format("%s/ltex/%s.txt", cfg, lang)
      local words = read_lines(file)

      ltex.dictionary[lang] = ltex.dictionary[lang] or {}
      -- keep colon path (for persistence / human editing)
      uinsert(ltex.dictionary[lang], ":" .. file)
      -- ALSO inject each word so the server sees them immediately
      for _, w in ipairs(words) do
        uinsert(ltex.dictionary[lang], w)
      end
    end

    -- tell server settings changed
    client:notify("workspace/didChangeConfiguration", { settings = client.config.settings })

    -- re-check current buffer so diagnostics update now
    local uri = vim.uri_from_bufnr(args.buf)
    client.request("workspace/executeCommand", { command = "_ltex.checkDocument", arguments = { { uri = uri } } }, function() end, args.buf)
  end,
})
