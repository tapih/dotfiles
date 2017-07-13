"=========================================================================
" initialize
"=========================================================================
" TODO
" コマンドをターミナルに飛ばす
" nerdtree
" ステータスライン
" deinをちゃんとかく
let s:cpo_save = &cpo "compatible optionsの値を退避
set cpo&vim "vimモードに
"=========================================================================
" 基本設定
"=========================================================================
" ファイルタイプ関連を一旦切っておく
filetype off
filetype plugin indent off

" 最後にファイルを閉じた場所
augroup vimrcEx
    autocmd!
    autocmd BufRead * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif
augroup END

" syntax on " シンタックス有効に
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
set iskeyword-=/ " /を区切り文字に追加
set conceallevel=0 " 特殊文字を隠さない

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

call dein#add('rking/ag.vim')  " 高速な検索
call denite#custom#var('file_rec', 'command', ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'default_opts', ['--follow', '--no-group', '--no-color'])



"=========================================================================
" コード入力補助
"=========================================================================
" call dein#add('kana/vim-operator-replace') " ヤンクで置き換え
call dein#add('tpope/vim-repeat') " 独自ショートカットもひとまとまりで'.u'できる
call dein#add('tpope/vim-speeddating') " C-a, C-xを日付に拡張
call dein#add('terryma/vim-expand-region') " 範囲選択をショートカットで
call dein#add('coderifous/textobj-word-column.vim') " 矩形選択を拡張
call dein#add('tpope/vim-surround')  " 括弧などのブロック文字を簡単に変更
call dein#add('cohama/lexima.vim')  " 自動でカッコなどを閉じる
call dein#add('aperezdc/vim-template')  " テンプレートからファイル作成
call dein#add('junegunn/vim-easy-align')  " テキスト整形
call dein#add('h1mesuke/vim-alignta') " テキスト自動整形
call dein#add('mattn/emmet-vim')  " htmlタグ打ちショートカット
call dein#add('bronson/vim-trailing-whitespace')  " 全角スペースをハイライト

" snippet
call dein#add('Shougo/neosnippet')
call dein#add('Shougo/neosnippet-snippets')
let g:neosnippet#enable_conceal_markers = 0
" call dein#add('honza/vim-snippets')
" let g:neosnippet#enable_snipmate_compatibility = 1
" let g:neosnippet#disable_runtime_snippets = {'_' : 1}
" let g:neosnippet#snippets_directory = '~/.vim/dein/repos/github.com/vim-snippets/snippets'

" choosewin
call dein#add('t9md/vim-choosewin')  " ウィンドウ選択
let g:choosewin_label = 'fjsldka;'

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
let g:deoplete#auto_completion_start_length = 2
let g:deoplete#sources#syntax#min_keyword_length = 3

let g:neocomplete#enable_auto_close_preview = 0 " preview windowを閉じない
autocmd InsertLeave * silent! pclose! " インサートから抜けたらpreview windowを閉じる

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

" 構文チェック
call dein#add('w0rp/ale')
let g:ale_sign_column_always = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_statusline_format = ['E%d', 'W%d', '']

"=========================================================================
" 各言語設定
"=========================================================================
"--------
" python
"--------
" python2ではコーディングせずsystemのものを使う
" python3はpyenvのものを使う
let g:my_python_path = '/usr/bin/python'
let g:my_python3_path = $PYENV_ROOT . '/shims/python'
let g:python_host_prog = g:my_python_path
let g:python3_host_prog = g:my_python3_path

call dein#add('neovim/python-client')
call dein#add('hynek/vim-python-pep8-indent')  " pep8に準拠したインデント
call dein#add('zchee/deoplete-jedi')  " completion
let g:deoplete#sources#jedi#python_path = g:my_python3_path



"------------
" JavaScript + AltJS
"------------
" call dein#add('pangloss/vim-javascript')  " js
" call dein#add('carlitux/deoplete-ternjs')
" call dein#add('leafgarland/typescript-vim')  "ts
" call dein#add('Quramy/tsuquyomi')
" call dein#add('elzr/vim-json')  " json
" let g:vim_json_syntax_conceal = 0
" 
" call dein#add('hail2u/vim-css3-syntax')  " css
" call dein#add('othree/html5.vim')  " html5



"------------
" C++
"------------
" call dein#add('zchee/deoplete-clang')
" call dein#add('dbgx/lldb.nvim')



"------------
" Markdown
"------------
" call dein#add('plasticboy/vim-markdown')
" call dein#add('kannokanno/previm')  " md preview
call dein#add('vim-scripts/open-browser.vim')  "ブラウザに飛ばす
au BufRead,BufNewFile *.md set filetype=markdown



"------------
" その他言語
"------------
call dein#add('Shougo/neco-vim') " vim
" call dein#add('vim-scripts/dbext.vim')  "sql
" call dein#add('vim-scripts/Vim-R-plugin')  " R



"=========================================================================
" git
"=========================================================================
augroup DisableGitFold
    autocmd!
    autocmd FileType git setlocal nofoldenable foldlevel=0
augroup END

call dein#add('cohama/agit.vim') " gitをvimコマンドから利用
call dein#add('tpope/vim-fugitive') " vimからgitコマンドをたたく
call dein#add('airblade/vim-gitgutter') " 差分のある行にマークをつける
call dein#add('rhysd/committia.vim') " commit -vのログ入力補助
call dein#add('idanarye/vim-merginal')

let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '->'
let g:gitgutter_sign_removed = 'x'

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
call dein#add('itchyny/lightline.vim')
let g:lightline = {
        \ 'colorscheme': 'wombat',
        \ 'mode_map': {'c': 'NORMAL'},
        \ 'active': {
        \   'left': [
        \     ['mode', 'paste'],
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
" ファイラ・タグ関連（画面横）
"-----------------------------------
call dein#add('majutsushi/tagbar')
call dein#add('soramugi/auto-ctags.vim')
let g:auto_ctags = 0
function! s:auto_ctags_toggle()
    if g:auto_ctags == 0
        let g:auto_ctags = 1
    else
        let g:auto_ctags = 0
    endif
    if g:auto_ctags == 1
        echo "Enable AutoCtags"
    else
        echo "Disable AutoCtags"
    endif
endfunction
command! AutoCtagsToggle call <SID>auto_ctags_toggle()



call dein#add('scrooloose/nerdtree')
call dein#add('Xuyuanp/nerdtree-git-plugin')
let NERDTreeIgnore = ['.[oa]$', '.(so)$', '.(tgz|gz|zip)$' ]
let NERDTreeShowHidden = 1
" http://qiita.com/ymiyamae/items/3fa77d85163fb734b359
" ファイルの方にカーソルを向ける
function s:MoveToFileAtStart()
  call feedkeys("\<Space>")
  call feedkeys("\s")
  call feedkeys("\l")
endfunction

" 他のバッファをすべて閉じた時にNERDTreeが開いていたらNERDTreeも一緒に閉じる。
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" 起動時に両方開く
autocmd VimEnter * Tagbar
autocmd VimEnter * NERDTree | call s:MoveToFileAtStart()



"------------
" ビルド・実行
"------------
call dein#add('kassio/neoterm')
call dein#add('thinca/vim-quickrun') " quickrun
let g:quickrun_config = {
\   "_" : {
\       "hook/close_quickfix/enable_exit" : 1,
\       "hook/close_buffer/enable_failure" : 1,
\       "hook/close_buffer/enable_empty_data" : 1,
\       "outputter" : "error",
\       "oukputter/error/success" : "buffer",
\       "outputter/error/error" : "quickfix",
\       "outputter/buffer/split" : ":rightbelow 10sp",
\       "outputter/buffer/close_on_empty": 1,
\   }
\}

"=========================================================================
" dein終了
"=========================================================================
call dein#end()



"=========================================================================
" ショートカット関連
"=========================================================================
" マクロ
nnoremap Q q

" qでウィンドウ閉じる
nnoremap q :<C-u>q<CR>

" スペースなし連結
nnoremap K gJ

" タグは使わない
nnoremap [Tag] <Nop>

" H,Lで行頭、行末に移動
nnoremap H  ^
nnoremap L  $
vnoremap H  ^
vnoremap L  $

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

" カーソル下の単語を * で検索
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>

" enterで保存
nnoremap <CR> :<C-u>w<CR>

" vim-choosewin起動
nmap - <Plug>(choosewin)

" yankround関連
nmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap gp <Plug>(yankround-gp)
nmap gP <Plug>(yankround-gP)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)

" deoplete関連
inoremap <expr><C-g> deoplete#undo_completion()
inoremap <expr><C-l> deoplete#complete_common_string()
" inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><CR> pumvisible() ? deoplete#close_popup()."\<CR>" : "\<CR>"
inoremap <expr><Space> pumvisible() ? deoplete#close_popup()."\<Space>" : "\<Space>"
inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> deoplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y> deoplete#close_popup()
inoremap <expr><C-e> deoplete#cancel_popup()

" neosnippet関連
imap <expr><TAB> neosnippet#expandable() <Bar><bar> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable() <Bar><bar> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"



"-----------------------
"Ctrlを使うショートカット
"-----------------------
" コマンドラインの一致検索
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" neosnippet関連
imap <C-s> <Plug>(neosnippet_expand_or_jump)
smap <C-s> <Plug>(neosnippet_expand_or_jump)
xmap <C-s> <Plug>(neosnippet_expand_target)

" 縦にyank
" vnoremap <C-p> I<C-r>"<ESC><ESC>

" 候補送り
nmap <silent> <C-j> <Plug>(ale_next_wrap)
nmap <silent> <C-k> <Plug>(ale_previous_wrap)

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
nnoremap <silent> sqh <C-w>h:q<CR>
nnoremap <silent> sqj <C-w>j:q<CR>
nnoremap <silent> sqk <C-w>k:q<CR>
nnoremap <silent> sql <C-w>l:q<CR>

" ノーマルモードで行挿入
nnoremap <silent> so :<C-u>for i in range(1, v:count1) \| call append(line('.'),   '') \| endfor \| silent! call repeat#set("<Space>o", v:count1)<CR>
nnoremap <silent> sO :<C-u>for i in range(1, v:count1) \| call append(line('.')-1, '') \| endfor \| silent! call repeat#set("<Space>O", v:count1)<CR>

" denite関連
nnoremap [denite] <Nop>
nnoremap <silent> sr :<C-u>DeniteWithBufferDir file<CR>
nnoremap <silent> sb :<C-u>Denite -toggle -direction=dynamicbottom buffer<CR>
nnoremap <silent> sm :<C-u>Denite -toggle -direction=dynamicbottom bookmark<CR>
nnoremap <silent> sf :<C-u>Denite -toggle -direction=dynamicbottom file_mru<CR>
nnoremap <silent> ,sr :UniteResume<CR>
" 選択した文字列をdenite-grep -> https://github.com/shingokatsushima/dotfiles/blob/master/.vimrc
vnoremap /g y:Denite grep::-iHRn:<C-R>=escape(@", '\\.*$^[]')<CR><CR>

" open-browser
nmap sw <Plug>(openbrowser-smart-search)
vmap sw <Plug>(openbrowser-smart-search)

" easymotion
map ss <Plug>(easymotion-s2)
map st <Plug>(easymotion-t2)

" easyalign
xmap sa <Plug>(EasyAlign)
nmap sa <Plug>(EasyAlign)

" expand-region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

"-----------------------
" Git
"-----------------------
" autocmd FileType gitv setlocal iskeyword+=/,-,.  " 現在のカーソル位置にあるブランチ名を取得してログ上でブランチにcheckout
" nnoremap <silent><buffer> co :<C-u>Gitv checkout <C-r><C-w><CR>
" nnoremap <buffer> <Space>rb :<C-u>Gitv rebase <C-r>=GitvGetCurrentHash()<CR><Space>
" nnoremap <buffer> <Space>rv :<C-u>Gitv revert <C-r>=GitvGetCurrentHash()<CR><CR>
" nnoremap <buffer> <Space>cp :<C-u>Gitv cherry-pick <C-r>=GitvGetCurrentHash()<CR><CR>
" nnoremap <buffer> <Space>rh :<C-u>Gitv reset --hard <C-r>=GitvGetCurrentHash()<CR>
" nnoremap <silent><buffer> t :<C-u>windo call <SID>ToggleGitFolding()<CR>1<C-w>w



"-----------------------
" leaderで始まるショートカット
"-----------------------
let mapleader="\<Space>"

" autoctags
nnoremap <buffer> <leader>c :AutoCtagsToggle<CR>
" quickrun
nnoremap <buffer> <leader>r :QuickRun<CR>
" kill quickfix
nnoremap <silent> <buffer> <Leader>q :<C-u>bw! \[quickrun\ output\]<CR>
" nerdtree
nnoremap <silent> <buffer> <leader>f :NERDTreeToggle<CR>
" tagbar
nnoremap <silent> <buffer> <leader>t :TagbarToggle<CR>

"-----------------------
" tで始まるショートカット
"-----------------------
" tabbar関連
" nmap t [Tag]
" map <silent> [Tag]c :tablast <bar> tabnew<CR>
" map <silent> [Tag]x :tabclose<CR>
" map <silent> [Tag]n :tabnext<CR>
" map <silent> [Tag]p :tabprevious<CR>
" " t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ
" for n in range(1, 9)
"   execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
" endfor



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

