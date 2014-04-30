
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
if has("macunix")
	execute "set colorcolumn=" . join(range(81, 9999), ',')
elseif has("unix")
	execute "set colorcolumn=81"
endif

hi ColorColumn ctermbg=235
set incsearch
set hlsearch


"----------------------------------------------------
" backup
"----------------------------------------------------
set nobackup
set writebackup


"----------------------------------------------------
" encoding
"----------------------------------------------------
set encoding=utf-8
set fileencodings=ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932,utf-8


"----------------------------------------------------
" indent
"----------------------------------------------------
set autoindent
set smartindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set backspace=indent,eol,start



"----------------------------------------------------
" syntax
"----------------------------------------------------

" go
if $GOROOT != ''
	set rtp+=$GOROOT/misc/vim
endif



"----------------------------------------------------
" options
"----------------------------------------------------

"ヤンクでクリップボードにコピー
"set clipboard=unnamed,autoselect

"" pdfの開き方の指定
let pdfopener = "xdg-open"
if has("macunix")
    let pdfopener = "open"
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
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'kmnk/vim-unite-giti'
NeoBundle 'mhinz/vim-startify'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/neomru.vim'
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

NeoBundleLazy 'vim-jp/cpp-vim', {
            \ 'autoload' : {'filetypes' : 'cpp'}
            \ }

filetype plugin on
NeoBundleCheck



"----------------------------------------------------
" neocomplete
"----------------------------------------------------
let g:neocomplete#enable_at_startup = 1 
let g:neocomplete#enable_auto_select = 1



"----------------------------------------------------
" Neosnippet
"----------------------------------------------------

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif



"----------------------------------------------------
" lightline
"----------------------------------------------------
let g:lightline = {
      \ 'colorscheme': 'wombat',
	  \ 'separator': { 'left': '', 'right': '' },
	  \ 'subseparator': { 'left': '|', 'right': '|' }
      \ }



"----------------------------------------------------
" unite-outline
"----------------------------------------------------
command! -nargs=0 Outline call Outline()
function! Outline()
	:Unite -vertical -winwidth=30 outline -no-quit
endfunction



"----------------------------------------------------
" previm
"----------------------------------------------------

"" .md が module2 として認識されるので，markdownにしてやる
augroup PrevimSettings
    autocmd!
    autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
augroup END

"----------------------------------------------------
" manipulation of tab
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
" Renameme
"	rename the current file
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
\   'tex': {
\       'command': 'platex',
\       'exec': ['%c -synctex=1 -interaction=nonstopmode %s', 'dvipdfmx %s:r.dvi', pdfopener.' %s:r.pdf']
\   },
\   'plaintex': {
\       'command': 'platex',
\       'exec': ['%c -synctex=1 -interaction=nonstopmode %s', 'dvipdfmx %s:r.dvi', pdfopener.' %s:r.pdf']
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



"----------------------------------------------------
" Insert include guard to the current file
"----------------------------------------------------
command!  -nargs=0 IncGuard call IncludeGuard()
function! IncludeGuard()
	"カレントファイル名を取得
	let name = fnamemodify(expand('%'),':t')	

	"大文字にする
	let name = toupper(name)
	
	"がーど
	let included = substitute(name,'\.','_','g').'_INCLUDED__'

	"書き込み
	let res_head = '#ifndef '.included."\n#define ".included."\n\n"
	let res_foot = "\n".'#endif //'.included."\n"
	silent! execute '1s/^/\=res_head'
	silent! execute '$s/$/\=res_foot'
endfunction
