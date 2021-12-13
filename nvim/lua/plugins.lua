return require('packer').startup(function(use)
        -- Packer can manage itself
        use 'wbthomason/packer.nvim'
        -- treesitter
        use {
                'nvim-treesitter/nvim-treesitter',
                run = ':TSUpdate'
        }
        -- lspconfig
        use {'neovim/nvim-lspconfig', 'williamboman/nvim-lsp-installer'}
        -- nvim-cmp
        use 'hrsh7th/cmp-nvim-lsp'
        use 'hrsh7th/cmp-buffer'
        use 'hrsh7th/cmp-path'
        use 'hrsh7th/cmp-cmdline'
        use 'hrsh7th/nvim-cmp'
        -- vsnip
        use 'hrsh7th/cmp-vsnip'
        use 'hrsh7th/vim-vsnip'
        use "rafamadriz/friendly-snippets"
        -- lspkind
        use 'onsails/lspkind-nvim'
        -- auto pairs
        use 'jiangmiao/auto-pairs'
        -- save last leave place
        use 'farmergreg/vim-lastplace'
        -- Show the cursor position after jumping
        use 'danilamihailov/beacon.nvim'
        -- move curosr faster
        use 'rhysd/accelerated-jk'
        -- appereance
        use 'joshdick/onedark.vim'
        use 'vim-airline/vim-airline'
        use 'vim-airline/vim-airline-themes'
        -- render color in file
        use 'gko/vim-coloresque'
        -- fast comment
        use 'preservim/nerdcommenter'
        -- markdown preview
        use {
                'iamcco/markdown-preview.nvim',
                ft = 'markdown',
                run = 'cd app && yarn install'
        }
        -- fzf-like file search
        use {
                'Yggdroot/LeaderF',
                run = ':LeaderfInstallCExtension'
        }
        use {
                'kyazdani42/nvim-tree.lua',
                requires = {
                        'kyazdani42/nvim-web-devicons', -- optional, for file icon
                },
                config = function() require'nvim-tree'.setup {} end
        }
        -- bufferline
        use {'akinsho/bufferline.nvim',
                requires = 'kyazdani42/nvim-web-devicons'}
end)
