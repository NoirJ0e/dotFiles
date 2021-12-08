call plug#begin()

" ===
" === Save cursor location on exit and jump to it when reopen
" ===

Plug 'farmergreg/vim-lastplace'

" ===
" === Float terminal inside vim
" ===

Plug 'voldikss/vim-floaterm'
let g:floaterm_keymap_new = '<C-f><C-f>'
let g:floaterm_keymap_toggle = '<Leader>t'
let g:floarterm_keymap_next = '<Leader>]'
let g:floarterm_keymap_prev = '<Leader>['
nmap <C-f><C-r> :FloatermNew ranger<CR>
"nmap <C-t> :FloatermToggle <CR>
"nmap <F12> :FloatermToggle <CR>
"nmap <S-p> :FloatermNew<CR>

" ===
" === Appearance
" ===

Plug 'joshdick/onedark.vim'
Plug 'sainnhe/gruvbox-material'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" ===
" === Fast Select objects 
" ===

Plug 'gcmt/wildfire.vim'

" ===
" === Enter '' and [] things way faster
" ===

Plug 'jiangmiao/auto-pairs'

" ===
" === Move the cursor faster
" ===

Plug 'rhysd/accelerated-jk'
nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)
let g:accelerated_jk_acceleration_table = [2, 4, 6]

" ===
" === File Exlpoer in vim
" ===
Plug 'preservim/nerdtree'
"nnoremap <leader>n :NERDTreeFocus<CR>
"nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
"nnoremap <C-f> :NERDTreeFind<CR>

" ===
" === Show the cursor position after jumping
" ===

 Plug 'danilamihailov/beacon.nvim'

" ===
" === Enter '' and [] things way faster
" ===

Plug 'jiangmiao/auto-pairs'

" ===
" === Coc auto completion (By LSP)
" ===

Plug 'neoclide/coc.nvim', {'branch': 'release'}

" === Coc Settings

set hidden
set updatetime=100
set shortmess+=c
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" trigger completion
"inoremap <silent><expr> <s-space> coc#refresh()

" find out 

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" rename
nmap <leader>rn <Plug>(coc-rename)

" === install all extensions when first start coc

let g:coc_global_extensions = ['coc-json', 'coc-vimlsp', 'coc-marketplace', 'coc-pyright']

" ===
" === Render colors in vim 
" ===

Plug 'gko/vim-coloresque'


" ===
" === Save the file automatic
" ===

Plug 'vim-scripts/vim-auto-save'
let g:auto_save_silent = 0
let g:auto_save = 1
let g:auto_save_in_insert_mode = 0


" ===
" === Hight the word under the cursor
" ===

Plug 'RRethy/vim-illuminate'
let g:Hexokinase_highlighters = ['virtual']
let g:Illuminate_delay = 0
hi illuminatedWord cterm=undercurl gui=undercurl

" ===
" === Fast file/content search
" ===

Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
let g:Lf_ShortcutF = '<c-p>'

"" ===
"" === Syntax Hightlight
"" ===
"
"Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update

call plug#end()

" ===
" === Other Settings
" ===

" === Make tab = 4 spaces
filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

" === Show line numbers
set nu
set rnu

" === Allow mouse function
set mouse=a

" === Set colorscheme
colorscheme onedark

" ===
" === Key maps
" ===

nmap <C-x> :q <CR>
nmap <C-s> :w <CR>
nmap <C-w><C-q> :wqa <CR>


" === Run Currently file directyl
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
