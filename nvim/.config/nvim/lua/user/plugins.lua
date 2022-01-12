-- NVIM plugin


-- Packages to be managed
local PKGS = {
  "savq/paq-nvim";

  -- LSP
  "neovim/nvim-lspconfig";
  --"williamboman/nvim-lsp-installer";


  -- Completion plugins
  "hrsh7th/nvim-cmp";
  "hrsh7th/cmp-nvim-lsp";
  "hrsh7th/cmp-buffer";
  "hrsh7th/cmp-path";
  "hrsh7th/cmp-cmdline";
  "onsails/lspkind-nvim";
  --"ukas-reineke/cmp-under-comparator";
  --"hrsh7th/cmp-nvim-lua";
  "saadparwaiz1/cmp_luasnip";
  "L3MON4D3/LuaSnip";


  -- Treesitter plugins
  { "nvim-treesitter/nvim-treesitter", run = function() cmd 'TSUpdate' end };
  "p00f/nvim-ts-rainbow";
  --"windwp/nvim-ts-autotag";


  -- Random stuff
  --"dstein64/vim-startuptime";
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
--paq.install()
