local group = vim.api.nvim_create_augroup("autosave", { clear = true })

local function autosave()
    local buf = vim.api.nvim_get_current_buf()

    if vim.bo[buf].modified and vim.bo[buf].modifiable then
        vim.cmd("silent! write")
        vim.notify("Autosaved " .. vim.fn.expand("%:t"), vim.log.levels.INFO, {
            title = "Neovim",
            timeout = 100, -- stays subtle
        })
    end
end

vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
    group = group,
    callback = autosave,
})

vim.api.nvim_create_autocmd("FocusLost", {
    group = group,
    callback = autosave,
})
