require("opencode").setup {
  preferred_picker = "telescope",
  preferred_completion = "nvim-cmp",
  default_global_keymaps = true,
  default_mode = "build",
  keymap_prefix = "<leader>o",
  ui = {
    position = "right",
    input_position = "bottom",
    window_width = 0.40,
    display_model = true,
    display_context_size = true,
    display_cost = true,
    icons = {
      preset = "nerdfonts",
    },
  },
  keymap = {
    input_window = {
      ["<esc>"] = false,
      ["<C-a>"] = { "switch_mode" },
    },
    output_window = {
      ["<esc>"] = false,
    },
  },
}
