"----------------------------------------------------
" dein
"----------------------------------------------------

"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath^=.config/nvim/dein/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin(expand('.config/nvim/dein'))

" Let dein manage dein
" Required:
call dein#add('Shougo/dein.vim')

" Add or remove your plugins here:

let s:toml      = expand('.config/nvim/dein') . '/dein.toml'
let s:lazy_toml = expand('.config/nvim/dein') . '/dein_lazy.toml'

call dein#load_toml(s:toml,      {'lazy': 0})
call dein#load_toml(s:lazy_toml, {'lazy': 1})

" Required:
call dein#end()

" Required:
filetype plugin indent on

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------



"----------------------------------------------------
" setting
"----------------------------------------------------
" appearance
syntax on
set laststatus=2
set ruler
set number
set incsearch
set hlsearch
colorscheme desert

" backup
set nobackup
set writebackup

" encoding
set encoding=utf-8
set fileencodings=utf-8,ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932

" indent
set autoindent
set smartindent
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set backspace=indent,eol,start

set history=500

nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up>   gk
nnoremap $ g$
nnoremap 0 g0
let mapleader = "\<Space>"



"----------------------------------------------------
" tab
"----------------------------------------------------
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

set showtabline=2

" The prefix key.
nnoremap    [Tag]   <Nop>
nmap      t [Tag]
" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor

" create tab at right most
map <silent> [Tag]c :tablast <bar> tabnew<CR>
" close tab
map <silent> [Tag]x :tabclose<CR>
" tab next
map <silent> [Tag]n :tabnext<CR>
" tab previoust
map <silent> [Tag]p :tabprevious<CR>



"----------------------------------------------------
" include local setting 
"----------------------------------------------------
if filereadable(expand('.config/nvim/init.vim.local'))
  source ~/.config/nvim/init.vim.local
endif
