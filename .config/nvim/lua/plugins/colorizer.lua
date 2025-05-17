return {
  'catgoose/nvim-colorizer.lua',
  event = 'BufReadPre',
  opts = { -- set to setup table
    user_defaults_options = {
      name = false,
    },
    tailwind = true,
  },
}
