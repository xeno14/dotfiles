"----------------------------------------------------
" include
"----------------------------------------------------

if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif



"----------------------------------------------------
" appearance
"----------------------------------------------------

syntax on
set laststatus=2
set t_Co=256
set ruler
set number

"change the color of columns past 80th
set textwidth=0
if exists('&colorcolumn')
    set colorcolumn=+1
    autocmd FileType sh,c,cpp,markdown,perl,vim,ruby,python,haskell,scheme setlocal textwidth=80
endif
autocmd BufRead *.md set textwidth=0

set incsearch
set hlsearch

" color
colorscheme desert
highlight QFError ctermbg=88
highlight ColorColumn ctermbg=235 guibg=gray18


"----------------------------------------------------
" backup
"----------------------------------------------------

set nobackup
set writebackup



"----------------------------------------------------
" encoding
"----------------------------------------------------

set encoding=utf-8
set fileencodings=utf-8,ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932



"----------------------------------------------------
" indent
"----------------------------------------------------

set autoindent
set smartindent
set tabstop=2
set softtabstop=2
set shiftwidth=2
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

"" pdfの開き方の指定
"" quickrun 参照
let pdfopener = "xdg-open"
if has("macunix")
    let pdfopener = "open"
endif

"" texのconcealを無効化（#^ω^）
let g:tex_conceal=''

set conceallevel=0

"" clipboardを有効

if has("macunix")
  set clipboard=unnamed
else
  set clipboard=unnamedplus
endif

"" コマンド履歴の個数
set history=500

source $VIMRUNTIME/macros/matchit.vim

"" ビープの設定
set visualbell t_vb=""
set noerrorbells

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
" map
"----------------------------------------------------

nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up>   gk
nnoremap $ g$
nnoremap 0 g0



"----------------------------------------------------
" Configuration for C++
"----------------------------------------------------

function! s:cpp()
    " インクルードパスを設定する
    " gf などでヘッダーファイルを開きたい場合に影響する
    if has("macunix")
      setlocal path+=/usr/local/include/c++/4.8.0,/usr/local/include/boost
    " else
      " TODO path for linux 
      " setlocal path+=/usr
    endif

    " 括弧を構成する設定に <> を追加する
    " template<> を多用するのであれば
    setlocal matchpairs+=<:>

    " BOOST_PP_XXX 等のハイライトを行う
    syntax match boost_pp /BOOST_PP_[A-z0-9_]*/
    highlight link boost_pp cppStatement
endfunction

augroup vimrc-cpp
    autocmd!
    " filetype=cpp が設定された場合に関数を呼ぶ
    autocmd FileType cpp call s:cpp()
augroup END

"----------------------------------------------------
" NeoBundle
"----------------------------------------------------

"" .vim/bundle以下にプラグインのディレクトリがあるかどうか
function! NeobundleExists(plugin)
  return isdirectory(expand('~/.vim/bundle/'.a:plugin))
endfunction

if NeobundleExists('neobundle.vim')
  let g:neobundle_default_git_protocol='https'
  if has('vim_starting')
   if &compatible
     set nocompatible               " Be iMproved
   endif
   set runtimepath+=~/.vim/bundle/neobundle.vim/
  endif
  call neobundle#begin(expand('~/.vim/bundle/'))

  NeoBundleFetch 'Shougo/neobundle.vim'
 
  NeoBundle 'cohama/vim-hier'
  NeoBundle 'itchyny/lightline.vim'
  NeoBundle 'itchyny/vim-cursorword'
  NeoBundle 'haya14busa/incsearch.vim'
  NeoBundle 'kmnk/vim-unite-giti'
  NeoBundle 'kakkyz81/evervim'
  NeoBundle 'LeafCage/yankround.vim'
  NeoBundle 'Lokaltog/vim-easymotion'
  NeoBundle 'mfumi/ref-dicts-en'
  NeoBundle 'mhinz/vim-signify'
  NeoBundle 'Shougo/neocomplete.vim'
  NeoBundle 'Shougo/neocomplcache.vim'
  NeoBundle 'Shougo/neosnippet'
  NeoBundle 'Shougo/neosnippet-snippets'
  NeoBundle 'Shougo/neomru.vim'
  NeoBundle 'Shougo/unite.vim'
  NeoBundle 'Shougo/unite-outline'
  NeoBundle 'Shougo/unite-build'
  NeoBundle 'Shougo/vimproc', {
        \ 'build' : {
        \ 'windows' : 'make -f make_mingw32.mak',
        \ 'cygwin' : 'make -f make_cygwin.mak',
        \ 'mac' : 'make -f make_mac.mak',
        \ 'unix' : 'make -f make_unix.mak',
        \ },
        \ }
  NeoBundle 'sudar/vim-arduino-syntax'
  NeoBundle 'sudo.vim'
  NeoBundle 'termoshtt/unite-bibtex'
  NeoBundle 'termoshtt/unite-doxygen'
  NeoBundle 'thinca/vim-quickrun'
  NeoBundle 'thinca/vim-ref'
  NeoBundle 'thinca/vim-splash'
  NeoBundle 'thinca/vim-template'
  NeoBundle 'tomtom/tcomment_vim'
  NeoBundle 'tpope/vim-fugitive'
  NeoBundle 'tyru/open-browser.vim'
  NeoBundle 'tyru/vim-altercmd' 
  NeoBundle 'tsukkee/unite-tag'
  NeoBundle 'rhysd/vim-clang-format'
  " NeoBundle 'osyo-manga/vim-marching'
  NeoBundle 'osyo-manga/shabadou.vim'
  NeoBundle 'osyo-manga/vim-over'
  NeoBundle 'osyo-manga/vim-watchdogs'
  NeoBundle 'rhysd/wandbox-vim'
  NeoBundle 'rhysd/conflict-marker.vim'
  NeoBundle 'vcscommand.vim'
  NeoBundle 'violetyk/scratch-utility'
  NeoBundle 'xeno1991/previm'
  NeoBundle 'xeno1991/unite-template'
  NeoBundle 'xeno1991/easy-constructor.vim'

  NeoBundleLazy "nvie/vim-flake8", {
        \ "autoload": {
        \   "filetypes": ["python", "python3", "djangohtml"]
        \ }}
  NeoBundleLazy 'vim-jp/cpp-vim', {
              \ 'autoload' : {'filetypes' : 'cpp'}
              \ }
  NeoBundleLazy 'hynek/vim-python-pep8-indent', {
    \ "autoload": {"insert": 1, "filetypes": ["python", "python3", "djangohtml"]}}

  call neobundle#end()

  filetype plugin indent on
  NeoBundleCheck
endif



"----------------------------------------------------
" neocomplete
"----------------------------------------------------

let g:neocomplete#enable_at_startup = 1 
let g:neocomplete#enable_auto_select = 1


"----------------------------------------------------
" Neosnippet
"----------------------------------------------------

if NeobundleExists('neosnippet')
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
    set conceallevel=0 concealcursor=i
  endif

  let g:neosnippet#snippets_directory = expand('~/.vim/snippet/')
endif



"----------------------------------------------------
" lightline
"----------------------------------------------------

"" Unicodes depends on powerline patched fonts
"" see https://github.com/Lokaltog/powerline-fonts

"" statusline
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode' ], [ 'vcsinfo', 'readonly', 'filename' ] ],
		  \   'right': [ [ 'lineinfo' ],
		  \              [ 'percent' ],
		  \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&readonly?"\ue0a2":""}'
      \ },
      \ 'component_function': {
      \   'vcsinfo': 'LightlineVCSinfo',
      \   'filename' : 'LightlineFile',
      \   'modified' : 'LightlineModified',
      \   'cwd' : 'LightlineCwd'
      \ },
      \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
      \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
      \ }

"" tabline
let g:lightline.tabline = { 'right' : [ ['cwd'] ] }
let g:lightline.tab_component_function = {
      \ 'cwd': 'LightlineCwd'
\}

"" VCSの表示
function! LightlineVCSinfo()
  "TODO svnやhgなどの対応
  try
    "git
    if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
      let head=fugitive#head()
      return  ''!=head ? "\ue0a0 ".head : ''
    endif
  catch
  endtry
  return ''
endfunction

"" ファイル名の表示
function! LightlineFile()
  let filename=expand('%:t')
  if '' == filename
    return '[No Name]'
  else
    return filename . ' ' . LightlineModified()
endfunction

"" modifyの表示
function! LightlineModified()
  return (&filetype=="help" ? "" : &modified ? "+" : &modifiable ? "" : "-")
endfunction

"" カレントディレクトリ
function! LightlineCwd()
  let cwd=getcwd()
  if winwidth(0)/2 > strlen(cwd)
    return cwd
  else
    "" 画面の幅が小さい時には途中のディレクトリ名を頭文字だけで省略する
    let splited = split(cwd, "/")
    let res = ""
    for str in splited
      let res = res."/".str[0]
    endfor
    return res.splited[-1][1:]
  endif
endfunction



"----------------------------------------------------
" unite-outline
"----------------------------------------------------

command! -nargs=0 Outline call Outline()
function! Outline()
	:Unite -vertical -winwidth=30 outline
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

function! Renameme(newname)
	call rename(expand('%'),a:newname)
	:execute ":e ".a:newname
endfunction!
command! -nargs=1 -complete=file Renameme call Renameme('<args>')



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
" quickrun
"----------------------------------------------------

let g:cxx = has("macunix") ? "/usr/local/bin/g++-5" : "g++"

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
\       'command' : cxx,
\       'cmdopt' : '-std=c++14',
\   },
\   'cuda': {
\       'command': 'nvcc',
\       'exec': ['%c %s', './a.out']
\   },
\   'tex': {
\       'command': 'platex',
\       'exec': ['%c -interaction=nonstopmode %s', 'dvipdfmx %s:r.dvi']
\   },
\   'plaintex': {
\       'command': 'platex',
\       'exec': ['%c -interaction=nonstopmode %s', 'dvipdfmx %s:r.dvi']
\   },
\   "cpp/watchdogs_checker" : {
\       "type" : "watchdogs_checker/g++",
\   },
\   "watchdogs_checker/g++" : {
\       "cmdopt" : "-Wall",
\   },
\   "watchdogs_checker/clang++" : {
\       "cmdopt" : "-Wall",
\   },
\}



"----------------------------------------------------
" Unite
"----------------------------------------------------

let g:unite_source_session_enable_auto_save = 1
let g:unite_source_history_yank_enable = 1
let g:unite_source_file_mru_limit = 1000
let g:unite_enable_start_insert = 1

nnoremap <C-\> :Unite -direction=botright window buffer file file_mru<CR>
inoremap <C-\> <ESC>:Unite -direction=botright window buffer file file_mru<CR>
nnoremap <C-g> :Unite grep -auto-preview -auto-resize<CR><CR>

"" grep をagでする
"" http://blog.monochromegane.com/blog/2013/09/18/ag-and-unite/
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
endif

function! s:unite_my_settings()
  imap <buffer> <ESC><ESC><ESC> <Plug>(unite_exit)
  nmap <buffer> <ESC><ESC><ESC> <Plug>(unite_exit)
  nnoremap <silent><buffer><expr> v unite#do_action('vsplit')
  nnoremap <silent><buffer><expr> s unite#do_action('split')
endfunction
augroup UniteMySettings
  autocmd FileType unite call s:unite_my_settings()
augroup END

command! -nargs=0 Build call UniteBuild()
function! UniteBuild()
  :Unite build -buffer-name=BUILD -auto-resize -auto-preview -no-quit
endfunction



"----------------------------------------------------
" Splash
"----------------------------------------------------

"" 画面の大きさによって分ける
if &columns > 200
    let g:splash#path = expand('~/.vim/splash/azusa_large.txt')
else
    let g:splash#path = expand('~/.vim/splash/azusa_small.txt')
endif



"----------------------------------------------------
" Temp
"	open temporary file with a syntax
"
" usage
"	:Temp filetype
"
" param
"    filetype : file type (completion by syntax)
"
" example
"   :Temp cpp
"   :Temp tex
"----------------------------------------------------

function! Temp (file_t)
    execute ':sp'

    let fname=tempname()
    execute ':edit '.fname

    if a:file_t != ''
        execute ':set filetype='.a:file_t
    endif
endfunction
command! -nargs=? -bang -complete=syntax Temp call Temp('<args>') 



"----------------------------------------------------
" scratch unitily
"----------------------------------------------------

"" todo take_over_filetypeが機能してない気がする
let g:scratchSplitOption =
      \ {
      \   'vertical'           : 1,
      \   'take_over_filetype' : 1
      \ }



"----------------------------------------------------
" vim-flake8
"----------------------------------------------------

let s:flake8Enabled = 1

""" フラグが立ってればflake8する 
function! Flake8Wrapper()
  if s:flake8Enabled && executable('flake8')
    call Flake8()
  endif
endfunction

""" フラグon
function! Flake8On()
  let s:flake8Enabled = 1
  call Flake8Wrapper()
endfunction
command! -nargs=0 Flake8On call Flake8On()

""" フラグoff
function! Flake8Off()
  let s:flake8Enabled = 0
  exec ":cclose"
endfunction
command! -nargs=0 Flake8Off call Flake8Off()

augroup flake8
  autocmd!
  autocmd BufWrite,FileWritePre,FileAppendPre *.py call Flake8Wrapper()
augroup END



"---------------------------------------------------
" unite-doxygen
"----------------------------------------------------
command! -nargs=0 Doxygen :Unite doxygen



"---------------------------------------------------
" vim-easymotion
"----------------------------------------------------
map <Space> <Plug>(easymotion-prefix)


"---------------------------------------------------
" cplusplus.com
"
" Open cplusplus.com on browser with searching a word
"----------------------------------------------------
function! CppCom (kwd)
  let uri='http://www.cplusplus.com/search.do?q='.a:kwd
  call OpenBrowser(uri)
endfunction
command! -nargs=1 CppCom call CppCom('<args>')


"---------------------------------------------------
" c++ references on vim
"
" @see
" http://blog.wonderrabbitproject.net/2014/12/vim-cpprefjp-cpluspluscom.html
"----------------------------------------------------
autocmd FileType ref-* nnoremap <buffer> <silent> q :<c-u>close<cr>

let g:ref_source_webdict_sites = {
      \   'cplusplus.com': { 'url': 'http://www.cplusplus.com/search.do?q=%s', },
      \   'cpprefjp': { 'url': 'http://cpprefjp.github.io/reference/%s.html', },
      \ }

let g:ref_source_webdict_sites.default = 'cpluspluscom'

call altercmd#load()
CAlterCommand rcxx Ref webdict cplusplus.com
CAlterCommand rcxxjp Ref webdict cpprefjp


"---------------------------------------------------
" incsearch.vim
"----------------------------------------------------
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)



"---------------------------------------------------
" watchdogs_checker
"----------------------------------------------------
" let g:watchdogs_check_BufWritePost_enable = 1



"---------------------------------------------------
" vim-template
"----------------------------------------------------
" Define keywords for replacement
autocmd User plugin-template-loaded call s:template_keywords()
function! s:template_keywords()
  :silent! %s/<+FILE NAME+>/\=expand('%:t')/g
  :silent! %s/<+NAME+>/\=expand('%:r')/g
  :silent! %s/<+DATE+>/\=strftime('%Y-%m-%d')/g
  "bar_test.cpp -> bar  bar_test.py -> bar
  :silent! %s/<+TEST TARGET+>/\=split(expand('%:t'), '_test')[0]/g
  :silent! %s/<+MAIN TARGET+>/\=split(expand('%:t'), '_main')[0]/g
endfunction

" Move cursor
autocmd User plugin-template-loaded
\    if search('<+CURSOR+>')
\  |   execute 'normal! "_da>'
\  | endif



"---------------------------------------------------
" unite-tag
"
" @see http://d.hatena.ne.jp/osyo-manga/20120205/1328368314
"----------------------------------------------------

" neocomplcache が作成した tag ファイルのパスを tags に追加する
function! s:TagsUpdate()
    " include している tag ファイルが毎回同じとは限らないので毎回初期化
    setlocal tags=
    for filename in neocomplcache#sources#include_complete#get_include_files(bufnr('%'))
        execute "setlocal tags+=".neocomplcache#cache#encode_name('tags_output', filename)
    endfor
endfunction

command! -nargs=? PopupTags
      \ call <SID>TagsUpdate()
      \ |Unite tag:<args>

noremap <silent> <C-]> :<C-u>execute "PopupTags ".expand('<cword>')<CR>
