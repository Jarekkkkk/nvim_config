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

return M
