" plugin file save location
call plug#begin()
" move jk faster
Plug 'rhysd/accelerated-jk'
nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)
let g:accelerated_jk_acceleration_table = [2, 4, 6]
" highlight current word
Plug 'dominikduda/vim_current_word'
let g:vim_current_word#highlight_current_word = 0
call plug#end()

colorscheme sonokai
set number
endfunction
