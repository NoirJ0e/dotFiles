" === Basic settings
lua require'basic'
" === Plugins
lua require'plugins'
" === Keybinds
lua require'keybinds'

" === Different settings for individual plugins
lua require('plugins-config.nvim-tree')
lua require('plugins-config.lualine')
lua require('plugins-config.autopairs')
lua require('plugins-config.treesitter')

" === LSP
lua require('lsp.setup')
lua require('lsp/nvim-cmp')

colorscheme onedarker
