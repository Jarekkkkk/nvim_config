local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
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
  -- {
  --   "simrat39/rust-tools.nvim",
  --   lazy = false,
  --   ft = "rust",
  --   dependencies = "neovim/nvim-lspconfig",
  --   opts = function()
  --     return require "custom.configs.rust-tools"
  --   end,
  --   config = function(_, opts)
  --     require("rust-tools").setup(opts)
  --   end,
  -- },
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
    "rvmelkonian/move.vim",
    lazy = false,
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
