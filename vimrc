"色分け
syntax on


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
" ルーラーを表示
set ruler
set number

"----------------------------------------------------
" インデント
"----------------------------------------------------
" オートインデントを有効にする
set autoindent
set smartindent
" タブが対応する空白の数
set tabstop=4
" タブやバックスペースの使用等の編集操作をするときに、タブが対応する空白の数
set softtabstop=4
" インデントの各段階に使われる空白の数
set shiftwidth=4
" タブを挿入するとき、代わりに空白を使わない
set noexpandtab

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
" plugin
"----------------------------------------------------
"""" for acp
" かなモードのときはpopupを無効にする
noremap <C-S-j> :AcpDisable
noremap <C-S-;> :AcpEnable


"""" lightline
let g:lightline = {
      \ 'colorscheme': 'wombat',
	  \ 'separator': { 'left': '', 'right': '' },
	  \ 'subseparator': { 'left': '|', 'right': '|' }
      \ }


"""" NeoBundle
let g:neobundle_default_git_protocol='https'
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#rc(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
"repositories
NeoBundle 'jcf/vim-latex'

filetype plugin on
NeoBundleCheck
