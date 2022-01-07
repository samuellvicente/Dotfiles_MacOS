-- NVIM plugin


-- Packages to be managed
local PKGS = {
  "savq/paq-nvim";
  --"neovim/nvim-lspconfig";
}

-- Automatically install paq
local install_path = vim.fn.stdpath('data') .. '/site/pack/paqs/start/paq-nvim'
if vim.fn.empty(vim.fn.glob(path)) > 0 then
  vim.fn.system {
    'git',
    'clone',
    '--depth=1',
    'https://github.com/savq/paq-nvim.git',
    install_path
  }
  vim.cmd('packadd paq-nvim')
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup paq_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PaqSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, paq = pcall(require, "paq")
if not status_ok then
  return
end

-- Read and install packages
paq(PKGS)
paq.install()
