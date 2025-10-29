return {
  "echasnovski/mini.surround",
  version = "*",
  opts = {
    mappings = {
      add = "<leader>sa",
      delete = "<leader>sd",
      highlight = "<leader>sh",
      replace = "<leader>sr",
      find = "",
      find_left = "",
    },
    custom_surroundings = {
      ["{"] = { output = { left = "{", right = "}" } },
      ["}"] = { output = { left = "{", right = "}" } },
      ["["] = { output = { left = "[", right = "]" } },
      ["]"] = { output = { left = "[", right = "]" } },
      ["("] = { output = { left = "(", right = ")" } },
      [")"] = { output = { left = "(", right = ")" } },
      ["<"] = { output = { left = "<", right = ">" } },
      [">"] = { output = { left = "<", right = ">" } },
    },
  },
  -- keys = {
  --   { "<leader>s", group = "surround", desc = "Surround" },
  -- },
}
