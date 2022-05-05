-- NVIM autocommands

vim.cmd [[
augroup _general_settings
  autocmd!

  " Open file where last closed
  autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

augroup end
]]

local latex = vim.api.nvim_create_augroup("_latex-settings", {
  clear = true
})

vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
  pattern = {"*.tex", "*.bib"},
  callback = function()
    vim.wo.colorcolumn = ""
  end,
  group = latex,
})
