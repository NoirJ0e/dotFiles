let g:autopep8_disable_show_diff=1
let g:autopep8_on_save = 1
"colorscheme
"
"colorscheme kanagawa
filetype on
colorscheme nord
set termguicolors
set guifont=JetBrainsMono\ Nerd\ Font:h16
" set clipboard+=unnamedplus
" 支持在 Visual 模式下，通过 C-y 复制到系统剪切板
" vnoremap <C-y> "+y
" " 支持在 normal 模式下，通过 C-p 粘贴系统剪切板
" nnoremap <C-p> "*p



" === Basic settings
lua require'core.basic'
" === Plugins
lua require'core.plugins'
" === Keybinds
lua require'core.keybinds'

" === Different settings for individual plugins
lua require('plugins.nvim-tree')
lua require('plugins.lualine')
lua require('plugins.autopairs')
lua require('plugins.treesitter')
lua require('nvim-lastplace').setup{}
lua require('telescope').load_extension('fzf')
lua require('neoscroll').setup()
lua require('nvim_comment').setup({operator_mapping = "<leader>c"})
lua require('nvim-autopairs').setup{}
lua require('colorizer').setup()
lua require('gitsigns').setup()
lua require('spellsitter').setup()


" === LSP
lua require('lsp.setup')
lua require('lsp.nvim-cmp')



" === Some key i dont know to translate into lua
nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)
let g:accelerated_jk_accleration_table = [2,4,6,8]

" === Run Currently file directyl
map <S-r> :call CompileRunGcc()<CR>
func! CompileRunGcc()
        exec 'w'
        if &filetype =='c'
                exec "!gcc % -o %<"
                exec "!time ./%<"
        elseif &filetype == 'cpp'
                exec "!g++ % -o %<"
                exec "!time ./%<"
        elseif &filetype == 'java'
                exec "!javac %"
                exec "!time java %<"
        elseif &filetype == 'sh'
                :!time sh %
        elseif &filetype == 'python'
                exec ":call BlackSync()"
                exec "!time python3 %"
        elseif &filetype == 'html'
                exec "!firefox % &"
        elseif &filetype == 'go'
                exec "!time go run %"
        elseif &filetype == 'javascript'
                exec "!node %"
        endif
endfunction

" === format file
augroup formater
        au!
        au FileType python call BlackSync()
augroup END
