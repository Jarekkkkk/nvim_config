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
    ["<leader>oa"] = {
      function()
        require("opencode").ask("@this: ", { submit = true })
      end,
      "Opencode Ask",
    },
    ["<leader>ox"] = {
      function()
        require("opencode").select()
      end,
      "Opencode Select Actions",
    },
    ["<leader>oo"] = {
      function()
        require("opencode").toggle()
      end,
      "Opencode Toggle",
    },
    ["<leader>oc"] = {
      function()
        require("opencode").command()
      end,
      "Opencode Command Palette",
    },
    ["<leader>ou"] = {
      function()
        require("opencode").command "session.half.page.up"
      end,
      "Opencode Scroll Up",
    },
    ["<leader>od"] = {
      function()
        require("opencode").command "session.half.page.down"
      end,
      "Opencode Scroll Down",
    },

    -- Expr mappings for operators
    ["<leader>or"] = {
      function()
        return require("opencode").operator "@this "
      end,
      "Opencode Add Range",
      opts = { expr = true },
    },
    ["<leader>oll"] = {
      function()
        return require("opencode").operator "@this " .. "_"
      end,
      "Opencode Add Line",
      opts = { expr = true },
    },
  },
  x = {
    ["<leader>oa"] = {
      function()
        require("opencode").ask("@this: ", { submit = true })
      end,
      "Opencode Ask Selection",
    },
    ["<leader>or"] = {
      function()
        return require("opencode").operator "@this "
      end,
      "Opencode Add Range",
      opts = { expr = true },
    },
  },
}
return M
