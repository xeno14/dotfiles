"----------------------------------------------------
" 色分け
"----------------------------------------------------
syntax on
set laststatus=2
set t_Co=256

"----------------------------------------------------
" バックアップ関係
"----------------------------------------------------
" バックアップをとらない
set nobackup
" ファイルの上書きの前にバックアップを作る
" (ただし、backup がオンでない限り、バックアップは上書きに成功した後削除される)
set writebackup

"----------------------------------------------------
" 表示関係
"----------------------------------------------------
set ruler
set number

"----------------------------------------------------
" インデント
"----------------------------------------------------
set autoindent
set smartindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab

"----------------------------------------------------
" syntax
"----------------------------------------------------
"go
if $GOROOT != ''
	set rtp+=$GOROOT/misc/vim
endif


"----------------------------------------------------
" オートコマンド
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
" プラグイン
"----------------------------------------------------
"neocomplete
let g:neocomplete#enable_at_startup = 1 
let g:neocomplete#enable_auto_select = 1

"""" lightline
let g:lightline = {
      \ 'colorscheme': 'wombat',
	  \ 'separator': { 'left': '', 'right': '' },
	  \ 'subseparator': { 'left': '|', 'right': '|' }
      \ }

"""" previm
let g:previm_open_cmd = 'open -a Firefox'

"""" NeoBundle
let g:neobundle_default_git_protocol='https'
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#rc(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
"repositories
"NeoBundle 'jcf/vim-latex'
NeoBundle 'sudar/vim-arduino-syntax'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'kannokanno/previm'
NeoBundle 'Shougo/neocomplete.vim'

filetype plugin on
NeoBundleCheck


"----------------------------------------------------
" タブ
"
" http://qiita.com/wadako111/items/755e753677dd72d8036d
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
" 自分をリネームする
"
" usage:
" :Renameme('newname')
"----------------------------------------------------
command! -nargs=1 Renameme call Renameme(<args>)
function! Renameme(newname)
	call rename(expand('%'),a:newname)
	:execute ":e ".a:newname
endfunction!
