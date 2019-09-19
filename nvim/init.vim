" TODO
" denite grep
"=========================================================================
" 共通設定
"=========================================================================
let s:cpo_save = &cpoptions "compatible optionsの値を退避
set cpoptions&vim "vimモードに

"-----------------------
" 基本設定
"-----------------------
" ファイルタイプ関連を一旦切っておく
filetype off
filetype plugin indent off

syntax on " シンタックス有効に
set encoding=utf-8 " エンコーディング
set number     " 行番号の表示
set scrolloff=10 " scroll offset
" set cursorline   " カーソルライン横
" autocmd InsertEnter,InsertLeave * set cursorline!
" set cursorcolumn " カーソルライン横（重いので無効)
" set wrap       " 文を折り返す
set splitbelow " spで下に分割
set splitright " vsで右に分割
set ruler      " カーソル位置を下のバーに表示
set background=dark
set showmatch  " カーソル下の対応するカッコをハイライト
set lazyredraw " マクロなどの途中経過を描写しない
set foldmethod=manual " 手動でグルーピング
set infercase  " 補完時に大文字と小文字を区別しない
set backspace=eol,indent,start " 改行等を削除可能に
set virtualedit=block "C-vの矩形選択で行末より後ろもカーソルを置ける
set smarttab   " 行頭はタブをスペースとして扱う
set expandtab  " タブをスペースで代用
set softtabstop=0 "タブ入力時のスペース挿入数(0=tabstopと同じ)
set showcmd    "ステータスラインにコマンドを表示
set hlsearch   " 検索文字列をハイライト
set nowrapscan " 検索で文頭にループしない
set ignorecase smartcase " 基本ignorecaseだが大文字小文字が混在しているときは普通に検索
set fileformats=unix,dos,mac  " 改行コードの自動判別。左が優先
set ambiwidth=double " □といった文字が崩れる問題の解決

" indentation
set autoindent " 自動インデント
set shiftwidth=4 " インデントは半角スペース4つ分
set tabstop=4  " タブは半角スペース4つ分で表示
autocmd FileType yaml setlocal sw=2 sts=2 ts=2 et

" ヤンクバッファを共有
set clipboard^=unnamedplus

set nobackup nowritebackup " backup file作らない
set noswapfile " swap file作らない
set hidden " バッファを移動する際に保存しなくて済む
set colorcolumn=80 " 80行目に線
set list listchars=tab:>-,trail:-,nbsp:%,eol:$ " 不可視文字を表示
set iskeyword-=/ " /を区切り文字に追加
set conceallevel=0 " 特殊文字を隠さない
" if has('conceal')
"     set conceallevel=2 concealcursor=niv
" endif

let g:python_pyenv_global = $PYENV_ROOT.'/shims/python'
let g:python_host_prog = $PYENV_ROOT.'/versions/neovim2/bin/python'
let g:python3_host_prog = $PYENV_ROOT.'/versions/neovim3/bin/python'

" help windowリサイズ
augroup ResizeHelpWin
    autocmd!
    autocmd FileType help resize 12
augroup END

" インサートから抜けたらpreview windowを閉じる
augroup PlugAutoCmd
    autocmd!
    autocmd InsertLeave * silent! pclose!
augroup END

" 最後にファイルを閉じた場所で開く
augroup OpenAtLastClosed
    autocmd!
    autocmd BufRead * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif
augroup END

" コメント行を改行したときに自動でコメントアウト記号をいれない
augroup AutoCompleteOff
    autocmd!
    autocmd BufEnter * setlocal formatoptions-=r
    autocmd BufEnter * setlocal formatoptions-=o
augroup END

" 編集用のバッファをすべて閉じた時に他のウィンドウ（help, terminalなど）も閉じる
function! AutoCloseBuf()
    if len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
        :q
    else
        :bd
    endif
endfunction


" バッファが一つならウィンドウを閉じる
function! GetNumBufs()
    let i = bufnr('$')
    let j = 0
    while i >= 1
        if buflisted(i)
            let j+=1
        endif
        let i-=1
    endwhile
    return j
endfunction

function! CloseBufOrWindow()
    if GetNumBufs() > 1
        bdelete
    else
        quit
    endif
endfunction




"=========================================================================
" 外部プラグイン
"=========================================================================
if has('nvim')
    if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
        silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
            \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif

    let g:plug_dir = expand('~/.cache/plug')
    call plug#begin(g:plug_dir)

    "-----------------------
    " コード入力補助
    "-----------------------
    Plug 'morhetz/gruvbox' " colorsheme
    Plug 'tomtom/tcomment_vim' " 一括コメントアウト追加/削除
    Plug 'cohama/lexima.vim', {'on': []}  " 自動でカッコなどを閉じる
    Plug 'coderifous/textobj-word-column.vim', {'on': []} " 矩形選択を拡張
    Plug 'bronson/vim-trailing-whitespace', {'on': []}  " 全角スペースをハイライト
    Plug 'ConradIrwin/vim-bracketed-paste', {'on': []} " ペーストでインデントが崩れない
    Plug 'kana/vim-textobj-user', {'on': []} " textobj設定
    Plug 'Yggdroot/indentLine', {'on': []} " インデントを見やすく
    Plug 'tpope/vim-repeat', {'on': []} " 独自ショートカットも'.u'できる
    Plug 'tpope/vim-surround', {'on': []}  " 括弧などのブロック文字を簡単に変更
    Plug 'tpope/vim-speeddating', {'on': []} " C-a, C-xを日付に拡張
    Plug 'junegunn/vim-easy-align', {'on': 'EasyAlign'} " テキスト整形
    Plug 'terryma/vim-expand-region' " 範囲選択をショートカットで
    Plug 'AndrewRadev/switch.vim', {'on': 'Switch'} "  toggle true false
    Plug 'jiangmiao/auto-pairs' " automatically delete paired blacket
    Plug 'SirVer/ultisnips', {'on': []} " snippet engine
    Plug 'honza/vim-snippets', {'on': []} " snippets

    " 画面内の任意の場所にジャンプ
    Plug 'easymotion/vim-easymotion', {'on': []}
    let g:EasyMotion_keys = 'fjdkslaureiwoqpvncm' " ジャンプ用のタグに使う文字の優先順位
    let g:EasyMotion_startofline = 0 " keep cursor column when JK motion

    " 任意のバッファにジャンプ
    Plug 't9md/vim-choosewin'  " ウィンドウ選択
    let g:choosewin_label = 'fjsldka;'



    " ---
    " fzf
    " ---
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'}
    Plug 'junegunn/fzf.vim'
    let g:fzf_layout = { 'right': '~30%' }
    let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
    command! -bang -nargs=* GGrep
        \ call fzf#vim#grep(
        \   'git grep --line-number '.shellescape(<q-args>), 0,
        \   { 'dir': systemlist('git rev-parse --show-toplevel')[0]  }, <bang>0)



    " --------
    " lsp 関連
    " --------
    Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install() }}
    inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>""

    function! s:show_documentation()
      if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
      else
        call CocAction('doHover')
      endif
    endfunction

    " Highlight symbol under cursor on CursorHold
    autocmd CursorHold * silent call CocActionAsync('highlight')

    " Use `:Format` to format current buffer
    command! -nargs=0 Format :call CocAction('format')



    " ---------
    " lint 関連
    " ---------
    Plug 'prettier/vim-prettier', {
      \ 'do': 'npm install',
      \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'],
      \ }
    Plug 'w0rp/ale'
    let g:ale_linters = {
        \ 'html': ['prettier'],
        \ 'css': ['prettier'],
        \ 'scss': ['prettier'],
        \ 'json': ['prettier'],
        \ 'yaml': ['prettier'],
        \ 'javascript': ['eslint'],
        \ 'typescript': ['tslint'],
        \ 'python': ['yapf', 'autopep8'],
        \ 'go': ['goimports', 'gofmt'],
        \ 'rust': ['rustfmt'],
        \ 'cpp': ['clangd'],
        \ 'c': ['clangd'],
        \}
    let g:ale_go_langserver_executable = 'gopls'
    let g:ale_fixers = g:ale_linters
    let g:ale_lint_on_text_changed = 0
    let g:ale_lint_on_save = 1 " 保存したらチェック
    let g:ale_set_loclist = 0
    let g:ale_set_quickfix = 1 " quickfixに表示
    let g:ale_sign_column_always = 1 " aleコラムを常に表示
    let g:ale_sign_error = '✔︎'
    let g:ale_sign_warning = '⚠'
    let g:ale_statusline_format = ['✔︎ %d', '⚠ %d', '']



    "-------------
    " その他言語別
    "-------------
    Plug 'sheerun/vim-polyglot'
    Plug 'mattn/emmet-vim', {'for': 'html'}
    Plug 'alvan/vim-closetag', {'for': 'html'}
    Plug 'hail2u/vim-css3-syntax', {'for': 'css'}
    Plug 'vim-scripts/a.vim', {'for': 'c++'}
    Plug 'fatih/vim-go', {'for': 'go'}
    Plug 'hynek/vim-python-pep8-indent', {'for': 'python'}  " pep8に準拠したインデント
    Plug 'iamcco/markdown-preview.nvim', {'for': 'markdown'}
    let g:user_emmet_leader_key='<C-q>'
    let g:go_fmt_command = 'goimports'
    let g:go_bin_path = $GOPATH . '/bin'



    "=========================================================================
    " git
    "=========================================================================
    Plug 'tpope/vim-fugitive', {'on': []}
    Plug 'airblade/vim-gitgutter', {'on': []} " 差分のある行にマークをつける
    Plug 'cohama/agit.vim', {'on': 'Agit'} " improved gitv
    Plug 'rhysd/committia.vim' " commitの画面をリッチに
    let g:gitgutter_sign_added = '✚'
    let g:gitgutter_sign_modified = '✹'
    let g:gitgutter_sign_removed = '✖'
    let g:gitgutter_sign_removed_first_line = '✖'
    let g:gitgutter_sign_modified_removed = '✖'

    augroup DisableGitFold
        autocmd!
        autocmd FileType git setlocal nofoldenable foldlevel=0
    augroup END

    " enable update on every change
    function! GlobalChangedLines(ex_cmd)
      for hunk in GitGutterGetHunks()
        for lnum in range(hunk[2], hunk[2]+hunk[3]-1)
          let cursor = getcurpos()
          silent! execute lnum.a:ex_cmd
          call setpos('.', cursor)
        endfor
      endfor
    endfunction
    command -nargs=1 Glines call GlobalChangedLines(<q-args>)



    "=========================================================================
    " ウィジェット関連
    "=========================================================================
    Plug 'itchyny/lightline.vim' " ステータスライン(画面下
    Plug 'ap/vim-buftabline' " バッファ表示(画面下
    Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'} " ファイルツリー（画面右）
    Plug 'Xuyuanp/nerdtree-git-plugin', {'on': 'NERDTreeToggle'} " git gutter
    " Plug 'majutsushi/tagbar', {'on': 'TagBarToggle'} " タグ関連(画面右

    let g:lightline = {
        \ 'colorscheme': 'wombat',
        \ 'active': {
        \   'left': [
        \     ['mode', 'paste'],
        \     ['filename'], ['fugitive', 'gitgutter', 'ale'],
        \   ],
        \   'right': [
        \     ['lineinfo'], ['percent'],
        \     ['charcode', 'fileformat', 'fileencoding', 'filetype'],
        \   ]
        \ },
        \ 'component_function': {
        \   'mode': 'MyMode',
        \   'filename': 'MyFileName',
        \   'fugitive': 'MyFugitive',
        \   'ale': 'ALEGetStatusLine',
        \   'gitgutter': 'MyGitGutter',
        \   'fileformat': 'MyFileFormat',
        \   'fileencoding': 'MyFileEncoding',
        \   'filetype': 'MyFileType',
        \   'charcode': 'MyCharCode',
        \ },
        \ 'separator': {'left': '>>', 'right': '|'},
        \ 'subseparator': {'left': '|', 'right': '|'}
        \ }

    function! MyModified()
        return &ft =~ 'help\|nerdtree\|gundo\|tagbar\|terminal' ? '' : &modified ? '+' : &modifiable ? '' : '-'
    endfunction

    function! MyReadOnly()
        return &ft !~? 'help\|vimfiler\|gundo' && &ro ? '|' : ''
    endfunction

    function! MyFileName()
        let fname = expand('%p:t')
        return  &ft == 'nerdtree' ? 'NERDTree' :
                    \ &ft == 'tagbar' ? 'TagBar' :
                    \ &ft == 'denite' ? denite#get_status_string() :
                    \ ('' != MyReadOnly() ? MyReadOnly() . ' ' : '') .
                    \ ('' != fname ? fname : '[No Name]') .
                    \ ('' != MyModified() ? ' ' . MyModified() : '')
    endfunction

    function! MyFugitive()
        try
            if &ft !~? 'help\|nerdtree\|gundo\|tagbar\|terminal' && exists('*fugitive#head')
                let _ = fugitive#head()
                return strlen(_) ? _ : ''
            endif
        catch
        endtry
        return ''
    endfunction

    function! MyGitGutter()
        if ! exists('*GitGutterGetHunkSummary')
                    \ || ! get(g:, 'gitgutter_enabled', 0)
                    \ || winwidth('.') <= 90
            return ''
        endif
        let symbols = [
                    \ g:gitgutter_sign_added . ':',
                    \ g:gitgutter_sign_modified . ':',
                    \ g:gitgutter_sign_removed . ':'
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

    let NERDTreeIgnore = ['.[oa]$', '.(so)$', '.(tgz|gz|zip)$', '\~$']
    let NERDTreeShowHidden = 1
    let g:NERDTreeWinPos = "right"
    let g:NERDTreeIndicatorMapCustom = {
                \ "Modified"  : "✹",
                \ "Staged"    : "✚",
                \ "Untracked" : "✭",
                \ "Renamed"   : "➜",
                \ "Unmerged"  : "═",
                \ "Deleted"   : "✖",
                \ "Dirty"     : "✗",
                \ "Clean"     : "✔︎",
                \ 'Ignored'   : '☒',
                \ "Unknown"   : "?"
                \ }

    " auto close nerdtree when close window and there is only one window at that time
    augroup NERDTreeAutoClose
        autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    augroup END

    call plug#end()

    " ---------
    " lazy load
    " ---------
    " after first insert
    augroup load_us_insert
        autocmd!
        autocmd InsertEnter * call plug#load(
        \ 'ultisnips',
        \ 'vim-snippets',
        \ 'lexima.vim',
        \ ) | autocmd! load_us_insert
    augroup END

    " after certain period
    function! s:load_plug(timer)
        call plug#load(
        \ 'textobj-word-column.vim',
        \ 'vim-trailing-whitespace',
        \ 'vim-bracketed-paste',
        \ 'vim-textobj-user',
        \ 'indentLine',
        \ 'vim-repeat',
        \ 'vim-surround',
        \ 'vim-speeddating',
        \ 'vim-fugitive',
        \ 'vim-gitgutter',
        \ 'vim-easymotion',
        \ )
    endfunction

    call timer_start(100, function("s:load_plug"))

    colorscheme gruvbox " setting color

    " ローカルの設定を反映
    if filereadable(expand('~/.nvimrc.local'))
        source ~/.nvimrc.local
    endif
endif

"-----------------------
" コマンド
"-----------------------
" ; : 入れ替え
nnoremap ; :
vnoremap ; :
nnoremap : ;
vnoremap : ;

" 検索時に/をエスケープしない
cnoremap <expr> / (getcmdtype() == '/') ? '\/' : '/'

" マクロ
nnoremap q <Nop>

" 閉じる
nnoremap <silent> q :<C-u>call CloseBufOrWindow()<CR>
nnoremap <silent> Q :q!<CR>

" タグは使わない
nnoremap [Tag] <Nop>

" 修正した場所に飛ぶ
nnoremap <C-J> g;
nnoremap <C-K> g,

" H,Lで行頭、行末に移動
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L $

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
nnoremap <C-r> <Nop>
nnoremap U <C-r>

" j, k による移動を折り返されたテキストでも自然に振る舞うように変更
nnoremap j gj
nnoremap k gk

" カーソル下の単語を * で検索
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>

" enterで保存
nnoremap <CR> :<C-u>w<CR>

"-----------------------
" Ctrlを使うショートカット
"-----------------------
" コマンドラインの一致検索
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" C-y でも visual mode に
nnoremap <C-y> <C-v>

" coc
nnoremap <silent> <C-d> :call <SID>show_documentation()<CR>
inoremap <silent> <C-d> <ESC>:call <SID>show_documentation()<CR>a
inoremap <silent><expr> <C-Space> coc#refresh()

" expand region
vnoremap <C-v> <Plug>(expand_region_shrink)
vnoremap v <Plug>(expand_region_expand)

" fzf
nnoremap <silent> <C-i> :<C-u>Buffers<CR>

"-----------------------
" sで始まるショートカット
"-----------------------
" sを無効に
nnoremap s <Nop>
vnoremap s <Nop>

" s+-\ で画面分割
nnoremap s- :<C-u>sp<CR>
nnoremap s\ :<C-u>vs<CR>

" s+hjklでウィンドウを削除
nnoremap <silent> sh <C-w>h:q<CR>
nnoremap <silent> sj <C-w>j:q<CR>
nnoremap <silent> sk <C-w>k:q<CR>
nnoremap <silent> sl <C-w>l:q<CR>

" ノーマルモードで行挿入
nnoremap <silent> so :<C-u>for i in range(1, v:count1) \| call append(line('.'),   '') \| endfor \| silent! call repeat#set("<Space>o", v:count1)<CR>
nnoremap <silent> sO :<C-u>for i in range(1, v:count1) \| call append(line('.')-1, '') \| endfor \| silent! call repeat#set("<Space>O", v:count1)<CR>

" for plugins
if has('nvim')
    "easymotion
    nmap ss <Plug>(easymotion-s2)
    nmap st <Plug>(easymotion-t2)

    " choosewin
    nnoremap sm :<C-u>ChooseWin<CR>

    " ale
    nmap <silent> sn <Plug>(ale_previous_wrap)
    nmap <silent> sp <Plug>(ale_next_wrap)
    nnoremap <silent> si :<C-u>ALEFix<CR>

    " switch
    nnoremap sw :<C-u>Switch<CR>

    " easyalign
    xnoremap sa <Plug>(EasyAlign)
    nnoremap sa <Plug>(EasyAlign)
endif

"-----------------------
" gで始まるショートカット
"-----------------------
if has('nvim')
    nnoremap gj <Nop>
    nnoremap gk <Nop>
    nnoremap gh <Nop>
    nnoremap gl <Nop>

    " fzf
    nnoremap <silent> gb :<C-u>GFiles<CR>
    nnoremap <silent> gh :<C-u>History<CR>
    nnoremap <silent> gf :<C-u>BLines<CR>
    nnoremap <silent> gF :<C-u>GGrep<CR>
    nnoremap <silent> gm :<C-u>BCommits<CR>

    " coc navigate diagnostics
    nmap <silent> gp <Plug>(coc-diagnostic-prev)
    nmap <silent> gn <Plug>(coc-diagnostic-next)

    " coc Remap keys for gotos
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)"
endif

"-----------------------
" tで始まるショートカット
"-----------------------
if has('nvim')
    nnoremap t <Nop>

    " next buffer
    nnoremap <silent> tj :<C-u>bprev<CR>
    nnoremap <silent> tk :<C-u>bnext<CR>

    " nnoremap <silent> tn :<C-u>NERDTreeToggle<CR>:wincmd p<CR>
    nnoremap <silent> tn :<C-u>NERDTreeToggle<CR>
    nnoremap <silent> tb :<C-u>TagbarToggle<CR>
    nnoremap <silent> tl :<C-u>ALEToggle<CR>
    nnoremap <silent> tg :<C-u>GitGutterLineHighlightsToggle<CR>
endif

"=========================================================================
" finalize
"=========================================================================
filetype plugin indent on

let &cpo = s:cpo_save "cpoを元に戻す
unlet s:cpo_save

" ローカルの設定を反映
if filereadable(expand('~/.vimrc.local'))
    source ~/.vimrc.local
endif
