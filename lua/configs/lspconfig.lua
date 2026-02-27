local M = {}
local map = vim.keymap.set

M.on_attach = function(_, bufnr)
  local function opts(desc)
    return { buffer = bufnr, desc = "LSP " .. desc }
  end

  map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
  map("n", "gd", vim.lsp.buf.definition, opts "Go to definition")
  map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
  map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")

  map("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts "List workspace folders")

  map("n", "<leader>D", vim.lsp.buf.type_definition, opts "Go to type definition")
  map("n", "<leader>ra", require "nvchad.lsp.renamer", opts "NvRenamer")
end

M.on_init = function(client, _)
  if vim.fn.has "nvim-0.11" ~= 1 then
    if client.supports_method "textDocument/semanticTokens" then
      client.server_capabilities.semanticTokensProvider = nil
    end
  else
    if client:supports_method "textDocument/semanticTokens" then
      client.server_capabilities.semanticTokensProvider = nil
    end
  end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

M.defaults = function()
  dofile(vim.g.base46_cache .. "lsp")
  require("nvchad.lsp").diagnostic_config()

  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      M.on_attach(_, args.buf)
    end,
  })

  local lua_lsp_settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      workspace = {
        library = {
          vim.fn.expand "$VIMRUNTIME/lua",
          vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types",
          vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
          "${3rd}/luv/library",
        },
      },
    },
  }

  vim.lsp.config("*", { capabilities = M.capabilities, on_init = M.on_init })
  vim.lsp.config("lua_ls", { settings = lua_lsp_settings })
  vim.lsp.enable "lua_ls"

  vim.lsp.config("ts_ls", {
    capabilities = M.capabilities,
    filetypes = { "javascript", "typescript", "typescriptreact", "typescript.tsx" },
    cmd = { "typescript-language-server", "--stdio" },
    init_options = {
      preferences = { disableSuggestions = true },
    },
  })
  vim.lsp.enable "ts_ls"

  vim.lsp.config("tailwindcss", { capabilities = M.capabilities })
  vim.lsp.enable "tailwindcss"

  vim.lsp.config("move-analyzer", {
    capabilities = M.capabilities,
    cmd = { "move-analyzer" },
    filetypes = { "move" },
    root_markers = { "Move.toml", ".git" },
  })
  vim.lsp.enable "move-analyzer"

  vim.lsp.config("graphql", {
    capabilities = M.capabilities,
    filetypes = { "javascript", "typescript", "typescriptreact", "graphql" },
    root_dir = require("lspconfig").util.root_pattern(".graphqlconfig", ".graphqlrc", "package.json"),
    flags = { debounce_text_changes = 150 },
  })
  vim.lsp.enable "graphql"

  vim.lsp.config("typos_lsp", {
    capabilities = M.capabilities,
    cmd_env = { RUST_LOG = "error" },
    init_options = { diagnosticSeverity = "Error" },
  })
  vim.lsp.enable "typos_lsp"
end

return M
