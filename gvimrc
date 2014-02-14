"----------------------------------------------------
" appearance
"----------------------------------------------------
colorscheme desert
set columns=100
set lines=55
autocmd GUIEnter * set transparency=17
hi ColorColumn guibg=#606060



"----------------------------------------------------
" Fullscreen
"
"	expand this window to screen size
"----------------------------------------------------
command! FullScreen call FullScreen()
function! FullScreen()
	:set columns=1000
	:set lines=100
endfunction



"----------------------------------------------------
" vim-hier
"----------------------------------------------------
" error with a red wave line
execute "highlight qf_error_ucurl gui=undercurl guisp=Red"
let g:hier_highlight_group_qf  = "qf_error_ucurl"
" warning with a red wave line
execute "highlight qf_warning_ucurl gui=undercurl guisp=Yellow"
let g:hier_highlight_group_qfw = "qf_warning_ucurl"
