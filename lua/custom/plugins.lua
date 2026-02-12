local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },
  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },
  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },
  {
    "kdheepak/lazygit.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "akinsho/toggleterm.nvim",
    init = function()
      require("core.utils").load_mappings "Toggleterm"
    end,
    cmd = {
      "ToggleTerm",
      "ToggleTermSendCurrentLine",
      "ToggleTermSendVisualLines",
      "ToggleTermSendVisualSelection",
    },
    opts = require "custom.configs.toggleterm",
  },
  {
    "windwp/nvim-ts-autotag",
    ft = { "javascript", "javascriptreact", "typescript", "typescriptreact", "html" },
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "tact-lang/tact.vim",
    lazy = false,
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^5", -- Recommended
    ft = { "rust" },
    config = function()
      vim.g.rustaceanvim = {
        -- Plugin configuration
        tools = {
          hover_actions = {
            auto_focus = true,
          },
        },
        -- LSP configuration
        server = {
          on_attach = function(_, bufnr)
            -- you can also put your keymaps here
            local map = vim.keymap.set
            map("n", "<leader>ca", function()
              vim.cmd.RustLsp "codeAction"
            end, { buffer = bufnr, desc = "Code Action" })
            map("n", "<leader>rd", function()
              vim.cmd.RustLsp "debuggables"
            end, { buffer = bufnr, desc = "Rust Debuggables" })
            map("n", "<leader>rr", function()
              vim.cmd.RustLsp "runnables"
            end, { buffer = bufnr, desc = "Rust Runnables" })
            map("n", "<leader>rem", function()
              vim.cmd.RustLsp "expandMacro"
            end, { buffer = bufnr, desc = "Expand Macro" })
            map("n", "<leader>rk", function()
              vim.cmd.RustLsp "hover actions"
            end, { buffer = bufnr, desc = "Hover Actions" })
            map("n", "<leader>rep", function()
              vim.cmd.RustLsp("explainError", "current")
            end, { buffer = bufnr, desc = "Explain Error" })
            map("n", "<leader>red", function()
              vim.cmd.RustLsp("renderDiagnostic", "current")
            end, { buffer = bufnr, desc = "Render Diagnostic" })
          end,
        },
      }
    end,
  },
  -- Golang
  -- {
  --   "olexsmir/gopher.nvim",
  --   ft = "go",
  --   config = function(_, opts)
  --     require("gopher").setup(opts)
  --     require("core.utils").load_mappings "gopher"
  --   end,
  --   build = function()
  --     vim.cmd [[silent! GoInstallDeps]]
  --   end,
  -- },

  -- Move
  {
    "yanganto/move.vim",
    branch = "sui-move",
    lazy = false,
  },
  {
    "pteroctopus/faster.nvim",
  },
  {
    -- format
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require "custom.configs.format"
    end,
  },
  {
    -- lint
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require "custom.configs.lint"
    end,
  },
  -- Opencode
  -- Opencode
  {
    "nickjvandyke/opencode.nvim",
    dependencies = {
      { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
    },
    init = function()
      require("core.utils").load_mappings "opencode"
    end,
    config = function()
      vim.g.opencode_opts = {
        -- Your configuration here
      }
      vim.o.autoread = true
    end,
  },
  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },

  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  -- {
  --   "mg979/vim-visual-multi",
  --   lazy = false,
  -- }
}

return plugins
