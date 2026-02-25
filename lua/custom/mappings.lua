---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["QQ"] = { "<cmd> qa <CR>", "Quit nvim" },
    ["<C-z>"] = { ":undo <CR>", "Undo" },
    ["<leader>fm"] = {
      function()
        local conform = require "conform"
        local filetype = vim.bo.filetype
        if filetype == "move" then
          -- Save the file first
          vim.cmd "write"

          -- Get the file path
          local file = vim.fn.expand "%:p"

          -- Run prettier-move as a job
          vim.fn.jobstart({ "prettier-move", "-w", file }, {
            on_exit = function(_, exit_code)
              if exit_code == 0 then
                -- Reload the buffer if it was formatted successfully
                vim.cmd "checktime"
              else
                vim.notify("Prettier-move failed", vim.log.levels.ERROR)
              end
            end,
          })
        else
          -- For non-Move files, use conform formatter
          conform.format {
            lsp_fallback = true,
            async = false,
            timeout_ms = 1000,
          }
        end
      end,
      "Format file",
    },
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

M.gopher = {
  plugin = true,
  n = {
    ["<leader>gsj"] = {
      "<cmd> GoTagAdd json <CR>",
      "Add json struct tags",
    },
    ["<leader>gsy"] = {
      "<cmd> GoTagAdd yaml <CR>",
      "Add yaml struct tags",
    },
  },
}
M.opencode = {
  plugin = true,
  n = {
    ["<leader>og"] = {
      function()
        require("opencode").toggle()
      end,
      "Toggle OpenCode",
    },
    ["<leader>oi"] = {
      function()
        require("opencode").open_input()
      end,
      "Open Input",
    },
    ["<leader>oo"] = {
      function()
        require("opencode").open_output()
      end,
      "Open Output",
    },
    ["<leader>os"] = {
      function()
        require("opencode").select_session()
      end,
      "Select Session",
    },
    ["<leader>od"] = {
      function()
        require("opencode").diff_open()
      end,
      "Open Diff",
    },
    ["<leader>oc"] = {
      function()
        require("opencode").diff_close()
      end,
      "Close Diff",
    },
  },
  v = {
    ["<leader>oy"] = {
      function()
        require("opencode").add_visual_selection()
      end,
      "Add Selection to OpenCode",
    },
    ["<leader>o/"] = {
      function()
        require("opencode").quick_chat()
      end,
      "Quick Chat",
    },
  },
}

return M
