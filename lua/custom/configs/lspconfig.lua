local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
local lspconfig = require "lspconfig"

-- 1. Setup a global LspAttach autocmd (Recommended for 0.11+)
-- This ensures your keymaps and logic apply to all servers automatically
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    on_attach(client, bufnr)
  end,
})

-- 2. Define and Enable Servers using the new API

-- TypeScript
vim.lsp.config("ts_ls", {
  capabilities = capabilities,
  filetypes = { "javascript", "typescript", "typescriptreact", "typescript.tsx" },
  cmd = { "typescript-language-server", "--stdio" },
  init_options = {
    preferences = { disableSuggestions = true },
  },
})
vim.lsp.enable "ts_ls"

-- Solidity
vim.lsp.config("solidity", {
  capabilities = capabilities,
  cmd = { "nomicfoundation-solidity-language-server", "--stdio" },
  filetypes = { "solidity" },
  root_dir = lspconfig.util.root_pattern "foundry.toml",
  single_file_support = true,
})
vim.lsp.enable "solidity"

-- Pyright
vim.lsp.config("pyright", {
  capabilities = capabilities,
  filetypes = { "python" },
})
vim.lsp.enable "pyright"

-- Tailwind
vim.lsp.config("tailwindcss", { capabilities = capabilities })
vim.lsp.enable "tailwindcss"

-- Move Analyzer
vim.lsp.config("move_analyzer", {
  capabilities = capabilities,
  cmd = { os.getenv "HOME" .. "/.cargo/bin/move-analyzer" },
  filetypes = { "move" },
  root_dir = lspconfig.util.root_pattern("Move.toml", ".git"),
})
vim.lsp.enable "move_analyzer"

-- GraphQL
vim.lsp.config("graphql", {
  capabilities = capabilities,
  filetypes = { "javascript", "typescript", "typescriptreact", "graphql" },
  root_dir = lspconfig.util.root_pattern(".graphqlconfig", ".graphqlrc", "package.json"),
  flags = { debounce_text_changes = 150 },
})
vim.lsp.enable "graphql"

-- Typos
vim.lsp.config("typos_lsp", {
  capabilities = capabilities,
  cmd_env = { RUST_LOG = "error" },
  init_options = { diagnosticSeverity = "Error" },
})
vim.lsp.enable "typos_lsp"
