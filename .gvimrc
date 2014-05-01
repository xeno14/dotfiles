"----------------------------------------------------
" appearance
"----------------------------------------------------
colorscheme desert
set columns=80
set lines=60

" 画面の透過
if has("macunix")
	autocmd GUIEnter * set transparency=17
endif
hi ColorColumn guibg=#606060



"----------------------------------------------------
" Fullscreen
"
"	expand this window to screen size
"----------------------------------------------------
command! FullScreen call FullScreen()
function! FullScreen()
	:set columns=9999
	:set lines=9999
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
