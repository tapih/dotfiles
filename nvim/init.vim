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

let g:python_host_prog = $PYENV_ROOT.'/versions/neovim2/bin/python'
let g:python3_host_prog = $PYENV_ROOT.'/versions/neovim3/bin/python'

" help windowリサイズ
augroup ResizeHelpWin
    autocmd!
    autocmd FileType help resize 12
augroup END

" 最後にファイルを閉じた場所で開く
augroup OpenAtLastClosed
    autocmd!
    autocmd BufRead * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif
augroup END

" コメント行を改行したときに自動でコメントアウト記号をいれない
augroup auto_complete_off
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

function! CloseCurrBuf()
    let n = bufnr('%')
    bdelete n
endfunction

function! CloseBufOrWin()
    if GetNumBufs() > 1
        call CloseCurrBuf()
    else
        quit
    endif
endfunction

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
nnoremap Q q

" 閉じる
nnoremap <silent> q :<C-u>call CloseBufOrWin()<CR>

" タグは使わない
nnoremap [Tag] <Nop>

" 修正した場所に飛ぶ
nnoremap <C-J> g;
nnoremap <C-K> g,

" H,Lで行頭、行末に移動
nnoremap H  ^
nnoremap L  $
vnoremap H  ^
vnoremap L  $

" Select entire buffer
nnoremap vy ggVG

" escape insert mode
inoremap jj <ESC>

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

"-----------------------
" sを使うショートカット
"-----------------------
" sを無効に
nnoremap s <Nop>

" s+vp で画面分割
nnoremap sp :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>

" s+hjkl でウィンドウ間を移動
" nnoremap sh <C-w>h
" nnoremap sj <C-w>j
" nnoremap sk <C-w>k
" nnoremap sl <C-w>l

" sq+hjklでウィンドウを削除
nnoremap <silent> sqh <C-w>h:q<CR>
nnoremap <silent> sqj <C-w>j:q<CR>
nnoremap <silent> sqk <C-w>k:q<CR>
nnoremap <silent> sql <C-w>l:q<CR>

" ノーマルモードで行挿入
nnoremap <silent> so :<C-u>for i in range(1, v:count1) \| call append(line('.'),   '') \| endfor \| silent! call repeat#set("<Space>o", v:count1)<CR>
nnoremap <silent> sO :<C-u>for i in range(1, v:count1) \| call append(line('.')-1, '') \| endfor \| silent! call repeat#set("<Space>O", v:count1)<CR>

"-----------------------
" Ctrlを使うショートカット
"-----------------------
" コマンドラインの一致検索
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" 連結
" nnoremap <C-j> J
" nnoremap <C-k> gJ
" vnoremap <C-j> J
" vnoremap <C-k> gJ

" C-y でも visual mode に
nnoremap <C-y> <C-v>



"=========================================================================
" 外部プラグイン
"=========================================================================
if has('nvim')
    let g:plug_dir = expand('~/.cache/plug')
    call plug#begin(g:plug_dir)

    "-----------------------
    " denite
    "-----------------------
    Plug 'Shougo/denite.nvim', {'on': 'Denite'}
    Plug 'Shougo/neomru.vim', {'on': 'Denite'}
    Plug 'Shougo/neoyank.vim', {'on': 'Denite'} " yank history
    Plug 'thinca/vim-qfreplace', {'on': 'Denite'}
    Plug 'rking/ag.vim', {'on': 'Denite'}  " 高速な検索

    autocmd FileType denite call s:denite_my_settings()
    autocmd FileType denite call s:denite_my_settings()
    function! s:denite_my_settings() abort
      nnoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
      nnoremap <silent><buffer><expr> d denite#do_map('do_action', 'delete')
      nnoremap <silent><buffer><expr> p denite#do_map('do_action', 'preview')
      nnoremap <silent><buffer><expr> q denite#do_map('quit')
      nnoremap <silent><buffer><expr> i denite#do_map('open_filter_buffer')
      nnoremap <silent><buffer><expr> <Space> denite#do_map('toggle_select').'j'
    endfunction

    "-----------------------
    " コード入力補助
    "-----------------------
    Plug 'morhetz/gruvbox' " colorsheme
    Plug 'coderifous/textobj-word-column.vim', {'on': []} " 矩形選択を拡張
    Plug 'cohama/lexima.vim', {'on': []}  " 自動でカッコなどを閉じる
    Plug 'bronson/vim-trailing-whitespace', {'on': []}  " 全角スペースをハイライト
    Plug 'ConradIrwin/vim-bracketed-paste', {'on': []} " ペーストでインデントが崩れない
    Plug 'kana/vim-textobj-user', {'on': []} " textobj設定
    Plug 'Yggdroot/indentLine', {'on': []} " インデントを見やすく
    Plug 'aperezdc/vim-template', {'on': []} " テンプレートからファイル作成
    Plug 'tpope/vim-repeat', {'on': []} " 独自ショートカットも'.u'できる
    Plug 'tpope/vim-surround', {'on': []}  " 括弧などのブロック文字を簡単に変更
    Plug 'tpope/vim-speeddating', {'on': []} " C-a, C-xを日付に拡張

    " 一括コメントアウト追加/削除
    Plug 'tomtom/tcomment_vim', {'on': 'TComment'}
    let g:tcomment_opleader1 = 'sc'

    " 画面内の任意の場所にジャンプ
    Plug 'easymotion/vim-easymotion'
    let g:EasyMotion_keys = 'fjdkslaureiwoqpvncm' " ジャンプ用のタグに使う文字の優先順位
    let g:EasyMotion_startofline = 0 " keep cursor column when JK motion
    nmap sl <Plug>(easymotion-s2)
    nmap sh <Plug>(easymotion-t2)

    " 範囲選択をショートカットで
    Plug 'terryma/vim-expand-region'
    vmap v <Plug>(expand_region_expand)
    vmap <C-v> <Plug>(expand_region_shrink)

    " automatic ctags generater
    " Plug 'jsfaint/gen_tags.vim'
    " let g:gen_tags#ctags_auto_gen = 1
    " let g:gen_tags#gtags_auto_gen = 1

    "  toggle true false
    Plug 'AndrewRadev/switch.vim', {'on': 'Switch'}
    let g:switch_mapping = 's-'

    " choosewin
    Plug 't9md/vim-choosewin', {'on': 'ChooseWin'}  " ウィンドウ選択
    nnoremap - <Plug>(choosewin)
    let g:choosewin_label = 'fjsldka;'

    " テキスト整形
    Plug 'junegunn/vim-easy-align', {'on': 'EasyAlign'}
    xnoremap sa <Plug>(EasyAlign)
    nnoremap sa <Plug>(EasyAlign)

    " snippet
    Plug 'Shougo/neosnippet', {'on': []}
    Plug 'Shougo/neosnippet-snippets', {'on': []}
    Plug 'honza/vim-snippets', {'on': []}
    let g:neosnippet#enable_conceal_markers = 0
    let g:neosnippet#enable_snipmate_compatibility = 1
    let g:neosnippet#snippets_directory = g:plug_dir  . '/repos/github.com/vim-snippets/snippets'
    inoremap <C-s> <Plug>(neosnippet_expand_or_jump)
    snoremap <C-s> <Plug>(neosnippet_expand_or_jump)
    xnoremap <C-s> <Plug>(neosnippet_expand_target)

    " completion
    Plug 'Shougo/deoplete.nvim', {'on': []}  " completion engine
    let g:deoplete#enable_auto_close_preview = 0 " preview windowを閉じない
    let g:deoplete#enable_at_startup = 1
    let g:deoplete#auto_complete_delay = 0
    let g:deoplete#auto_complete_start_length = 1
    let g:deoplete#enable_camel_case = 0
    let g:deoplete#enable_ignore_case = 0
    let g:deoplete#enable_refresh_always = 1
    let g:deoplete#enable_smart_case = 1
    let g:deoplete#file#enable_buffer_path = 1
    let g:deoplete#max_list = 1000
    let g:deoplete#sources#syntax#min_keyword_length = 2
    inoremap <expr><C-g> deoplete#undo_completion()
    inoremap <expr><C-l> deoplete#complete_common_string()
    inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
    inoremap <expr><CR> pumvisible() ? deoplete#close_popup()."\<CR>" : "\<CR>"
    inoremap <expr><Space> pumvisible() ? deoplete#close_popup()."\<Space>" : "\<Space>"
    inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> deoplete#smart_close_popup()."\<C-h>"
    inoremap <expr><C-w> deoplete#close_popup()
    inoremap <expr><C-e> deoplete#cancel_popup()
    inoremap <C-o> <C-x><C-f>

    augroup plugAutoCmd
        autocmd!
        autocmd InsertLeave * silent! pclose! " インサートから抜けたらpreview windowを閉じる
    augroup END

    " lint
    Plug 'w0rp/ale'
    Plug 'prettier/vim-prettier', {'do': 'npm install'}
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
    nmap <silent> s[ <Plug>(ale_previous_wrap)
    nmap <silent> s] <Plug>(ale_next_wrap)
    nnoremap <silent> <C-l> :<C-u>ALEFix<CR>



    "--------
    " python
    "--------
    Plug 'neovim/python-client', {'for': 'python'}
    Plug 'hynek/vim-python-pep8-indent', {'for': 'python'}  " pep8に準拠したインデント
    Plug 'bps/vim-textobj-python', {'for':  'python'} " textobj拡張
    Plug 'zchee/deoplete-jedi', {'for': 'python', 'on': []}  " completion
    let g:deoplete#sources#jedi#python_path = g:python3_host_prog

    " add syntax
    if version < 600
        syntax clear
    elseif exists('b:current_after_syntax')
        finish
    endif

    let b:current_after_syntax = 'python'
    syn match pythonOperator "\(+\|=\|-\|\^\|\*\)"
    syn match pythonDelimiter "\(,\|\.\|:\)"
    syn keyword pythonSpecialWord self
    hi link pythonSpecialWord    Special
    hi link pythonDelimiter      Special

    "------------
    " C++
    "------------
    Plug 'Shougo/deoplete-clangx', {'for': 'cpp'}
    Plug 'Shougo/neoinclude', {'for': 'cpp'}
    Plug 'vim-scripts/a.vim', {'for': 'cpp'}

    "------------
    " JS + TS
    "------------
    Plug 'othree/html5.vim', {'for': 'html'}
    Plug 'mattn/emmet-vim', {'for': 'html'}
    Plug 'alvan/vim-closetag', {'for': 'html'}
    Plug 'JulesWang/css.vim', {'for': 'css'}
    Plug 'hail2u/vim-css3-syntax', {'for': 'css'}
    Plug 'cakebaker/scss-syntax.vim', {'for': 'sass'}
    Plug 'pangloss/vim-javascript', {'for': 'javascript'}
    Plug 'carlitux/deoplete-ternjs', {'for': 'javascript', 'on': []}
    Plug 'HerringtonDarkholme/yats.vim', {'for': 'javascript'}
    Plug 'Quramy/tsuquyomi', {'for': 'typescript'}
    let g:user_emmet_leader_key='<C-i>'

    "------------
    " Rust
    "------------
    Plug 'rust-lang/rust.vim', {'for': 'rust'}
    Plug 'sebastianmarkow/deoplete-rust', {'for': 'rust', 'on': []}

    "------------
    " Go
    "------------
    Plug 'fatih/vim-go', {'for': 'go'}
    Plug 'deoplete-plugins/deoplete-go', {'for': 'go', 'on': []}
    let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
    let g:go_fmt_command = 'goimports'
    let g:go_bin_path = $GOPATH . '/bin'

    "------------
    " Others
    "------------
    Plug 'iamcco/markdown-preview.nvim', {'for': 'markdown'}
    Plug 'cespare/vim-toml', {'for': 'toml'}  " toml syntax
    Plug 'elzr/vim-json', {'for' : 'json'}  " json
    Plug 'chase/vim-ansible-yaml'
    Plug 'chr4/nginx.vim'
    Plug 'ekalinin/Dockerfile.vim'
    let g:vim_json_syntax_conceal = 0



    "=========================================================================
    " git
    "=========================================================================
    " Plug 'tpope/vim-fugitive' " vimからgitコマンドをたたく
    Plug 'cohama/agit.vim' " improved gitv
    Plug 'idanarye/vim-merginal' " mergeを見やすく
    Plug 'rhysd/committia.vim' " commit -vのログ入力補助
    Plug 'airblade/vim-gitgutter' " 差分のある行にマークをつける
    nmap sj <Plug>GitGutterNextHunk
    nmap sk <Plug>GitGutterPrevHunk
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
    Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'} " ファイルツリー（画面右）
    Plug 'Xuyuanp/nerdtree-git-plugin', {'on': 'NERDTreeToggle'} " git gutter
    Plug 'ap/vim-buftabline' " バッファ表示(画面下
    Plug 'itchyny/lightline.vim' " ステータスライン(画面下
    " Plug 'lyuts/vim-rtags'
    Plug 'majutsushi/tagbar' " タグ関連(画面右

    " Plug 'soramugi/auto-ctags.vim'
    " Plug 'jsfaint/gen_tags.vim'
    " set tags=.tags;$HOME
    " function! s:execute_ctags() abort
    "   let tag_name = '.tags'
    "   let tags_path = findfile(tag_name, '.;')
    "   if tags_path ==# ''
    "     return
    "   endif
    "
    "   let tags_dirpath = fnamemodify(tags_path, ':p:h')
    "   execute 'silent !cd' tags_dirpath '&& ctags -R -f' tag_name '2> /dev/null &'
    " endfunction
    " autocmd BufWritePost * call s:execute_ctags()
    "
    " let g:gen_tags#ctags_auto_gen = 1
    "
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

    let NERDTreeIgnore = ['.[oa]$', '.(so)$', '.(tgz|gz|zip)$' ]
    let NERDTreeShowHidden = 1
    " http://qiita.com/ymiyamae/items/3fa77d85163fb734b359
    " ファイルの方にカーソルを向ける
    " function! s:MoveToFileAtStart()
    "   call feedkeys("\<Space>")
    "   call feedkeys("\s")
    "   call feedkeys("\l")
    " endfunction
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

    " augroup NERDTreeAutoCmds
    "     autocmd!
    "     autocmd VimEnter * NERDTree | call s:MoveToFileAtStart() " 起動時に開く
    " augroup END

    " auto close nerdtree when close window and there is only one window at that time
    augroup NERDTreeAutoClose
        autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    augroup END

    let NERDTreeIgnore=['\~$']

    " let g:auto_ctags = 0
    " function! s:auto_ctags_toggle()
    "     if g:auto_ctags == 0
    "         let g:auto_ctags = 1
    "     else
    "         let g:auto_ctags = 0
    "     endif
    "     if g:auto_ctags == 1
    "         echo "Enable AutoCtags"
    "     else
    "         echo "Disable AutoCtags"
    "     endif
    " endfunction
    " command! AutoCtagsToggle call <SID>auto_ctags_toggle()
    "
    "-----------------------
    " tで始まるショートカット
    "-----------------------
    nnoremap t <Nop>
    " nnoremap <silent> tn :<C-u>NERDTreeToggle<CR>:wincmd p<CR>
    nnoremap <silent> tn :<C-u>NERDTreeToggle<CR>
    nnoremap <silent> tb :<C-u>TagbarToggle<CR>
    " nnoremap <silent> tc :<C-u>AutoCtagsToggle<CR>
    nnoremap <silent> tl :<C-u>ALEToggle<CR>
    nnoremap <silent> tg :<C-u>GitGutterLineHighlightsToggle<CR>
    nnoremap <silent> tj :<C-u>bprev<CR>
    nnoremap <silent> tk :<C-u>bnext<CR>

    call plug#end()

    " setting color
    colorscheme gruvbox

    " lazy load
    " after first insert
    augroup load_us_insert
        autocmd!
        autocmd InsertEnter * call plug#load(
        \ 'deoplete.nvim',
        \ 'neosnippet.vim',
        \ 'neosnippet-snippets',
        \ 'vim-snippets',
        \ 'deoplete-jedi',
        \ 'deoplete-ternjs',
        \ 'deoplete-go',
        \ 'deoplete-rust',
        \ ) | autocmd! load_us_insert
    augroup END

    " after certain period
    function! s:load_plug(timer)
        call plug#load(
        \ 'coderifous/textobj-word-column.vim',
        \ 'cohama/lexima.vim',
        \ 'bronson/vim-trailing-whitespace',
        \ 'ConradIrwin/vim-bracketed-paste',
        \ 'kana/vim-textobj-user',
        \ 'Yggdroot/indentLine',
        \ 'aperezdc/vim-template',
        \ 'tpope/vim-repeat',
        \ 'tpope/vim-surround',
        \ 'tpope/vim-speeddating',
        \ )
    endfunction

    call timer_start(500, function("s:load_plug")) " after 500 milliseconds

    " ローカルの設定を反映
    if filereadable(expand('~/.nvimrc.local'))
        source ~/.nvimrc.local
    endif
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
