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
        -- colorscheme
        use{
                'glepnir/zephyr-nvim',
                'LunarVim/onedarker.nvim',
                'shaunsingh/nord.nvim',
                'navarasu/onedark.nvim',
                "rebelot/kanagawa.nvim"
        }
        -- File explorer
        use {
                'kyazdani42/nvim-tree.lua',
                requires = 'kyazdani42/nvim-web-devicons'
        }
        -- File searcher
        use {
                'nvim-telescope/telescope.nvim',
                requires = { {'nvim-lua/plenary.nvim'}},
        }
        use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
        -- status line
        use{
                'romgrk/barbar.nvim',
                requires = {'kyazdani42/nvim-web-devicons'},
                'nvim-lualine/lualine.nvim',
                requires = {'kyazdani42/nvim-web-devicons', opt = true}
        }
        -- utils
        use{
                'windwp/nvim-autopairs',
                'rhysd/accelerated-jk',
                'ethanholz/nvim-lastplace',
                'terrortylor/nvim-comment',
                'voldikss/vim-floaterm',
                'karb94/neoscroll.nvim',
                'lukas-reineke/indent-blankline.nvim',
                'norcalli/nvim-colorizer.lua',
                -- 'glepnir/dashboard-nvim'
        }
        -- git
        use {
                'lewis6991/gitsigns.nvim',
                requires = {
                        'nvim-lua/plenary.nvim'
                },
        }
        -- Markdown
        use {
        'iamcco/markdown-preview.nvim',
        run = function() vim.fn['mkdp#util#install']() end,
        ft = {'markdown'}
        }
        -- -- which-key
        -- use {
        --         "folke/which-key.nvim",
        --         -- config = function()
        --         --         require("which-key").setup {
        --         --                 -- your configuration comes here
        --         --                 -- or leave it empty to use the default settings
        --         --                 -- refer to the configuration section below
        --         --         }
        --         -- end
        -- }

end)
