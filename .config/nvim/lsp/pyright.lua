return {
  cmd = { "pyright-langserver", "--stdio" },
  name = "pyright",
  filetypes = { "python" },
  -- Root directory detection for Python projects.
  -- Common markers for a Python project include .git, pyproject.toml, requirements.txt,
  -- or the presence of a .venv directory.
  -- root_dir = function(fname)
  --   return vim.fs.find({ ".git", "pyproject.toml", "requirements.txt", ".venv" }, { upward = true, path = fname })[1] or vim.fs.dirname(fname) -- Fallback to current directory if no marker
  -- end,
  -- This function is called when the LSP client attaches to a buffer.
  -- You can set up buffer-local keymaps and other configurations here.
  -- If you have global on_attach defined in init.lua using vim.lsp.config['*'],
  -- these keymaps will be set after the global ones.
  on_attach = function(client, bufnr)
    -- Set buffer-local omnifunc for completion (important if not handled globally)
    vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"

    -- Example of buffer-local keymaps (if not using a global on_attach for all)
    local function buf_set_keymap(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
    end
    -- Common LSP keymaps (you might already have these in vim.lsp.config['*'])
    buf_set_keymap("n", "gd", vim.lsp.buf.definition, "Go to Definition")
    buf_set_keymap("n", "K", vim.lsp.buf.hover, "Hover Documentation")
    -- Pyright-specific commands/features if any, expose them here.
    -- Pyright doesn't have as many custom commands as Tinymist typically,
    -- but you could create user commands for specific refactorings or diagnostics.
  end,

  -- Pyright-specific settings.
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "strict",
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        exclude = {
          "**/node_modules",
          "**/__pycache__",
          ".venv/**",
          "env/**",
          "venv/**",
        },
        extraPaths = {
          "./src",
        },
        diagnosticSeverityOverrides = {
          reportUnusedImport = "warning",
          reportOptionalMemberAccess = "none",
        },
      },
    },
  },
}
