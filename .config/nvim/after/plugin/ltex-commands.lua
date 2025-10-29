-- Handle LTeX client-side command: _ltex.addToDictionary
-- Persist words to ~/.config/nvim/ltex/<lang>.txt AND inject them into the live ltex.dictionary.
-- Then nudge the server to re-check the current document.

vim.lsp.commands["_ltex.addToDictionary"] = function(command, ctx)
  local arg = command.arguments and command.arguments[1]
  if type(arg) ~= "table" or type(arg.words) ~= "table" then
    return
  end

  local client = vim.lsp.get_client_by_id(ctx.client_id)
  if not client or client.name ~= "ltex" then
    return
  end

  -- 1) Ensure persistence dir
  local cfgdir = vim.fn.stdpath("config")
  local dictdir = cfgdir .. "/ltex"
  vim.fn.mkdir(dictdir, "p")

  -- 2) Ensure settings tables exist
  client.config.settings = client.config.settings or {}
  client.config.settings.ltex = client.config.settings.ltex or {}
  local ltex = client.config.settings.ltex
  ltex.dictionary = ltex.dictionary or {}

  -- Helper: unique insert into a list
  local function uinsert(list, item)
    for _, v in ipairs(list) do
      if v == item then
        return
      end
    end
    table.insert(list, item)
  end

  -- 3) Apply for each language
  for lang, words in pairs(arg.words) do
    if type(words) == "table" then
      -- 3a) persist to file
      local file = string.format("%s/%s.txt", dictdir, lang)
      local lines = vim.fn.filereadable(file) == 1 and vim.fn.readfile(file) or {}
      local seen = {}
      for _, l in ipairs(lines) do
        seen[l] = true
      end
      for _, w in ipairs(words) do
        if type(w) == "string" and not seen[w] then
          table.insert(lines, w)
          seen[w] = true
        end
      end
      vim.fn.writefile(lines, file)

      -- 3b) make sure external file path is listed (use colon prefix convention)
      ltex.dictionary[lang] = ltex.dictionary[lang] or {}
      uinsert(ltex.dictionary[lang], ":" .. file)

      -- 3c) ALSO inject the words themselves so the server sees them immediately
      for _, w in ipairs(words) do
        if type(w) == "string" then
          uinsert(ltex.dictionary[lang], w)
        end
      end
    end
  end

  -- 4) Tell the server config changed
  client:notify("workspace/didChangeConfiguration", { settings = client.config.settings })

  -- 5) Trigger a fresh check of this document (server-handled command)
  local uri = vim.uri_from_bufnr(ctx.bufnr)
  client.request("workspace/executeCommand", { command = "_ltex.checkDocument", arguments = { { uri = uri } } }, function() end, ctx.bufnr)
end
