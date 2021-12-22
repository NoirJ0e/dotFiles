-- This file can be loaded by calling `lua require('useins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  -- Syntax Highlighting
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
}
  -- LSP
  use{
    'neovim/nvim-lspconfig',
    'williamboman/nvim-lsp-installer',
  }
  -- Implementation
  use{
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-vsnip',
    'hrsh7th/vim-vsnip',
    'rafamadriz/friendly-snippets',
    'onsails/lspkind-nvim',
    }
  -- Beauty
  use{
    'glepnir/zephyr-nvim',
    'LunarVim/onedarker.nvim'
  }
  -- File explorer
  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons'
    }
  -- status line
  use{
    'romgrk/barbar.nvim',
    requires = {'kyazdani42/nvim-web-devicons'},
    'nvim-lualine/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }
  -- Autopair
  use 'windwp/nvim-autopairs'
end)