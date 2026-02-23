local opencode = require "opencode"

vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    pcall(function()
      local provider = require("opencode.config").provider
      if provider and provider.stop then
        provider:stop()
      end
    end)
  end,
})
