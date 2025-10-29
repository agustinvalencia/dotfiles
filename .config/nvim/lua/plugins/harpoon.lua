return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  setup = function()
    local harpoon = require("harpoon")
    harpoon:setup()
  end,
  keys = {
        
-- stylua: ignore start
{ "<leader>h", group="harpoon", desc="Harpoon"},
{ "<leader>ha", function() require'harpoon':list():add()     end,   desc="Add"      },
{ "<leader>h1", function() require'harpoon':list():select(1) end,   desc="Go to 1"  },
{ "<leader>h2", function() require'harpoon':list():select(2) end,   desc="Go to 2"  },
{ "<leader>h3", function() require'harpoon':list():select(3) end,   desc="Go to 3"  },
{ "<leader>h4", function() require'harpoon':list():select(4) end,   desc="Go to 4"  },
{ "<leader>h5", function() require'harpoon':list():select(5) end,   desc="Go to 5"  },
{ "<leader>hp", function() require'harpoon':list():prev()    end,   desc="Previous" },
{ "<leader>hn", function() require'harpoon':list():next()    end,   desc="Next"     },
{ "<leader>hu", function() require'harpoon'.ui:toggle_quick_menu(require 'harpoon':list()) end, desc="UI"},
    -- stylua: ignore end
  },
}
