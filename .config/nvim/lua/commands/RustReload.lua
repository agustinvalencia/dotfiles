-- Create a custom command to reload the Rust workspace
vim.api.nvim_create_user_command("RustReload", function()
  -- Find the active rust_analyzer client
  local clients = vim.lsp.get_active_clients({ name = "rust_analyzer", bufnr = 0 })
  if #clients == 0 then
    vim.notify("No rust-analyzer client found for the current buffer.", vim.log.levels.WARN)
    return
  end

  -- Send the request to the client
  local client = clients[1]
  local params = {
    command = "rust-analyzer.reloadWorkspace",
    arguments = {},
  }
  client.request("workspace/executeCommand", params, function(err, result)
    if err then
      vim.notify("Failed to send reload command: " .. tostring(err), vim.log.levels.ERROR)
      return
    end
    vim.notify("rust-analyzer workspace reloaded.", vim.log.levels.INFO)
  end)
end, { desc = "Reload the rust-analyzer workspace" })
