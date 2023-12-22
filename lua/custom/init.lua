-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- }


--  change the working directory to match the file
vim.api.nvim_exec([[
  augroup AutoCd
    autocmd!
    autocmd BufEnter * silent! lcd %:p:h
  augroup END
]], false)
