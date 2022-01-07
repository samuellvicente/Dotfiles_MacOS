-- NVIM autocommands

vim.cmd [[
augroup _general_settings
  autocmd!

  " Open file where last closed
  autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

augroup end
]]
