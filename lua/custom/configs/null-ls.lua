local null_ls = require "null-ls"

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
  formatting.prettier.with { extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } },

  -- Lua
  b.formatting.stylua,

}

null_ls.setup {
  debug = true,
  sources = sources,
}
