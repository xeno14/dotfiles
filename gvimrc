colorscheme slate

set columns=100
set lines=55

"透過度の設定
autocmd GUIEnter * set transparency=17


"画面サイズより大きくしてフルスクリーンに
command! FullScreen call FullScreen()
function! FullScreen()
	:set columns=1000
	:set lines=100
endfunction


"----------------------------------------------------
" vim-hier
"----------------------------------------------------
" エラーを赤字の波線で
execute "highlight qf_error_ucurl gui=undercurl guisp=Red"
let g:hier_highlight_group_qf  = "qf_error_ucurl"
" 警告を黄色の波線で
execute "highlight qf_warning_ucurl gui=undercurl guisp=Yellow"
let g:hier_highlight_group_qfw = "qf_warning_ucurl"
