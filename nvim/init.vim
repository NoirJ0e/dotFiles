" === basic settings
lua require('basic')
" === use packer to manage plug
lua require('plugins')
" === Keybinds
lua require('keybindings')
"=== 插件配置
lua require('plugin-config/nvim-tree')
lua require('plugin-config/nvim-treesitter')
lua require('plugin-config/bufferline')
"lua require('')
" === LSP
lua require('lsp/setup')
lua require('lsp/ui')
lua require('lsp/nvim-cmp')

colorscheme onedark
set guifont=JetbrainsMono\ NF:h16
" === Keybinds=
nnoremap <leader>r :NvimTreeToggle<CR>
let g:NERDSpaceDelims=1
let g:Lf_ShortcutF = '<c-p>'
nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)
let g:accelerated_jk_acceleration_table = [2,4,6]
vnoremap <C-y> "+y
nnoremap <C-p< "*p


" === Run Currently file directly
map <S-r> :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec 'w'
	if &filetype =='c'
		exec "!g++ % -o %<"
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
		exec "!time python3 %"
	elseif &filetype == 'html'
		exec "!firefox % &"
	elseif &filetype == 'go'
		exec "!time go run %"
    elseif &filetype == 'javascript'
        exec "!node %"
	endif
endfunction
