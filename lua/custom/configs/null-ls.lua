local null_ls = require "null-ls"
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local b = null_ls.builtins
local formatting = null_ls.builtins.formatting
local lint = null_ls.builtins.diagnostics

local sources = {
  formatting.stylua,
  formatting.black,
  lint.shellcheck,
  --  lint.mypy.with {
  --    extra_args = function()
  --      local virtual = os.getenv "VIRTUAL_ENV" or os.getenv "CONDA_DEFAULT_ENV" or "/usr"
  --      return { "--python-executable", virtual .. "/bin/python3", "--ignore-missing-imports" }
  --    end,
  --  },
  -- webdev stuff
  -- formatting.prettier.with { extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } },
  formatting.prettier.with {
    extra_args = { "--double-quote", "--jsx-double-quote" },
  },

  -- Lua
  b.formatting.stylua,

  -- Golanf
  formatting.gofumpt,
  formatting.goimports_reviser,
  formatting.golines,
}

null_ls.setup {
  debug = true,
  sources = sources,
  on_attach = function(client, bufnr)
    if client.supports_method "textDocument/formatting" then
      vim.api.nvim_clear_autocmds {
        group = augroup,
        buffer = bufnr,
      }
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format { bufnr = bufnr }
        end,
      })
    end
  end,
}
