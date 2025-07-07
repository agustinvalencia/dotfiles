-- Define a custom Neovim command to resource Lua files.
-- This allows you to reload Neovim settings from a Lua script
-- without having to exit and restart Neovim.
vim.api.nvim_create_user_command(
    "LuaResource", -- The name of the command (e.g., :LuaResource)
    function(opts)
        local file_path = opts.args
        local current_buf_file = vim.api.nvim_buf_get_name(0)

        -- If no argument is provided, try to resource the current file
        if not file_path or file_path == "" then
            -- Check if the current buffer has a file name and is a Lua file
            if current_buf_file and current_buf_file:match("%.lua$") then
                file_path = current_buf_file
                vim.notify("Attempting to resource current file: " .. file_path, vim.log.levels.INFO)
            else
                vim.notify("Usage: :LuaResource <path/to/lua/file.lua> or open a Lua file to use without arguments.",
                    vim.log.levels.WARN)
                return
            end
        end

        -- Check if the file path is provided and is a string
        if not file_path or type(file_path) ~= "string" then
            vim.notify("Invalid file path provided.", vim.log.levels.ERROR)
            return
        end

        -- Ensure the path uses forward slashes for cross-platform compatibility
        file_path = file_path:gsub("\\", "/")

        -- Attempt to execute (source) the Lua file
        -- pcall is used for protected call, which helps catch errors during execution
        local success, err = pcall(function()
            vim.cmd("source " .. file_path) -- Use vim.cmd.source to execute the file
        end)

        if success then
            vim.notify("Successfully sourced: " .. file_path, vim.log.levels.INFO)
        else
            vim.notify("Error sourcing file '" .. file_path .. "': " .. err, vim.log.levels.ERROR)
        end
    end,
    {
        nargs = "?",                                        -- The command takes zero or one argument (the file path)
        complete = "file",                                  -- Enable file path completion for the argument
        desc = "Resource a Lua file to update Neovim settings", -- Description for the command
    }
)

-- Create a keybinding for quick run with proper descriptions for which-key
vim.keymap.set("n", "<leader>rL", "<cmd>LuaResource<CR>", {
    desc = "Reload Current Lua Config", -- Description shown by which-key
})

-- Example usage of the command (you would type this in Neovim's command line):
-- :LuaResource ~/.config/nvim/lua/my_plugin_config.lua
-- :LuaResource C:/Users/YourUser/AppData/Local/nvim/init.lua
-- :LuaResource       -- This will resource the current open Lua file
