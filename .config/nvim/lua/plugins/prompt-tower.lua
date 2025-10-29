return {
  "kylesnowschwartz/prompt-tower.nvim",
  config = function()
    require("prompt-tower").setup({
      output_format = {
        default_format = "markdown",
        presets = {
          markdown = {
            block_template = "`{rawFilePath}`\n```{fileExtension}\n{fileContent}```",
            separator = "\n\nand\n\n",
            wrapper_template = "{fileBlocks}",
          },
        },
      },
      project_tree = {
        enabled = true,
        type = "selectedFilesOnly",
        template = "project tree:\n```\n{projectTree}\n```",
      },
      clipboard = {
        register = "+", -- System clipboard
        notify_on_copy = true,
      },
    })
  end,
  keymaps = {},
}
