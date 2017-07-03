"=========================================================================
" initialize
"=========================================================================
let s:cpo_save = &cpo "compatible optionsの値を退避
set cpo&vim "vimモードに

" reset augroup
augroup MyAutoCmd
  autocmd!
augroup END

"=========================================================================
" 基本設定
"=========================================================================
" ファイルタイプ関連を一旦切っておく
filetype off
filetype plugin indent off

syntax on " シンタックス有効に
set encoding=utf-8 " エンコーディング
set number     " 行番号の表示
" set cursorline   " カーソルライン横（重いので無効)
" set cursorcolumn " カーソルライン横（重いので無効)
" set wrap       " 文を折り返す
set splitbelow " spで下に分割
set splitright " vsで上に分割
set ruler      " カーソル位置を下のバーに表示
set showmatch  " カーソル下の対応するカッコをハイライト
set lazyredraw " マクロなどの途中経過を描写しない
set foldmethod=manual " 手動でグルーピング
set infercase  " 補完時に大文字と小文字を区別しない
set backspace=eol,indent,start " 改行等を削除可能に
set virtualedit=block "C-vの矩形選択で行末より後ろもカーソルを置ける
set smarttab   " 行頭はタブをスペースとして扱う
set expandtab  " タブをスペースで代用
set softtabstop=0 "タブ入力時のスペース挿入数(0=tabstopと同じ)
set tabstop=4  " タブは半角スペース4つ分で表示
set autoindent " 自動インデント
set shiftwidth=4 " インデントは半角スペース4つ分
set showcmd    "ステータスラインにコマンドを表示
set hlsearch   " 検索文字列をハイライト
set nowrapscan " 検索で文頭にループしない
set ignorecase smartcase " 基本ignorecaseだが大文字小文字が混在しているときは普通に検索
set clipboard+=unnamedplus " ヤンクバッファを共有
set nobackup nowritebackup " backup file作らない
set noswapfile " swap file作らない
set hidden " バッファを移動する際に保存しなくて済む
set colorcolumn=80 " 80行目に線
set list listchars=tab:>-,trail:-,nbsp:%,eol:$ " 不可視文字を表示

" 検索時に/をエスケープしない
cnoremap <expr> / (getcmdtype() == '/') ? '\/' : '/'

" コメント行を改行したときに自動でコメントアウト記号をいれない
augroup auto_complete_off
    autocmd!
    autocmd BufEnter * setlocal formatoptions-=r
    autocmd BufEnter * setlocal formatoptions-=o
augroup END

" dein
set rtp+=~/.vim/dein/repos/github.com/Shougo/dein.vim
call dein#begin(expand('~/.vim/dein/'))
call dein#add('Shougo/dein.vim') " dein自身を管理



"=========================================================================
" denite
"=========================================================================
call dein#add('Shougo/denite.nvim')
call dein#add('Shougo/neomru.vim')
call dein#add('Shougo/neoyank.vim')
call dein#add('Shougo/neossh.vim')

call dein#add('rking/ag.vim')  " 高速な検索
call denite#custom#var('file_rec', 'command', ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'default_opts', ['--follow', '--no-group', '--no-color'])



"=========================================================================
" コード入力補助
"=========================================================================
call dein#add('t9md/vim-choosewin')  " ウィンドウ選択
call dein#add('tpope/vim-surround')  " 括弧などのブロック文字を簡単に変更
call dein#add('cohama/lexima.vim')  " 自動でカッコなどを閉じる
call dein#add('aperezdc/vim-template')  " テンプレート作成
call dein#add('junegunn/vim-easy-align')  " テキスト整形
call dein#add('mattn/emmet-vim')  " htmlタグ打ちショートカット
call dein#add('bronson/vim-trailing-whitespace')  " 全角スペースをハイライト
" call dein#add('Shougo/neosnippet-snippets')  " スニペット
" call dein#add('Shougo/neosnippet.vim')  "<Ctrl-k>で入力

" completion
call dein#add('Shougo/deoplete.nvim')  " completion engine
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_delay = 0
let g:deoplete#auto_complete_start_length = 1
let g:deoplete#enable_camel_case = 0
let g:deoplete#enable_ignore_case = 0
let g:deoplete#enable_refresh_always = 0
let g:deoplete#enable_smart_case = 1
let g:deoplete#file#enable_buffer_path = 1
let g:deoplete#max_list = 10000

" color-theme
call dein#add('cocopon/iceberg.vim')
colorscheme iceberg

" 一括コメントアウト追加/削除
call dein#add('tomtom/tcomment_vim')
let g:tcommentMapLeaderOp1 = 'sc'
let g:tcommentMapLeaderUncommentAnyway = 's<'
let g:tcommentMapLeaderCommentAnyway = 's>'

" 画面内の任意の場所にジャンプ
call dein#add('easymotion/vim-easymotion')
let g:EasyMotion_keys = 'fjdkslaureiwoqpvncm' " ジャンプ用のタグに使う文字の優先順位
let g:EasyMotion_startofline = 0 " keep cursor column when JK motion

" インデントを見やすく
call dein#add('Yggdroot/indentLine')
let g:indentLine_faster = 1

" ペーストの後<Ctrl-p><Ctrl-n>でヤンクバッファを探索
call dein#add('LeafCage/yankround.vim')
let g:yankround_max_history = 35
let g:yankround_dir = '~/.cache/yankround'

" カレントバッファを閉じたら一緒に閉じる
nnoremap <silent> <C-d> :lclose<CR>:bdelete<CR>
cabbrev <silent> bd <C-r>=(getcmdtype()==#':' && getcmdpos()==1 ? 'lclose\|bdelete' : 'bd')<CR>

" true/false切り替え"
call dein#add('AndrewRadev/switch.vim')
let g:switch_mapping = "s-"

" linter
call dein#add('w0rp/ale')
let g:ale_linters = {
            \    'python': ['flake8']
            \}



"=========================================================================
" 各言語設定
"=========================================================================
"--------
" python
"--------
" python2ではコーディングしない
" python3はpyenvのものを使う
" call dein#add('lambdalisue/vim-pyenv')
let g:my_python_path = '/usr/bin/python'
let g:my_python3_path = $PYENV_ROOT . '/shims/python'
let g:python_host_prog = g:my_python_path
let g:python3_host_prog = g:my_python3_path

call dein#add('neovim/python-client')
call dein#add('hynek/vim-python-pep8-indent')  " pep8に準拠したインデント
call dein#add('zchee/deoplete-jedi')  " completion
" let g:deoplete#sources#jedi#python_path = g:my_python3_path



"------------
" JavaScript + AltJS
"------------
call dein#add('pangloss/vim-javascript')  " js
call dein#add('carlitux/deoplete-ternjs')
call dein#add('leafgarland/typescript-vim')  "ts
call dein#add('mhartington/nvim-typescript')
call dein#add('elzr/vim-json')  " json
call dein#add('hail2u/vim-css3-syntax')  " css
call dein#add('othree/html5.vim')  " html5



"------------
" C++
"------------
call dein#add('Rip-Rip/clang_complete')



"------------
" その他言語
"------------
call dein#add('Shougo/neco-vim') " vim
call dein#add('vim-scripts/dbext.vim')  "sql
call dein#add('vim-scripts/Vim-R-plugin')  " R
call dein#add('plasticboy/vim-markdown')  " md
call dein#add('kannokanno/previm')  " md preview
call dein#add('vim-scripts/open-browser.vim')  "ブラウザに飛ばす
let g:netrw_nogx = 1 " disable netrw's gx mapping.



"=========================================================================
" git
"=========================================================================
autocmd FileType git setlocal nofoldenable foldlevel=0

call dein#add('gregsexton/gitv')
call dein#add('tpope/vim-fugitive')
" call dein#add('airblade/gitgutter')

function! GitvGetCurrentHash()
  return matchstr(getline('.'), '\[\zs.\{7\}\ze\]$')
endfunction

function! ToggleGitFolding()
  if &filetype ==# 'git'
    setlocal foldenable!
  endif
endfunction

" コマンド省略用の設定
function! MyGitvSettings()
    setlocal iskeyword+=/,-,.  " 現在のカーソル位置にあるブランチ名を取得してログ上でブランチにcheckout
    nnoremap <silent><buffer> co :<C-u>Gitv checkout <C-r><C-w><CR>
    nnoremap <buffer> <Space>rb :<C-u>Gitv rebase <C-r>=GitvGetCurrentHash()<CR><Space>
    nnoremap <buffer> <Space>rv :<C-u>Gitv revert <C-r>=GitvGetCurrentHash()<CR><CR>
    nnoremap <buffer> <Space>cp :<C-u>Gitv cherry-pick <C-r>=GitvGetCurrentHash()<CR><CR>
    nnoremap <buffer> <Space>rh :<C-u>Gitv reset --hard <C-r>=GitvGetCurrentHash()<CR>
    nnoremap <silent><buffer> t :<C-u>windo call <SID>ToggleGitFolding()<CR>1<C-w>w
endfunction
autocmd FileType gitv call MyGitvSettings()



"=========================================================================
" ウィジェット関連
"=========================================================================
" ----------------
" タブ関連(画面上)
" ----------------
" set showtabline=2 " 常にタブラインを表示
"
" function! s:SID_PREFIX()
"   return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
" endfunction
"
" " Set tabline.
" function! s:Tabline()
"   let s = ''
"   for i in range(1, tabpagenr('$'))
"     let bufnrs = tabpagebuflist(i)
"     let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
"     let no = i  " display 0-origin tabpagenr.
"     let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
"     let title = fnamemodify(bufname(bufnr), ':t')
"     let title = '[' . title . ']'
"     let s .= '%'.i.'T'
"     let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
"     let s .= no . ':' . title
"     let s .= mod
"     let s .= '%#TabLineFill# '
"   endfor
"   let s .= '%#TabLineFill#%T%=%#TabLine#'
"   return s
" endfunction
" let &tabline = '%!'. s:SID_PREFIX() . 'Tabline()'



" -----------------------------
" ステータスライン関連（画面下）
" -----------------------------
" set laststatus=2
" set statusline=%f       "tail of the filename
" set statusline+=%#warningmsg#
" set statusline+=%{ALEGetStatusLine()}
" set statusline+=%*
" set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
" set statusline+=%{&ff}] "file format
" set statusline+=%h      "help file flag
" set statusline+=%m      "modified flag
" set statusline+=%r      "read only flag
" set statusline+=%y      "filetype
" set statusline+=%=      "left/right separator
" set statusline+=%c,     "cursor column
" set statusline+=%l/%L   "cursor line/total lines
" set statusline+=\ %P    "percent through file
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '->'
let g:gitgutter_sign_removed = 'x'
let g:ale_statusline_format = ['E%d', 'W%d', '']

call dein#add('itchyny/lightline.vim')
let g:lightline = {
        \ 'colorscheme': 'wombat',
        \ 'mode_map': {'c': 'NORMAL'},
        \ 'active': {
        \   'left': [
        \     ['mode', 'paste'],
        \     ['pyenv'],
        \     ['ale'],
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
        \   'readonly': 'MyReadOnly',
        \   'fugitive': 'MyFugitive',
        \   'filename': 'MyFileName',
        \   'fileformat': 'MyFileFormat',
        \   'filetype': 'MyFileType',
        \   'fileencoding': 'MyFileEncoding',
        \   'mode': 'MyMode',
        \   'syntastic': 'SyntasticStatuslineFlag',
        \   'charcode': 'MyCharCode',
        \   'gitgutter': 'MyGitGutter',
        \   'pyenv': 'pyenv#statusline#component',
        \   'ale': 'ALEGetStatusLine',
        \ },
        \ 'separator': {'left': '>>', 'right': '|'},
        \ 'subseparator': {'left': '', 'right': '|'}
        \ }

function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadOnly()
  return &ft !~? 'help\|vimfiler\|gundo' && &ro ? '|' : ''
endfunction

function! MyFileName()
  let fname = expand('%p:t')
  return  &ft == 'vimfiler' ? vimfiler#get_status_string() :
        \ &ft == 'unite' ? unite#get_status_string() :
        \ &ft == 'vimshell' ? vimshell#get_status_string() :
        \ ('' != MyReadOnly() ? MyReadOnly() . ' ' : '') .
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

function! MyFileFormat()
  return winwidth('.') > 70 ? &fileformat : ''
endfunction

function! MyFileType()
  return winwidth('.') > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileEncoding()
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

" http//github.com/Lokaltog/vim-powerline/blob/develop/autoload/Powerline/Functions.vim
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
call dein#add('Shougo/vimfiler')
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_enable_auto_cd = 1
"let g:vimfiler_ignore_pattern = "\%(^\..*\|\.pyc$\)"



" tagbar
call dein#add('majutsushi/tagbar')
let g:tagbar_vertical = 35
let mapleader="," " Set leader to ,
"let maplocalleader = "\\"



"------------
" デバッガ(required: pip install unittest2 mock)
"------------



"------------
" ビルド・実行
"------------
call dein#add('Shougo/vimproc.vim') " vimproc(非同期処理)
call dein#add('thinca/vim-quickrun') " quickrun
let g:quickrun_config = {
\   "_" : {
\       "hook/close_quickfix/enable_exit" : 1,
\       "hook/close_buffer/enable_failure" : 1,
\       "hook/close_buffer/enable_empty_data" : 1,
\       "outputter" : "multi:buffer:quickfix",
\       "outputter/buffer/split" : ":5sp",
\       "runner" : "vimproc",
\       "runner/vimproc/updatetime" : 40,
\       "outputter/buffer/close_on_empty": 0,
\   }
\}

" qで抜ける
autocmd! FileType qf nnoremap <silent><buffer>q :quit<CR>


"------------
" tmux連携
"------------
"call dein#add('benmills/vimux')
"call dein#add('christoomey/vim-tmux-navigator')  " 画面移動キーをvimとtmuxと共通化
"nnoremap <C-t> <Nop> " tmuxと干渉するため無効化



"=========================================================================
" その他機能
"=========================================================================
call dein#add('vimwiki/vimwiki')  "vim上のwiki
call dein#add('itchyny/calendar.vim')  "カレンダー
let g:calendar_google_calendar = 1
let g:calendar_google_task = 1



"=========================================================================
" dein終了
"=========================================================================
call dein#end()



"=========================================================================
" ショートカット関連
"=========================================================================
" Qは使わないので無効
nmap Q <Nop>

" H,Lで行頭、行末に移動
noremap H  ^
noremap L  $

" Select entire buffer
nnoremap vy ggVG

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

" カーソル下の単語を * で検索
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>

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
" <CR> : close popup and save indent.
" <TAB>: completion.
" Close popup by <Space>.
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><Space> pumvisible() ? neocomplete#close_popup()."\<Space>" : "\<Space>"
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()



"-----------------------
"Ctrlを使うショートカット
"-----------------------
" コマンドラインの一致検索
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" neosnippet関連
imap <C-s> <Plug>(neosnippet_expand_or_jump)
smap <C-s> <Plug>(neosnippet_expand_or_jump)



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
nnoremap sqh <C-w>h:q<CR>
nnoremap sqj <C-w>j:q<CR>
nnoremap sqk <C-w>k:q<CR>
nnoremap sql <C-w>l:q<CR>

" ノーマルモードで行挿入
nnoremap so o<Esc>k
nnoremap sO O<Esc>j

" s+-=*で行を挿入
nnoremap <silent> s- :t.\|s/./-/\|:nohls<cr>
nnoremap <silent> s= :t.\|s/./=/\|:nohls<cr>
nnoremap <silent> s* :t.\|s/./*/\|:nohls<cr>

" denite関連
nnoremap [denite] <Nop>
nnoremap <silent> sr :<C-u>DeniteWithBufferDir file<CR>
nnoremap <silent> sb :<C-u>Denite -toggle -direction=dynamicbottom buffer<CR>
nnoremap <silent> sm :<C-u>Denite -toggle -direction=dynamicbottom bookmark<CR>
nnoremap <silent> sf :<C-u>Denite -toggle -direction=dynamicbottom file_mru<CR>
nnoremap <silent> ,sr :UniteResume<CR>
" 選択した文字列をunite-grep -> https://github.com/shingokatsushima/dotfiles/blob/master/.vimrc
vnoremap /g y:Unite grep::-iHRn:<C-R>=escape(@", '\\.*$^[]')<CR><CR>

" 補完
"nnoremap <C-Space> <Nop>
"imap <C-l> <C-Space>

" open-browser
nmap sw <Plug>(openbrowser-smart-search)
vmap sw <Plug>(openbrowser-smart-search)

" easymotion
map ss <Plug>(easymotion-s2)
map st <Plug>(easymotion-t2)

" easyalign
xmap sa <Plug>(EasyAlign)
nmap sa <Plug>(EasyAlign)



"-----------------------
" tで始まるショートカット
"-----------------------
" tabbar関連
nnoremap [Tag] <Nop>
" nmap t [Tag]
" map <silent> [Tag]c :tablast <bar> tabnew<CR>
" map <silent> [Tag]x :tabclose<CR>
" map <silent> [Tag]n :tabnext<CR>
" map <silent> [Tag]p :tabprevious<CR>
" " t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ
" for n in range(1, 9)
"   execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
" endfor



"-----------------------
" ,で始まるショートカット
"-----------------------
" vimfiler
nnoremap <buffer> <leader>l :VimFiler -split -winwidth=30 -toggle -no-quit<CR>

" vimshell
nnoremap <buffer> <leader>s :VimShell -split-command=15sp -toggle<CR><C-[><CR>
nnoremap <buffer> <leader>p :VimShell -split-command=15sp -toggle<CR>ipython<CR><C-[><CR>
vnoremap <buffer> <leader>r :VimShellSendString<CR>
nnoremap <buffer> <leader>r <S-v>:VimShellSendString<CR>

" quickrun
nnoremap <buffer> <leader>q :QuickRun<CR>

"-----------------------
" ビルド・実行
"-----------------------
nnoremap <F5> <Nop>



"=========================================================================
" ローカルの設定ファイルをロード
"=========================================================================
if filereadable(expand('~//.vimrc.local'))
    source ~/.vimrc.local
endif



"=========================================================================
" finalize
"=========================================================================
filetype plugin indent on

let &cpo = s:cpo_save "cpoを元に戻す
unlet s:cpo_save

