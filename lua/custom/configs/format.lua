local conform = require "conform"

conform.setup {
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "black" },
    javascript = { "prettierd" },
    typescript = { "prettierd" },
    javascriptreact = { "prettierd" },
    typescriptreact = { "prettierd" },
    json = { "prettierd" },
    graphql = { "prettierd" },
    html = { "htmlbeautifier" },
    bash = { "beautysh" },
    rust = { "rustfmt" },
    yaml = { "yamlfix" },
    toml = { "taplo" },
    css = { "prettierd" },
    scss = { "prettierd" },
    sh = { "shellcheck" },
  },
}
