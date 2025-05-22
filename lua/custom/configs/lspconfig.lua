local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local util = require "lspconfig/util"

-- if you just want default config for the servers then put them in a table

--for _, lsp in ipairs(servers) do
--  lspconfig[lsp].setup {
--    on_attach = on_attach,
--    capabilities = capabilities,
--  }
--end

--
-- lspconfig.pyright.setup { blabla}
lspconfig.ts_ls.setup {
  on_attach = on_attach,
  filetypes = { "javascript", "typescript", "typescriptreact", "typescript.tsx" },
  cmd = { "typescript-language-server", "--stdio" },
  init_options = {
    preferences = {
      disableSuggestions = true,
    },
  },
}

-- solidity
lspconfig.solidity.setup {
  cmd = { "nomicfoundation-solidity-language-server", "--stdio" },
  filetypes = { "solidity" },
  util.root_pattern "foundry.toml",
  single_file_support = true,
}

lspconfig.pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "python" },
}

lspconfig.tailwindcss.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
-- LSP
local move_analyzer_id
lspconfig.move_analyzer.setup {
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    move_analyzer_id = client.id
  end,
  capabilities = capabilities,
  cmd = { os.getenv "HOME" .. "/.cargo/bin/move-analyzer" },
  filetypes = { "move" },
  root_dir = util.root_pattern("Move.toml", ".git"),
}

vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    if move_analyzer_id then
      vim.lsp.stop_client(move_analyzer_id, true)
    end
  end,
})

-- lspconfig.gopls.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
--   cmd = { "gopls" },
--   filetypes = { "go", "gomod", "gowork", "gotmpl" },
--   root_dir = util.root_pattern("go.work", "go.mod", ".git"),
--   settings = {
--     gopls = {
--       CompleteUnimported = true,
--       usePlaceholders = true,
--       analyses = {
--         unusedparams = true,
--       },
--     },
--   },
-- }

lspconfig.graphql.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "javascript", "typescript", "typescriptreact", "graphql" },
  root_dir = lspconfig.util.root_pattern(".graphqlconfig", ".graphqlrc", "package.json"),
  flags = {
    debounce_text_changes = 150,
  },
}

lspconfig.typos_lsp.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  -- Logging level of the language server. Logs appear in :LspLog. Defaults to error.
  cmd_env = { RUST_LOG = "error" },
  init_options = {
    -- Custom config. Used together with a config file found in the workspace or its parents,
    -- taking precedence for settings declared in both.
    -- Equivalent to the typos `--config` cli argument.
    -- How typos are rendered in the editor, can be one of an Error, Warning, Info or Hint.
    -- Defaults to error.
    diagnosticSeverity = "Error",
  },
}
-- rust
-- lspconfig.rust_analyzer.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
--   filetypes = { "rust" },
--   root_dir = util.root_pattern "Cargo.toml",
--   settings = {
--     ["rust_analyzer"] = {
--       checkOnSave = {
--         extraArgs = { "--target-dir", "/tmp/rust-analyzer-check" },
--       },
--       cargo = {
--         allFeatures = true,
--       },
--     },
--   },
-- }
