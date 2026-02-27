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
  map("n", "<leader>ca", vim.lsp.buf.code_action, opts "Code Action")
  map("n", "gi", vim.lsp.buf.implementation, opts "Go to implementation")
  map("n", "K", vim.lsp.buf.hover, opts "Hover")
  map("n", "<leader>cr", vim.lsp.buf.rename, opts "Rename")
end

M.on_init = function(client, _)
  -- disable semantic tokens
  local method = "textDocument/semanticTokens"
  local supports = vim.fn.has "nvim-0.11" == 1 and client:supports_method(method) or client.supports_method(method)
  if supports then
    client.server_capabilities.semanticTokensProvider = nil
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
  local ok, err = pcall(function()
    dofile(vim.g.base46_cache .. "lsp")

    local nvchad_lsp_ok, nvchad_lsp = pcall(require, "nvchad.lsp")
    if nvchad_lsp_ok then
      nvchad_lsp.diagnostic_config()
    end

    -- ? LspAttach autocmd for keymaps
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        M.on_attach(nil, args.buf)
      end,
    })

    -- ? Global defaults applied to ALL servers
    vim.lsp.config("*", {
      capabilities = M.capabilities,
      on_init = M.on_init,
    })

    -- lua_ls
    vim.lsp.config("lua_ls", {
      settings = {
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
      },
    })
    vim.lsp.enable "lua_ls"

    -- ts_ls
    vim.lsp.config("ts_ls", {
      filetypes = { "javascript", "typescript", "typescriptreact", "typescript.tsx" },
      cmd = { "typescript-language-server", "--stdio" },
      root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
      init_options = {
        preferences = { disableSuggestions = true },
      },
    })
    vim.lsp.enable "ts_ls"

    -- tailwindcss
    vim.lsp.config("tailwindcss", {
      root_markers = {
        "tailwind.config.js",
        "tailwind.config.ts",
        "postcss.config.js",
        "package.json",
        ".git",
      },
    })
    vim.lsp.enable "tailwindcss"

    -- graphql
    vim.lsp.config("graphql", {
      filetypes = { "javascript", "typescript", "typescriptreact", "graphql" },
      root_markers = { ".graphqlconfig", ".graphqlrc", "package.json" },
    })
    vim.lsp.enable "graphql"

    -- typos_lsp
    vim.lsp.config("typos_lsp", {
      root_markers = { ".git" },
      cmd_env = { RUST_LOG = "error" },
      init_options = { diagnosticSeverity = "Error" },
    })
    vim.lsp.enable "typos_lsp"

    -- move-analyzer
    vim.lsp.config("move-analyzer", {
      cmd = { "move-analyzer" },
      filetypes = { "move" },
      root_markers = { "Move.toml", ".git" },
    })
    vim.lsp.enable "move-analyzer"
  end)

  if not ok then
    vim.notify("lspconfig error: " .. tostring(err), vim.log.levels.ERROR)
  end
end

return M
