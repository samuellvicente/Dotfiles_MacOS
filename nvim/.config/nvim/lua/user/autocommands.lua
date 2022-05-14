-- NVIM autocommands

vim.cmd [[
augroup _general_settings
  autocmd!

  " Open file where last closed
  autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

augroup end
]]

vim.cmd [[
augroup _save_folds
  autocmd!

    autocmd BufWinLeave *.tex mkview
    autocmd BufWinEnter *.tex silent loadview 

augroup end
]]

local latex = vim.api.nvim_create_augroup("_latex-settings", {
  clear = true
})

vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
  pattern = {"*.tex", "*.bib"},
  callback = function()
    vim.wo.colorcolumn = "";
    vim.api.nvim_command('set spell spelllang=en_us');
    vim.o.foldmethod = 'indent';
  end,
  group = latex,
})
