---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["QQ"] = { "<cmd> qa <CR>", "Quit nvim" },
    ["<C-z>"] = { ":undo <CR>", "Undo" },
  },
  i = { ["<C-z>"] = { "<C-o>u", "Undo" } },
  v = {
    [">"] = { ">gv", "indent" },
  },
}

-- more keybinds!
M.Toggleterm = {
  plugin = true,
  n = {
    ["<leader>f"] = { "<cmd>ToggleTerm direction=float<cr>", "Float Terminal", opts = { silent = true } },

    ["<leader>h"] = {
      "<cmd>ToggleTerm direction=horizontal<cr>",
      "Horizontal Terminal",
      opts = { silent = true },
    },
    ["<leader>v"] = { "<cmd>ToggleTerm direction=vertical<cr>", "Vertical Terminal", opts = { silent = true } },
  },
}
return M
