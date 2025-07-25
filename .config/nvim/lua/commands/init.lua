-- ~/.config/nvim/lua/commands/init.lua

-- Define the directory where command files are located.
-- vim.fn.stdpath('config') returns the base Neovim config directory (e.g., ~/.config/nvim)
local commands_dir = vim.fn.stdpath("config") .. "/lua/commands"

-- Use vim.fs.find to reliably get a list of all .lua files in the directory.
-- It returns an iterator that yields file paths.
-- The first argument is a predicate function to filter file names.
-- The second argument is a table of options:
--   - 'path': The directory to start the search.
--   - 'limit': 0 means no limit (find all matching files).
--   - 'type': 'file' ensures we only find files, not directories.
local command_files_iterator = vim.fs.find(function(name)
  return name:match("%.lua$") -- Check if the file name ends with .lua
end, {
  path = commands_dir,
  limit = 0, -- Limit 0 means no limit (find all matching files)
  type = "file", -- Only find files
})

-- Iterate through the found files and require each one.
-- vim.fs.find returns a list, so we can iterate over it directly.
for _, file_path in ipairs(command_files_iterator) do
  -- Extract the module name from the file path.
  -- e.g., from "/path/to/nvim/lua/commands/lua_resource_command.lua"
  -- we want "commands.lua_resource_command"
  local relative_path = file_path:sub(#(vim.fn.stdpath("config") .. "/lua/") + 1) -- Get path relative to lua/
  local module_name = relative_path:gsub("/", "."):gsub("%.lua$", "") -- Replace / with . and remove .lua extension

  -- IMPORTANT: Skip loading 'commands.init' to prevent a recursive loop
  if module_name == "commands.init" then
    goto continue_loop -- Skip to the next iteration
  end

  -- Attempt to require the module using pcall for protected execution.
  -- This prevents a single error in a command file from crashing Neovim startup.
  local success, err = pcall(require, module_name)
  if not success then
    vim.notify("Error loading command module '" .. module_name .. "': " .. err, vim.log.levels.ERROR)
  end
  ::continue_loop:: -- Label for goto statement
end

-- You can add any other shared setup or initialisation for your commands here if needed.
