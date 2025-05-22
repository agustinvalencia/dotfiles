# NVIM Configs

Through the years I've used several of these so called "nvim distros" just out of lazyness -pun not intended-, the latest I used was kickstart.nvim. But too many things that I do not use. So, being 2025, I will start over because I no longer know what is where and why.

I'll document the progress here.

## Directory Structure

Create the following layout under ~/.config/nvim/:

```
~/.config/nvim/
  ├── init.lua
  └── lua/
    └── plugins/
      ├── mason.lua
      ├── mason-null-ls.lua
      ├── lspconfig.lua
      ├── cmp.lua
      ├── none-ls.lua
      ├── treesitter.lua
      └── whichkey.lua
```

Every file in lua/plugins/ exports exactly the plugin spec(s) for one feature. There is no plugins/init.lua—lazy.nvim will discover them automatically. ￼

⸻

### 1. Bootstrapping lazy.nvim

Place this in `init.lua`:

```lua
-- init.lua
-- 1) Clone lazy.nvim if it's not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", lazypath,
    })
end
-- 2) Prepend to runtime path
vim.opt.rtp:prepend(lazypath)
-- 3) Import all specs under lua/plugins/
require("lazy").setup({ spec = { { import = "plugins" } } })
```

### 2. Managing external tools with Mason

Mason.nvim centralizes the installation of LSP servers, debuggers (DAP), linters, and formatters in one UI.

Instead of juggling Homebrew, npm, or pip calls on the command line, you can install and update all your developer tools from inside Neovim with :Mason.

Create `lua/plugins/mason.lua`:

```lua
-- mason.lua
return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "pyright", "tsserver" },
      })
    end,
  },
}
```

### 3. Formatters and linters

Mason-null-ls.nvim extends Mason to install command-line tools that LSP-bridge plugins (like none-ls) require.

It automates fetching `ruff` for Python linting/formatting and the `prettier` binary for JavaScript/TypeScript/React, without extra shell scripts.

`lua/plugins/mason-null-ls.lua`

```lua
-- mason-null-ls.lua
return {
  {
    "jay-babu/mason-null-ls.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
    config = function()
      require("mason-null-ls").setup({
        ensure_installed = { "ruff", "prettier" },
        automatic_installation = true,
      })
    end,
  },
}
```

This setup guarantees that both ruff and prettier are available for your formatting pipeline

### 4. Bridging Tools into LSP with none-ls.nvim

The original null-ls.nvim was archived in August 2023; none-ls.nvim is its actively maintained community fork that injects external tooling (diagnostics, code actions, formatting) into Neovim’s LSP client.

You get a unified LSP-style API to run `ruff --fix`, `prettier`, and any other external tool, with minimal configuration.

Add `lua/plugins/none-ls.lua`:

```lua
-- none-ls.lua
return {
  {
    "nvimtools/none-ls.nvim",
    dependencies = { "jay-babu/mason-null-ls.nvim" },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.diagnostics.ruff,
          null_ls.builtins.formatting.ruff.with({ extra_args = { "--fix" } }),
          null_ls.builtins.formatting.prettier,
        },
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group="LspFormatting", buffer=bufnr })
            vim.api.nvim_create_augroup("LspFormatting", {})
            vim.api.nvim_create_autocmd("BufWritePre", {
              group    = "LspFormatting",
              buffer   = bufnr,
              callback = function() vim.lsp.buf.format() end,
            })
          end
        end,
      })
    end,
  },
}
```

### 5. Configuring LSP & Symbol Renaming

nvim-lspconfig provides ready-made configurations for dozens of LSP servers. We’ll hook into it, enable IntelliSense capabilities, and bind keys for navigation and refactoring.

You get diagnostics, go-to-definition, hover docs, and, crucially, project-wide symbol renaming (`vim.lsp.buf.rename`) with a single keybinding.

In `lua/plugins/lspconfig.lua`:

```lua
-- lspconfig.lua
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local caps = require("cmp_nvim_lsp").default_capabilities()
      local on_attach = function(_, bufnr)
        local opts = { noremap=true, silent=true, buffer=bufnr }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "K",  vim.lsp.buf.hover,      opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
      end

      lspconfig.pyright.setup({ capabilities=caps, on_attach=on_attach })
      lspconfig.tsserver.setup({ capabilities=caps, on_attach=on_attach })
    end,
  },
}
```

6. IntelliSense-Style Completion with nvim-cmp

nvim-cmp is a modular completion engine that pulls suggestions from LSP, buffer words, and filesystem paths.

It replicates a VS Code–like UX inside Neovim: popup suggestions as you type, manual trigger with `<C-Space>`, and confirm with `<CR>`.

In `lua/plugins/cmp.lua`:

```lua
-- cmp.lua
return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"]      = cmp.mapping.confirm({ select = true }),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "buffer"   },
          { name = "path"     },
        },
      })
    end,
  },
}
```

If you later need completion from Neovim’s Lua API or snippets, you can add sources like cmp-nvim-lua or cmp-vsnip

### 7. Robust Highlighting with nvim-treesitter

nvim-treesitter leverages parser-based highlighting for unmatched accuracy and supports incremental selections and other advanced features.

Unlike regex-based syntax rules, Tree-sitter understands language grammar, so highlighting, indentation, and movements are far more reliable.

Add `lua/plugins/treesitter.lua`:

```lua
-- treesitter.lua
return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "python", "javascript", "typescript", "tsx" },
        highlight        = { enable = true },
      })
    end,
  },
}
```

### 8. Interactive Key Hints with WhichKey

which-key.nvim pops up a menu of valid keybindings whenever you press your leader key (or any prefix).

As your personal Neovim config grows, remembering every mapping becomes impractical. WhichKey teaches you your own shortcuts in context.

In `lua/plugins/whichkey.lua`:

```lua
-- whichkey.lua
return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      local wk = require("which-key")
      wk.setup()  -- use defaults
      wk.register({
        r = {
          name = "Refactor",
          n = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename Symbol" },
        },
      }, { prefix = "<leader>" })
    end,
  },
}
```
