"=========================================================================
" 基本設定
"=========================================================================
syntax enable " シンタックスハイライト
set encoding=utf-8 " エンコーディング
set number     " 行番号の表示
set cursorline   " カーソルライン横
set cursorcolumn " カーソルライン横 
set wrap       " 文を折り返し
set splitbelow " spで下に分割
set splitright " vsで上に分割
set smarttab   " 行頭はタブをスペースとして扱う
set nocompatible " vi互換モードで起動しない
set ruler      " カーソル位置を下のバーに表示
set showmatch  " カーソル下の対応するカッコをハイライト
set lazyredraw " マクロなどの途中経過を描写しない
set clipboard=unnamed,autoselect " ヤンクバッファを共有
set foldmethod=manual " 手動でグルーピング
set infercase  " 補完時に大文字と小文字を区別しない
set backspace=eol,indent,start " 改行を削除可能に
set virtualedit=block "C-vの矩形選択で行末より後ろもカーソルを置ける
set autoindent " 自動インデント
set shiftwidth=4 " インデントは半角スペース4つ分
set expandtab  " タブをスペースで代用
set tabstop=4  " タブは半角スペース4つ分で表示
set softtabstop=0 "タブ入力時のスペース挿入数(0=tabstopと同じ)
set showcmd    "ステータスラインにコマンドを表示
set hlsearch   " 検索文字列をハイライト
set nowrapscan " 検索で文頭にループしない
set ignorecase " 検索時に大文字小文字を無視
set smartcase

" backup作らない 
set nobackup
set nowritebackup
set noswapfile

" 不可視文字を表示 
set list
set listchars=tab:>-,trail:-,nbsp:%,eol:$

" 検索時に/をエスケープしない
cnoremap <expr> / (getcmdtype() == '/') ? '\/' : '/'

" 全角スペースを表示
augroup highlightIdegraphicSpace
    autocmd!
    autocmd Colorscheme * highlight IdeographicSpace term=underline ctermbg=DarkGreen guibg=DarkGreen
    autocmd VimEnter,WinEnter * match IdeographicSpace /　/
augroup END


"=========================================================================
" NeoBundle開始
"=========================================================================
filetype off
filetype plugin indent off

if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim
    call neobundle#begin(expand('~/.vim/bundle/'))
endif

"NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/neobundle.vim' " NeoBundle自身を管理


"=========================================================================
" unite
"=========================================================================
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/neossh.vim'
NeoBundle 'ujihisa/quicklearn'
NeoBundle 'thinca/vim-unite-history'
NeoBundle 'tsukkee/unite-help'

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



"=========================================================================
" 色変更
"=========================================================================

" 256色を有効化
if &term =~ "xterm-256color" || "screen-256color"
    set t_Co=256
    set t_Sf=[3%dm
    set t_Sb=[4%dj
elseif &term =~ "xterm-color"
    set t_Co=8
    set t_Sf=[3%dm
    set t_Sb=[4%dm
endif


" color-theme管理
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

" color-theme設定
colorscheme railscasts


" 背景色 off=:BgtDisable, on =:BgtEnable
if exists('g:loaded_bgt')
  finish
endif
let g:loaded_bgt = 1

let s:save_cpo = &cpo
set cpo&vim

function! s:clear_bg(hl)
  execute 'highlight ' . a:hl . ' ctermbg=None'
endfunction

function! s:clear_bg_all()
  call s:clear_bg('Normal')
  call s:clear_bg('LineNr')
  " call s:clear_bg('Folded')
  call s:clear_bg('SignColumn')
  call s:clear_bg('VertSplit')
  call s:clear_bg('NonText')
endfunction

function! s:clear_auto()
  call s:clear_bg_all()
  augroup bgt_auto
    autocmd!
    autocmd ColorScheme * call s:clear_bg_all()
  augroup END
endfunction

function! s:disable()
  autocmd! bgt_auto
  let l:colors_name = get(g:, 'colors_name', '')
  echomsg l:colors_name
  if l:colors_name !=# ''
    try
      execute 'colorscheme ' . l:colors_name
    endtry
  endif
endfunction

command! BgtEnable call s:clear_auto()
command! BgtDisable call s:disable()

let g:bgt_auto_enable=1

if get(g:, 'bgt_auto_enable', 0)
  augroup bgt
    autocmd VimEnter * execute "call s:clear_auto()"
  augroup END
endif

let &cpo = s:save_cpo
unlet s:save_cpo



"=========================================================================
" コード入力補助
"=========================================================================
NeoBundle 'tpope/vim-surround'
NeoBundle 't9md/vim-choosewin' " ウィンドウ選択
NeoBundle 'junegunn/vim-easy-align' " テキスト整形
NeoBundle "aperezdc/vim-template" " テンプレート作成
NeoBundle 'LeafCage/qutefinger.vim' " QuickFix操作



" インデントを見やすく
NeoBundle 'Yggdroot/indentLine'
let g:indentLine_faster = 1



" ヤンク履歴管理
NeoBundle 'LeafCage/yankround.vim'
let g:yankround_max_history = 35
let g:yankround_dir = '~/.cache/yankround'



" 文法チェック
NeoBundle 'scrooloose/syntastic'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" バッファを閉じたら閉じる
nnoremap <silent> <C-d> :lclose<CR>:bdelete<CR>
cabbrev <silent> bd <C-r>=(getcmdtype()==#':' && getcmdpos()==1 ? 'lclose\|bdelete' : 'bd')<CR>



" 補完(+lua)
NeoBundle 'Shougo/neocomplete'
let g:acp_enableAtStartup = 0 " Use neocomplete.
let g:neocomplete#enable_at_startup = 1 " Use smartcase.
let g:neocomplete#enable_smart_case = 1 " Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

"completeoptの背景色をグレーにする
highlight Pmenu ctermbg=8
highlight PmenuSel ctermbg=Yellow
highlight PmenuSbar ctermbg=Yellow



"=========================================================================
" git
"=========================================================================
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

" コマンド省略用の設定
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
autocmd FileType gitv call s:my_gitv_settings()


"=========================================================================
" 各言語設定
"=========================================================================
"--------
" python
"--------
" コードチェック
NeoBundle 'hynek/vim-python-pep8-indent' " pep8に準拠したインデント
NeoBundle 'kevinw/pyflakes-vim'
"NeoBundle 'Flake8-vim' " python文法チェック(pep8は厳しすぎるためFlakesのみにした)
let g:syntastic_python_checkers = ["flake8"]
let g:syntastic_python_flake8_args="--max-line-length=35"



" python用補完
NeoBundle 'davidhalter/jedi-vim'
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



" python用シンタックスハイライト
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



"------------
" その他言語
"------------
NeoBundle 'derekwyatt/vim-scala' " scala
NeoBundle 'vim-scripts/Vim-R-plugin' " R

NeoBundle "mattn/emmet-vim"
NeoBundle "open-browser.vim"
NeoBundle "vim-scripts/surround.vim"
NeoBundle "hail2u/vim-css3-syntax" " css
NeoBundle "pangloss/vim-javascript'" " js
NeoBundle "violetyk/neocomplete-php.vim" " php
let g:neocomplete_php_locale = 'ja'
" 名前空間が干渉するので削除
"NeoBundle 'othree/html5.vim'



"=========================================================================
" ウィジェット関連
"=========================================================================
" ----------------
" タブ関連(画面上)
" ----------------
set showtabline=2 " 常にタブラインを表示

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



" -----------------------------
" ステータスライン関連（画面下）
" -----------------------------
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

NeoBundle 'itchyny/lightline.vim'
" vim-gitgutter関連
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



"-----------------------------------
" ファイラ・タグジャンプ関連（画面横）
"-----------------------------------
" vimfiler
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



" tagbar
NeoBundle 'majutsushi/tagbar'
let g:tagbar_vertical = 35
let mapleader="," " Set leader to ,
"let maplocalleader = "\\"



"------------
" shell関連
"------------
" quickrun
NeoBundle 'Shougo/vimshell'

" vimproc(非同期処理)
NeoBundle 'Shougo/vimproc', {
            \ 'build' : {
            \ 'windows' : 'make -f make_mingw32.mak',
            \ 'cygwin' : 'make -f make_cygwin.mak',
            \ 'mac' : 'make -f make_mac.mak',
            \ 'unix' : 'make -f make_unix.mak',
            \ },
        \ }

" quickrun
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'osyo-manga/unite-quickfix'
let g:quickrun_config = {
\   "_" : {
\       "hook/close_unite_quickfix/enable_hook_loaded" : 1,
\       "hook/unite_quickfix/enable_failure" : 1,
\       "hook/close_quickfix/enable_exit" : 1,
\       "hook/close_buffer/enable_failure" : 1,
\       "hook/close_buffer/enable_empty_data" : 1,
\       "outputter" : "multi:buffer:quickfix",
\       "outputter/buffer/split" : ":15sp",
\       "runner" : "vimproc",
\       "runner/vimproc/updatetime" : 40,
\   }
\}
" C-cで抜ける
nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"
let g:quickrun_config["outputter/buffer/close_on_empty"] = 0 " 1=空の場合は閉じる



"=========================================================================
" NeoBundle終了
"=========================================================================
call neobundle#end()

filetype plugin indent on     " required!
filetype indent on
syntax on

" マーク可視化
"NeoBundle 'kshenoy/vim-signature'
"NeoBundle 'LeafCage/visiblemarks.vim'

" (を自動で閉じる
"NeoBundle 'alpaca-tc/auto-pairs'



"=========================================================================
" ショートカット関連
"=========================================================================
" Shit+ h,lで行頭、行末に移動
noremap <S-h>  ^
noremap <S-l>  $

" コマンドラインの一致検索
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" Select entire buffer
nnoremap vy ggVG

" カーソル下の単語を * で検索
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>

" 検索後にジャンプした際に検索単語を画面中央に持ってくる
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" UでRedo
nnoremap U <C-r>

" j, k による移動を折り返されたテキストでも自然に振る舞うように変更
nnoremap j gj
nnoremap k gk

" vを二回で行末まで選択
vnoremap v $h

" vim-choosewin起動
nmap - <Plug>(choosewin)



" yankround関連
nmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap gp <Plug>(yankround-gp)
nmap gP <Plug>(yankround-gP)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)



" neocomplete関連
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

function! s:my_cr_function()
  " return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction

" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" Close popup by <Space>.
inoremap <expr><Space> pumvisible() ? neocomplete#close_popup()."\<Space>" : "\<Space>"

" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()


"-----------------------
"sで始まるショートカット
"-----------------------
nnoremap s <Nop>

" s+hjkl でウィンドウ間を移動
nnoremap sh <C-w>h
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l

" sq+hjklでウィンドウを削除
nnoremap sqh <C-w>h:q
nnoremap sqj <C-w>j:q
nnoremap sqk <C-w>k:q
nnoremap sql <C-w>l:q

" ノーマルモードで行挿入
nnoremap so o<Esc>k
nnoremap sO O<Esc>j

" s+-=*で行を挿入
"nnoremap <silent> s- :t.\|s/./-/\|:nohls<cr>
"nnoremap <silent> s= :t.\|s/./=/\|:nohls<cr>
"nnoremap <silent> s* :t.\|s/./*/\|:nohls<cr>

" qutefinger.vim関連
nnoremap sz <Plug>(qutefinger-toggle-mode)
nnoremap sn <Plug>(qutefinger-next)
nnoremap sp <Plug>(qutefinger-prev)
nnoremap sP <Plug>(qutefinger-older)
nnoremap sN <Plug>(qutefinger-newer)
nnoremap sv <Plug>(qutefinger-toggle-win)

" unite関連
nnoremap [unite] <Nop>
nnoremap <silent> sb :<C-u>Unite -toggle -direction=dynamicbottom buffer<CR>
nnoremap <silent> sm :<C-u>Unite -toggle -direction=dynamicbottom bookmark<CR>
nnoremap <silent> sf :<C-u>Unite -toggle -direction=dynamicbottom file_mru<CR>
nnoremap <silent> sr :<C-u>UniteWithBufferDir file<CR>
nnoremap <silent> ,sr :UniteResume<CR>
" 選択した文字列をunite-grep -> https://github.com/shingokatsushima/dotfiles/blob/master/.vimrc
vnoremap /g y:Unite grep::-iHRn:<C-R>=escape(@", '\\.*$^[]')<CR><CR>



"-----------------------
" tで始まるショートカット
"-----------------------
" tabbar関連
nnoremap [Tag] <Nop>
nmap t [Tag]
map <silent> [Tag]c :tablast <bar> tabnew<CR>
map <silent> [Tag]x :tabclose<CR>
map <silent> [Tag]n :tabnext<CR>
map <silent> [Tag]p :tabprevious<CR>
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor



"-----------------------
" ,で始まるショートカット
"-----------------------
" vimshell関連
nnoremap <buffer> <silent> <leader>h :VimFiler -split -simple -winwidth=30 -toggle  -no-quit<CR>:TagbarToggle<CR><C-w>l
nnoremap <buffer> <silent> <leader>l :VimFiler -split -simple -winwidth=30 -toggle  -no-quit -direction=botright<CR>:TagbarToggle<CR><C-w>h
nnoremap <buffer> <leader>s :VimShell -split-command=15sp -toggle<CR>
nnoremap <buffer> <leader>v :VimShell -split-command=vs -toggle<CR>
nnoremap <buffer> <leader>p :VimShellInteractive ipython<CR><C-[><C-w>h
nnoremap <buffer> <leader>R :VimShellInteractive R<CR><C-[><C-w>h
vnoremap <buffer> <leader>r :VimShellSendString<CR>
nnoremap <buffer> <leader>r <S-v>:VimShellSendString<CR>
nnoremap <buffer> <leader>q :QuickRun<CR>



"=========================================================================
" ローカルの設定ファイルをロード
"=========================================================================

if filereadable(expand('~//.vimrc.local'))
    source ~/.vimrc.local
endif

