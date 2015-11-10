" 色設定
if &term =~ "xterm-256color" || "screen-256color"
    set t_Co=256
    set t_Sf=[3%dm
    set t_Sb=[4%dm
elseif &term =~ "xterm-color"
    set t_Co=8
    set t_Sf=[3%dm
    set t_Sb=[4%dm
endif

" シンタックスハイライト
syntax enable

" 行番号の表示m
set number

" カーソルライン
set cursorline
set cursorcolumn
"hi CursorLine   ctermbg=Blue
"hi CursorColumn ctermbg=Blue
"hi CursorLineNr ctermfg=Yellow

" 折り返し
set wrap

" spで下,vsで上に分割
set splitbelow
set splitright

" 行頭はタブをスペースとして扱う
set smarttab

" vi互換モードで起動しない
set nocompatible

" カーソル位置を下のバーに表示
set ruler

" 検索文字列をハイライト
set hlsearch

" 括弧の対応関係
set showmatch

" 手動でインライン折りたたみ
set foldmethod=manual

" 検索時に大文字小文字を無視
set ignorecase
set smartcase

" 検索で文頭にループしない
set nowrapscan

" backup作らない
set nobackup
set nowritebackup
set noswapfile

" マクロなどの途中経過を描写しない
set lazyredraw

" ヤンクバッファを共有
set clipboard=unnamed,autoselect

" 不可視文字を表示
set list
set listchars=tab:>-,trail:-,nbsp:%,eol:$

" 補完時に大文字と小文字を区別しない
set infercase

" 改行を削除可能に
set backspace=eol,indent,start

"C-vの矩形選択で行末より後ろもカーソルを置ける
set virtualedit=block


" 80文字目に色
"set colorcolumn=80

" エンコーディング
set encoding=utf-8

" 自動インデント
set autoindent

" インデント半角スペース4つ分
set shiftwidth=4
set tabstop=4
set softtabstop=0 "0: tabstopと同じ

" タブをスペースで代用
set expandtab

"ステータスラインにコマンドを表示
set showcmd

" 検索後にジャンプした際に検索単語を画面中央に持ってくる
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" sをつぶす
nnoremap s <Nop>

" UでRedo
nnoremap U <C-r>

" カーソル下の単語を * で検索
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>

" j, k による移動を折り返されたテキストでも自然に振る舞うように変更
nnoremap j gj
nnoremap k gk

" vを二回で行末まで選択
vnoremap v $h

" s+hjkl でウィンドウ間を移動
nnoremap sh <C-w>h
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l

" Shit+ h,lで行頭、行末に移動
noremap <S-h>  ^
noremap <S-l>  $

" 検索時に/をエスケープしない
cnoremap <expr> / (getcmdtype() == '/') ? '\/' : '/'

" コマンドラインの一致検索
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" 全角スペースを表示
augroup highlightIdegraphicSpace
    autocmd!
    autocmd Colorscheme * highlight IdeographicSpace term=underline ctermbg=DarkGreen guibg=DarkGreen
    autocmd VimEnter,WinEnter * match IdeographicSpace /　/
augroup END


"
" NeoBundle関連
"
filetype off
filetype plugin indent off

if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim
    call neobundle#begin(expand('~/.vim/bundle/'))
endif
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/neobundle.vim' " NeoBundle自身を管理

" (を自動で閉じる
"NeoBundle 'alpaca-tc/auto-pairs'

" テキスト整形
NeoBundle 'junegunn/vim-easy-align'

" ヤンク履歴管理
NeoBundle 'vim-scripts/YankRing.vim'

" indentLine
NeoBundle 'Yggdroot/indentLine'
let g:indentLine_faster = 1
nmap <silent>,i :<C-u>IndentLinesToggle<CR>

" テンプレート
NeoBundle "aperezdc/vim-template"

"
" html+css+js+php
"
NeoBundle "mattn/emmet-vim"
NeoBundle "open-browser.vim"
NeoBundle "vim-scripts/surround.vim"

"NeoBundle "othree/html5.vim" " 名前空間が干渉するので削除
NeoBundle "hail2u/vim-css3-syntax"
NeoBundle "pangloss/vim-javascript'"
NeoBundle "violetyk/neocomplete-php.vim"
let g:neocomplete_php_locale = 'ja'

"
"scala
"
NeoBundle 'derekwyatt/vim-scala'

"
" R
"
NeoBundle 'vim-scripts/Vim-R-plugin'

"
" python
"
NeoBundle 'davidhalter/jedi-vim'
NeoBundle 'hynek/vim-python-pep8-indent' " pep8に準拠したインデント
"NeoBundle 'Flake8-vim' " python文法チェック
NeoBundle 'kevinw/pyflakes-vim'

autocmd FileType python setlocal omnifunc=jedi#completions
autocmd FileType python let b:did_ftplugin = 1
set completeopt=menuone,preview

let g:jedi#use_splits_not_buffers = "rightbottom"
let g:jedi#popup_on_dot = 0
let g:jedi#popup_select_first = 0
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0

let g:python_highlight_all=1
if !exists('g:neocomplete#force_omni_input_patterns')
        let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.python = '\h\w*\|[^. \t]\.\w*'

let g:jedi#documation_command = "m" " pydocを開く
let g:jedi#rename_command = "" " pythonのrename用のマッピングがquickrunとかぶるため回避させる

let g:syntastic_python_checkers = ["flake8"]
let g:syntastic_python_flake8_args="--max-line-length=35"


" change syntax highligt
if version < 600
  syntax clear
elseif exists('b:current_after_syntax')
  finish
endif

let s:cpo_save = &cpo "設定を一時退避
set cpo&vim

syn match pythonOperator "\(+\|=\|-\|\^\|\*\)"
syn match pythonDelimiter "\(,\|\.\|:\)"
syn keyword pythonSpecialWord self

hi link pythonSpecialWord    Special
hi link pythonDelimiter      Special
let b:current_after_syntax = 'python'

let &cpo = s:cpo_save
unlet s:cpo_save



"
" color-theme関連
"
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'tomasr/molokai'
NeoBundle 'croaker/mustang-vim'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'vim-scripts/Lucius'
NeoBundle 'jpo/vim-railscasts-theme'
NeoBundle 'vim-scripts/wombat'

set rtp+=~/.vim/bundle/vim-railscasts-theme
set rtp+=~/.vim/bundle/jellybeans.vim
set rtp+=~/.vim/bundle/molokai
colorscheme railscasts

"completeoptの背景色をグレーにする
highlight Pmenu ctermbg=8
highlight PmenuSel ctermbg=Yellow
highlight PmenuSbar ctermbg=Yellow


"
" git
"
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'gregsexton/gitv'

function! s:gitv_get_current_hash()
  return matchstr(getline('.'), '\[\zs.\{7\}\ze\]$')
endfunction

autocmd FileType git setlocal nofoldenable foldlevel=0
function! s:toggle_git_folding()
  if &filetype ==# 'git'
    setlocal foldenable!
  endif
endfunction

autocmd FileType gitv call s:my_gitv_settings()
function! s:my_gitv_settings()
    " 現在のカーソル位置にあるブランチ名を取得してログ上でブランチにcheckout
    setlocal iskeyword+=/,-,.
    nnoremap <silent><buffer> C :<C-u>Git checkout <C-r><C-w><CR>
    nnoremap <buffer> <Space>rb :<C-u>Git rebase <C-r>=GitvGetCurrentHash()<CR><Space>
    nnoremap <buffer> <Space>R :<C-u>Git revert <C-r>=GitvGetCurrentHash()<CR><CR>
    nnoremap <buffer> <Space>h :<C-u>Git cherry-pick <C-r>=GitvGetCurrentHash()<CR><CR>
    nnoremap <buffer> <Space>rh :<C-u>Git reset --hard <C-r>=GitvGetCurrentHash()<CR>
    nnoremap <silent><buffer> t :<C-u>windo call <SID>toggle_git_folding()<CR>1<C-w>w
endfunction


"
" 文法チェック
"
NeoBundle 'scrooloose/syntastic'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" バッファを閉じたら閉じる
nnoremap <silent> <C-d> :lclose<CR>:bdelete<CR>
cabbrev <silent> bd <C-r>=(getcmdtype()==#':' && getcmdpos()==1 ? 'lclose\|bdelete' : 'bd')<CR>

"
" タブバー
"
" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:tabline()
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
endfunction
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 " 常にタブラインを表示

" The prefix key.
nnoremap [Tag] <Nop>
nmap t [Tag]
nmap T [Tag]
" Tab jump
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor

map <silent> [Tag]c :tablast <bar> tabnew<CR>
map <silent> [Tag]x :tabclose<CR>
map <silent> [Tag]n :tabnext<CR>
map <silent> [Tag]p :tabprevious<CR>


"
" vimshell
"
NeoBundle 'Shougo/vimshell'

"
" statusline
"
set laststatus=2
set statusline=%f       "tail of the filename
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}] "file format
set statusline+=%h      "help file flag
set statusline+=%m      "modified flag
set statusline+=%r      "read only flag
set statusline+=%y      "filetype
set statusline+=%=      "left/right separator
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file


"
" vimfiler(left window)
"
NeoBundleLazy "Shougo/vimfiler", {
      \ "depends": ["Shougo/unite.vim"],
      \ "autoload": {
      \   "commands": ["VimFilerTab", "VimFiler", "VimFilerExplorer"],
      \   "mappings": ['<Plug>(vimfiler_switch)'],
      \   "explorer": 1,
      \ }}
let g:unite_enable_start_insert=1
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_enable_auto_cd = 1
"let g:vimfiler_ignore_pattern = "\%(^\..*\|\.pyc$\)"

"
" tagbar(right window)
"
NeoBundle 'majutsushi/tagbar'
let g:tagbar_vertical = 35

"toggle plugins
nnoremap <buffer> <silent> ,l :VimFiler -split -simple -winwidth=30 -toggle  -no-quit<CR>:TagbarToggle<CR><C-w>l
"nnoremap <buffer> ,l :VimFiler -split -simple -winwidth=30 -toggle -no-quit<CR><C-[><C-w>l
nnoremap <buffer> ,s :VimShell -split-command=15sp -toggle<CR><C-[><C-w>k
nnoremap <buffer> ,v :VimShell -split-command=vs -toggle<CR><C-[><C-w>h
nnoremap <buffer> ,p :VimShellInteractive ipython<CR><C-[><C-w>h
nnoremap <buffer> ,R :VimShellInteractive R<CR><C-[><C-w>h
vnoremap <buffer> ,r :VimShellSendString<CR>
nnoremap <buffer> ,r <S-v>:VimShellSendString<CR>

"
" neocomplete
"
NeoBundle 'Shougo/neocomplete'

let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  " return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" Close popup by <Space>.
inoremap <expr><Space> pumvisible() ? neocomplete#close_popup()."\<Space>" : "\<Space>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()



"
" 非同期処理
"
NeoBundle 'Shougo/vimproc', {
            \ 'build' : {
            \ 'windows' : 'make -f make_mingw32.mak',
            \ 'cygwin' : 'make -f make_cygwin.mak',
            \ 'mac' : 'make -f make_mac.mak',
            \ 'unix' : 'make -f make_unix.mak',
            \ },
        \ }


"
" quickrun
"
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'osyo-manga/unite-quickfix'
let g:quickrun_config = {
\   "*" : {
\       "split" : "",
\   },
\   "_" : {
\       "hook/close_unite_quickfix/enable_hook_loaded" : 1,
\       "hook/unite_quickfix/enable_failure" : 1,
\       "hook/close_quickfix/enable_exit" : 1,
\       "hook/close_buffer/enable_failure" : 1,
\       "hook/close_buffer/enable_empty_data" : 1,
\       "outputter" : "multi:buffer:quickfix",
\       "outputter/buffer/split" : ":botright 8sp",
\       "runner" : "vimproc",
\       "runner/vimproc/updatetime" : 40,
\   }
\}
" C-cで抜ける
nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"

"
" 編集補佐
"
NeoBundle 'tpope/vim-surround'


" unite.vim
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/neossh.vim'
NeoBundle 'ujihisa/quicklearn'
NeoBundle 'thinca/vim-unite-history'
NeoBundle 'tsukkee/unite-help'
" The prefix key.
nnoremap [unite] <Nop> nmap ,u [unite]
nmap ,n [unite]
nnoremap <silent> [unite]b :<C-u>Unite -toggle -direction=dynamicbottom buffer<CR>
nnoremap <silent> [unite]n :<C-u>Unite -toggle -direction=dynamicbottom bookmark<CR>
nnoremap <silent> [unite]m :<C-u>Unite -toggle -direction=dynamicbottom file_mru<CR>
nnoremap <silent> [unite]r :<C-u>UniteWithBufferDir file<CR>
nnoremap <silent> ,vr :UniteResume<CR>

" コマンドモードで開始
let g:unite_enable_start_insert = 0 
" ファイル履歴の保存数
let g:unite_source_file_mru_limit = 50

"file_mruの表示フォーマットを指定。空にすると表示スピードが高速化される
let g:unite_source_file_mru_filename_format = ''

" unite-grepのバックエンドをagに切り替える
" http://qiita.com/items/c8962f9325a5433dc50d
let g:unite_source_grep_command = 'ag'
let g:unite_source_grep_default_opts = '--nocolor --nogroup'
let g:unite_source_grep_recursive_opt = ''
let g:unite_source_grep_max_candidates = 200

" unite-grepのキーマップ
" 選択した文字列をunite-grep
" https://github.com/shingokatsushima/dotfiles/blob/master/.vimrc
vnoremap /g y:Unite grep::-iHRn:<C-R>=escape(@", '\\.*$^[]')<CR><CR>

"
" lightline.vim
"
NeoBundle 'itchyny/lightline.vim'
" vim-gitgutter
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '->'
let g:gitgutter_sign_removed = 'x'

" lightline.vim
let g:lightline = {
        \ 'colorscheme': 'wombat',
        \ 'mode_map': {'c': 'NORMAL'},
        \ 'active': {
        \   'left': [
        \     ['mode', 'paste'],
        \     ['fugitive', 'gitgutter', 'filename'],
        \   ],
        \   'right': [
        \     ['lineinfo', 'syntastic'],
        \     ['percent'],
        \     ['charcode', 'fileformat', 'fileencoding', 'filetype'],
        \   ]
        \ },
        \ 'component_function': {
        \   'modified': 'MyModified',
        \   'readonly': 'MyReadonly',
        \   'fugitive': 'MyFugitive',
        \   'filename': 'MyFilename',
        \   'fileformat': 'MyFileformat',
        \   'filetype': 'MyFiletype',
        \   'fileencoding': 'MyFileencoding',
        \   'mode': 'MyMode',
        \   'syntastic': 'SyntasticStatuslineFlag',
        \   'charcode': 'MyCharCode',
        \   'gitgutter': 'MyGitGutter',
        \ },
        \ 'separator': {'left': '>>', 'right': '|'},
        \ 'subseparator': {'left': '', 'right': '|'}
        \ }

function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &ro ? '|' : ''
endfunction

function! MyFilename()
  let fname = expand('%p:t')
  return  &ft == 'vimfiler' ? vimfiler#get_status_string() :
        \ &ft == 'unite' ? unite#get_status_string() :
        \ &ft == 'vimshell' ? vimshell#get_status_string() :
        \ ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  try
    if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
      let _ = fugitive#head()
      return strlen(_) ? '⭠ '._ : ''
    endif
  catch
  endtry
  return ''
endfunction

function! MyFileformat()
  return winwidth('.') > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth('.') > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth('.') > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  return winwidth('.') > 60 ? lightline#mode() : ''
endfunction

function! MyGitGutter()
  if ! exists('*GitGutterGetHunkSummary')
        \ || ! get(g:, 'gitgutter_enabled', 0)
        \ || winwidth('.') <= 90
    return ''
  endif
  let symbols = [
        \ g:gitgutter_sign_added . ' ',
        \ g:gitgutter_sign_modified . ' ',
        \ g:gitgutter_sign_removed . ' '
        \ ]
  let hunks = GitGutterGetHunkSummary()
  let ret = []
  for i in [0, 1, 2]
    if hunks[i] > 0
      call add(ret, symbols[i] . hunks[i])
    endif
  endfor
  return join(ret, ' ')
endfunction

" https://github.com/Lokaltog/vim-powerline/blob/develop/autoload/Powerline/Functions.vim
function! MyCharCode()
  if winwidth('.') <= 70
    return ''
  endif

  " Get the output of :ascii
  redir => ascii
  silent! ascii
  redir END

  if match(ascii, 'NUL') != -1
    return 'NUL'
  endif

  " Zero pad hex values
  let nrformat = '0x%02x'

  let encoding = (&fenc == '' ? &enc : &fenc)

  if encoding == 'utf-8'
    " Zero pad with 4 zeroes in unicode files
    let nrformat = '0x%04x'
  endif

  " Get the character and the numeric value from the return value of :ascii
  " This matches the two first pieces of the return value, e.g.
  " "<F>  70" => char: 'F', nr: '70'
  let [str, char, nr; rest] = matchlist(ascii, '\v\<(.{-1,})\>\s*([0-9]+)')

  " Format the numeric value
  let nr = printf(nrformat, nr)

  return "'". char ."' ". nr
endfunction 

call neobundle#end()

filetype plugin indent on     " required!
filetype indent on
syntax on

