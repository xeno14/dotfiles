"----------------------------------------------------
" appearance
"----------------------------------------------------
syntax on
set laststatus=2
set t_Co=256
set ruler
set number
colorscheme desert
"change the color of columns past 80th
execute "set colorcolumn=" . join(range(81, 9999), ',')
hi ColorColumn ctermbg=235


"----------------------------------------------------
" backup
"----------------------------------------------------
set nobackup
set writebackup



"----------------------------------------------------
" indent
"----------------------------------------------------
set autoindent
set smartindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab
" enable backspace when insert mode
set backspace=indent,eol,start

"----------------------------------------------------
" syntax
"----------------------------------------------------
" go
if $GOROOT != ''
	set rtp+=$GOROOT/misc/vim
endif


"----------------------------------------------------
" autocmd
"----------------------------------------------------
if has("autocmd")
    " ファイルタイプ別インデント、プラグインを有効にする
    filetype plugin indent on
    " カーソル位置を記憶する
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif
endif



"----------------------------------------------------
" Neobundle
"----------------------------------------------------
let g:neobundle_default_git_protocol='https'
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#rc(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

"NeoBundle 'jcf/vim-latex'
NeoBundle 'heavenshell/vim-sudden-death'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'jceb/vim-hier'
NeoBundle 'kannokanno/previm'
NeoBundle 'kmnk/vim-unite-giti'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'Shougo/vimproc', {
  \ 'build' : {
    \ 'windows' : 'make -f make_mingw32.mak',
    \ 'cygwin' : 'make -f make_cygwin.mak',
    \ 'mac' : 'make -f make_mac.mak',
    \ 'unix' : 'make -f make_unix.mak',
  \ },
  \ }
NeoBundle 'Shougo/vimshell'
NeoBundle 'sudar/vim-arduino-syntax'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'tomtom/tcomment_vim'
"NeoBundle 'vim-scripts/errormarker.vim'

filetype plugin on
NeoBundleCheck



"----------------------------------------------------
" neocomplete
"----------------------------------------------------
let g:neocomplete#enable_at_startup = 1 
let g:neocomplete#enable_auto_select = 1



"----------------------------------------------------
" lightline
"----------------------------------------------------
let g:lightline = {
      \ 'colorscheme': 'wombat',
	  \ 'separator': { 'left': '', 'right': '' },
	  \ 'subseparator': { 'left': '|', 'right': '|' }
      \ }



"----------------------------------------------------
" previm
"----------------------------------------------------
let g:previm_open_cmd = 'open -a Firefox'



"----------------------------------------------------
" unite-outline
"----------------------------------------------------
command! -nargs=0 Outline call Outline()
function! Outline()
	:Unite -vertical -winwidth=30 outline -no-quit
endfunction





"----------------------------------------------------
" manipulation of tab
"
" http://qiita.com/wadako111/items/755e753677dd72d8036d
" TODO 地味に使いにくいしコマンドモードでなんかしたい
"----------------------------------------------------
" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 " 常にタブラインを表示

" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    t [Tag]
" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ

map <silent> [Tag]c :tablast <bar> tabnew<CR>
" tc 新しいタブを一番右に作る
map <silent> [Tag]x :tabclose<CR>
" tx タブを閉じる
map <silent> [Tag]n :tabnext<CR>
" tn 次のタブ
map <silent> [Tag]p :tabprevious<CR>
" tp 前のタブ



"----------------------------------------------------
" Renameme
"	rename the file you are opening
"
" usage
"	:Renameme('newname')
"----------------------------------------------------
command! -nargs=1 Renameme call Renameme(<args>)
function! Renameme(newname)
	call rename(expand('%'),a:newname)
	:execute ":e ".a:newname
endfunction!



"----------------------------------------------------
" CD
"	change current directory
"
" usage
"	:CD directory
"	if no argument, change to the directory file opened is in
"----------------------------------------------------
command! -nargs=? -complete=dir -bang CD  call s:ChangeCurrentDir('<args>', '<bang>') 
function! s:ChangeCurrentDir(directory, bang)
    if a:directory == ''
        lcd %:p:h
    else
        execute 'lcd' . a:directory
    endif

    if a:bang == ''
        pwd
    endif
endfunction
" Change current directory.
nnoremap <silent> <Space>cd :<C-u>CD<CR>



"----------------------------------------------------
" vimshell
"----------------------------------------------------
command! VS :VimShell
command! VSpy :VimShellInteractive python
command! VSss :VimShellSendString



"----------------------------------------------------
" quickrun
"----------------------------------------------------
let g:quickrun_config = {
\	'_' : {
\       'hook/close_quickfix/enable_success' : 1,
\       'hook/close_buffer/enable_empty_data' : 1,
\       'hook/time/enable' : 1,
\       'outputter' : 'multi:buffer:quickfix',
\       'runner' : 'vimproc',
\       'runner/vimproc/updatetime' : 60
\	},
\	'cpp': {
\		'type':
\			executable('g++')     ? 'cpp/g++' :
\			executable('clang++') ? 'cpp/clang++'  : ' ',
\	},
\   'cpp/g++' : {
\       'cmdopt' : '-std=c++0x',
\   },
\}



"----------------------------------------------------
" errormarker.vim
"----------------------------------------------------
" let g:errormarker_errortext		= '!!'
" let g:errormarker_errorgroup	= 'ERROR'
" let g:errormarker_warningtext	= '??'
" let g:errormarker_warninggroup	= 'Todo'



"----------------------------------------------------
" Unite
"----------------------------------------------------
let g:unite_source_session_enable_auto_save = 1
let g:unite_source_history_yank_enable = 1
let g:unite_source_file_mru_limit = 100000

nnoremap <C-@> :Unite -direction=botright window buffer file file_mru<CR>
inoremap <C-@> <ESC>:Unite -direction=botright window buffer file file_mru<CR>
