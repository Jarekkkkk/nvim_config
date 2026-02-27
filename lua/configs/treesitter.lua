pcall(function()
  dofile(vim.g.base46_cache .. "syntax")
  dofile(vim.g.base46_cache .. "treesitter")
end)

return {
  ensure_installed = {
    "vim",
    "lua",
    "luadoc",
    "printf",
    "vimdoc",
    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",
    "markdown",
    "markdown_inline",
    "solidity",
    "python",
  },
  indent = {
    enable = true,
    disable = {
      "python",
    },
  },
}
