"----------------------------------------------------
" include
"----------------------------------------------------

if filereadable(expand('~/.gvimrc.local'))
  source ~/.gvimrc.local
endif

"----------------------------------------------------
" appearance
"----------------------------------------------------
syntax enable
set background=dark
colorscheme solarized

set columns=80
set lines=60

" 画面の透過
if has("macunix")
	autocmd GUIEnter * set transparency=2
endif
"hi ColorColumn guibg=#606060

" font
set guifont=Source\ Code\ Pro\ for\ Powerline\ Semibold\ 10


"----------------------------------------------------
" Fullscreen
"
"	expand this window to screen size
"----------------------------------------------------
function! FullScreen()
	:set columns=9999
	:set lines=9999
endfunction
command! FullScreen call FullScreen()



"----------------------------------------------------
" vim-hier
"----------------------------------------------------
" " error with a red wave line
" execute "highlight qf_error_ucurl gui=undercurl guisp=Red"
" let g:hier_highlight_group_qf  = "qf_error_ucurl"
" " warning with a red wave line
" execute "highlight qf_warning_ucurl gui=undercurl guisp=Yellow"
" let g:hier_highlight_group_qfw = "qf_warning_ucurl"
