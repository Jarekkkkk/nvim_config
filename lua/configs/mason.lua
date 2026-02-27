dofile(vim.g.base46_cache .. "mason")

return {
  PATH = "skip",

  ui = {
    icons = {
      package_pending = " ",
      package_installed = " ",
      package_uninstalled = " ",
    },
  },

  max_concurrent_installers = 10,

  ensure_installed = {
    "lua-language-server",
    "stylua",
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "prettier",
    "tailwindcss-language-server",
    "eslint-lsp",
    "solidity",
    "pyright",
    "rust-analyzer",
    "graphql-language-service-cli",
  },
}
