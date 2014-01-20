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
