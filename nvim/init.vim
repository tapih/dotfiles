"=========================================================================
" initialize
"=========================================================================
let s:cpo_save = &cpoptions "compatible optionsの値を退避
set cpoptions&vim "vimモードに


" ローカルの設定を反映
if filereadable(expand('~//.vimrc.local'))
    source ~/.vimrc.local
endif


"=========================================================================
" 共通設定
"=========================================================================
"-----------------------
" 基本設定
"-----------------------
" ファイルタイプ関連を一旦切っておく
filetype off
filetype plugin indent off

set noshowmode
" syntax on " シンタックス有効に
set encoding=utf-8 " エンコーディング
set number     " 行番号の表示
set scrolloff=10 " scroll offset
set cursorline   " カーソルライン横
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
set tabstop=4  " タブは半角スペース4つ分で表示
set autoindent " 自動インデント
set shiftwidth=4 " インデントは半角スペース4つ分
set showcmd    "ステータスラインにコマンドを表示
set hlsearch   " 検索文字列をハイライト
set nowrapscan " 検索で文頭にループしない
set ignorecase smartcase " 基本ignorecaseだが大文字小文字が混在しているときは普通に検索

" ヤンクバッファを共有
if has('unix')
    set clipboard+=unnamed
else
    set clipboard+=unnamedplus
endif

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

" TODO
let g:my_python_path = $PYENV_ROOT  . '/versions/2.7.10/bin/python'
let g:my_python3_path = $PYENV_ROOT . '/versions/3.5.0/bin/python'
let g:python_host_prot = g:my_python_path
let g:python3_host_prog = g:my_python3_path



" help windowリサイズ
command! -complete=help -nargs=* H help <args><CR>resize 10<CR>

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
function! s:CountEditingBuf()
    let cnt = 0
    for w in range(1, winnr('$'))
        let _ = getwinvar(w, '&ft')
        if _ !~ 'help\|nerdtree\|gundo\|tagbar\|terminal'
            let cnt = cnt + 1
        endif
    endfor
    return cnt
endfunction

augroup AutoClose
  autocmd!
  autocmd WinEnter * if <SID>CountEditingBuf() == 0 | quitall | endif
augroup END

" カレントバッファを閉じたら一緒に閉じる
" nnoremap <silent> <C-d> :lclose<CR>:bdelete<CR>
cabbrev <silent> bd <C-r>=(getcmdtype()==#':' && getcmdpos()==1 ? 'lclose\|bdelete' : 'bd')<CR>

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

" qでウィンドウ閉じる
nnoremap q :<C-u>q<CR>

" タグは使わない
nnoremap [Tag] <Nop>

" 修正した場所に飛ぶ
nnoremap J g;
nnoremap K g,

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

" バッファ切り替え
nnoremap bb :ls<CR>:buffer

" terminal
if has('nvim')
    set sh=zsh
    tnoremap <silent> <ESC> <C-\><C-n>
    tnoremap <silent> <C-[> <C-\><C-n>
    tnoremap <silent> jj <C-\><C-n>
endif

"-----------------------
" sを使うショートカット
"-----------------------
" sを無効に
nnoremap s <Nop>

" s+vp で画面分割
nnoremap sp :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>

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

"-----------------------
" Ctrlを使うショートカット
"-----------------------
" コマンドラインの一致検索
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" 連結
nnoremap <C-j> J
nnoremap <C-k> gJ
vnoremap <C-j> J
vnoremap <C-k> gJ



"=========================================================================
" 外部プラグイン
"=========================================================================
let g:config_dir = empty($XDG_CONFIG_HOME) ? expand('~/.config') : $XDG_CONFIG_HOME
let g:cache_dir = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME

if has('nvim')
    let g:dein_dir = g:cache_dir . '/dein'
    let g:dein_repo_dir = g:dein_dir . '/repos/github.com/Shougo/dein.vim'
    execute 'set rtp+=' . g:dein_repo_dir
    if dein#load_state(g:dein_dir)
        call dein#begin(g:dein_dir)
        call dein#add(g:dein_repo_dir) " dein自身を管理

        "-----------------------
        " color-theme
        "-----------------------
        execute 'set rtp+=' . g:dein_dir . '/repos/github.com/nanotech/jellybeans.vim'
        call dein#add('nanotech/jellybeans.vim')
        " call dein#add('cocopon/iceberg.vim')



        "-----------------------
        " denite
        "-----------------------
        call dein#add('Shougo/denite.nvim')
        call dein#add('Shougo/neomru.vim')
        call dein#add('rking/ag.vim')  " 高速な検索
        call denite#custom#var('file_rec', 'command', ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
        call denite#custom#var('grep', 'command', ['ag'])
        call denite#custom#var('grep', 'recursive_opts', [])
        call denite#custom#var('grep', 'pattern_opt', [])
        call denite#custom#var('grep', 'default_opts', ['--follow', '--no-group', '--no-color'])

        nnoremap [denite] <Nop>
        " nnoremap <silent> sf :<C-u>DeniteBufferDir file<CR>
        " https://github.com/shingokatsushima/dotfiles/blob/master/.vimrc
        " 選択した文字列をdenite-grep
        " vnoremap /g y:Denite grep::-iHRn:<C-R>=escape(@", '\\.*$^[]')<CR><CR>



        "-----------------------
        " コード入力補助
        "-----------------------
        call dein#add('tpope/vim-speeddating') " C-a, C-xを日付に拡張
        call dein#add('tpope/vim-repeat') " 独自ショートカットもひとまとまりで'.u'できる
        call dein#add('terryma/vim-expand-region') " 範囲選択をショートカットで
        call dein#add('coderifous/textobj-word-column.vim') " 矩形選択を拡張
        call dein#add('tpope/vim-surround')  " 括弧などのブロック文字を簡単に変更
        call dein#add('cohama/lexima.vim')  " 自動でカッコなどを閉じる
        call dein#add('h1mesuke/vim-alignta') " テキスト自動整形
        call dein#add('bronson/vim-trailing-whitespace')  " 全角スペースをハイライト
        call dein#add('ConradIrwin/vim-bracketed-paste') " ペーストでインデントが崩れない
        call dein#add('kana/vim-textobj-user') " textobj設定
        call dein#add('tomtom/tcomment_vim') " 一括コメントアウト追加/削除
        call dein#add('easymotion/vim-easymotion') " 画面内の任意の場所にジャンプ
        call dein#add('t9md/vim-choosewin')  " ウィンドウ選択
        call dein#add('AndrewRadev/switch.vim') " true/false切り替え"
        call dein#add('Yggdroot/indentLine') " インデントを見やすく
        call dein#add('aperezdc/vim-template')  " テンプレートからファイル作成
        " call dein#add('simeji/winresizer') " window resizeを簡単にする

        " テキスト整形
        call dein#add('junegunn/vim-easy-align')
        xmap sa <Plug>(EasyAlign)
        nmap sa <Plug>(EasyAlign)

        " bookmark
        call dein#add('MattesGroeger/vim-bookmarks')
        highlight BookmarkSign ctermbg=NONE ctermfg=160
        highlight BookmarkLine ctermbg=194 ctermfg=NONE
        let g:bookmark_sign = '♥'
        let g:bookmark_highlight_lines = 1

        " ペーストの後<Ctrl-p><Ctrl-n>でヤンクバッファを探索
        call dein#add('LeafCage/yankround.vim')
        let g:yankround_dir = g:cache_dir  . '/yankround'
        nmap p <Plug>(yankround-p)
        nmap P <Plug>(yankround-P)
        nmap gp <Plug>(yankround-gp)
        nmap gP <Plug>(yankround-gP)
        nmap <C-p> <Plug>(yankround-prev)
        nmap <C-n> <Plug>(yankround-next)

        " snippet
        call dein#add('Shougo/neosnippet')
        call dein#add('Shougo/neosnippet-snippets')
        call dein#add('honza/vim-snippets')
        let g:neosnippet#enable_conceal_markers = 0
        let g:neosnippet#enable_snipmate_compatibility = 1
        let g:neosnippet#snippets_directory = g:cache_dir  . '/repos/github.com/vim-snippets/snippets'
        imap <C-s> <Plug>(neosnippet_expand_or_jump)
        smap <C-s> <Plug>(neosnippet_expand_or_jump)
        xmap <C-s> <Plug>(neosnippet_expand_target)

        " completion
        call dein#add('Shougo/deoplete.nvim')  " completion engine
        let g:deoplete#enable_auto_close_preview = 0 " preview windowを閉じない
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
        inoremap <expr><C-g> deoplete#undo_completion()
        inoremap <expr><C-l> deoplete#complete_common_string()
        inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
        inoremap <expr><CR> pumvisible() ? deoplete#close_popup()."\<CR>" : "\<CR>"
        inoremap <expr><Space> pumvisible() ? deoplete#close_popup()."\<Space>" : "\<Space>"
        inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
        inoremap <expr><BS> deoplete#smart_close_popup()."\<C-h>"
        inoremap <expr><C-y> deoplete#close_popup()
        inoremap <expr><C-e> deoplete#cancel_popup()

        augroup DeinAutoCmd
            autocmd!
            autocmd InsertLeave * silent! pclose! " インサートから抜けたらpreview windowを閉じる
        augroup END

        " lint
        call dein#add('w0rp/ale')
        let g:ale_liners = {
                    \ 'javascript': ['eslint'],
                    \ 'typescript': ['tslint'],
                    \ 'python': ['autopep8'],
                    \ 'go': ['gofmt'],
                    \}
        let g:ale_lint_on_text_changed = 0
        let g:ale_lint_on_save = 1 " 保存したらチェック
        let g:ale_set_loclist = 0
        let g:ale_set_quickfix = 1 " quickfixに表示
        let g:ale_sign_column_always = 1 " aleコラムを常に表示
        let g:ale_sign_error = '✔︎'
        let g:ale_sign_warning = '⚠'
        let g:ale_statusline_format = ['✔︎ %d', '⚠ %d', '']
        nmap <silent> <C-h> <Plug>(ale_previous_wrap)
        nmap <silent> <C-l> <Plug>(ale_next_wrap)



        "--------
        " python
        "--------
        call dein#add('neovim/python-client', {'on_ft': 'py'})
        call dein#add('bps/vim-textobj-python', {'on_ft':  'py'}) " textobj拡張
        call dein#add('hynek/vim-python-pep8-indent', {'on_ft': 'py'})  " pep8に準拠したインデント
        call dein#add('zchee/deoplete-jedi', {'on_ft': 'py'})  " completion
        let g:deoplete#sources#jedi#python_path = g:my_python3_path

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
        " JavaScript + AltJS
        "------------
        call dein#add('othree/html5.vim')  " html5
        call dein#add('alvan/vim-closetag')
        call dein#add('mattn/emmet-vim') " htmlタグ打ちショートカット
        call dein#add('hail2u/vim-css3-syntax')  " css
        call dein#add('pangloss/vim-javascript')  " js syntax
        call dein#add('carlitux/deoplete-ternjs') " js completion
        call dein#add('HerringtonDarkholme/yats.vim') " ts syntax
        call dein#add('Quramy/tsuquyomi') " ts complete

        "------------
        " C++
        "------------
        " call dein#add('zchee/deoplete-clang')  " completion
        call dein#add('Shougo/neoinclude.vim')  " header completion
        call dein#add('vim-scripts/a.vim') " move easily between header and code

        "------------
        " Others
        "------------
        call dein#add('fatih/vim-go')  " go (v0.3.1 required)
        call dein#add('cespare/vim-toml', {'on_ft': 'toml'})  " toml syntax
        call dein#add('elzr/vim-json', {'on_ft' : 'json'})  " json
        call dein#add('chr4/nginx.vim')
        let g:vim_json_syntax_conceal = 0



        "=========================================================================
        " git
        "=========================================================================
        call dein#add('tpope/vim-fugitive') " vimからgitコマンドをたたく
        call dein#add('cohama/agit.vim') " improved gitv
        call dein#add('idanarye/vim-merginal') " mergeを見やすく
        call dein#add('rhysd/committia.vim') " commit -vのログ入力補助
        call dein#add('airblade/vim-gitgutter') " 差分のある行にマークをつける
        let g:gitgutter_sign_added = '✚'
        let g:gitgutter_sign_modified = '✹'
        let g:gitgutter_sign_removed = '✖'
        let g:gitgutter_sign_removed_first_line = '✖'
        let g:gitgutter_sign_modified_removed = '✖'

        augroup DisableGitFold
            autocmd!
            autocmd FileType git setlocal nofoldenable foldlevel=0
        augroup END



        "=========================================================================
        " ウィジェット関連
        "=========================================================================
        call dein#add('itchyny/lightline.vim') " ステータスライン(画面下)
        call dein#add('ap/vim-buftabline') " バッファ表示(画面下)
        call dein#add('scrooloose/nerdtree') " ファイラ関連（画面右）


        " タグ関連(画面右)
        call dein#add('majutsushi/tagbar')
        " call dein#add('lyuts/vim-rtags')

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

        " ビルド・実行
        call dein#add('kassio/neoterm')
        let g:neoterm_autoscroll = 1
        let g:neoterm_fixedsize = 1
        let g:neoterm_size = 12

        call dein#add('thinca/vim-quickrun') " quickrun
        let g:quickrun_config = {
        \   "_" : {
        \       "hook/close_quickfix/enable_exit" : 1,
        \       "hook/close_buffer/enable_failure" : 1,
        \       "hook/close_buffer/enable_empty_data" : 1,
        \       "outputter" : "error",
        \       "oukputter/error/success" : "buffer",
        \       "outputter/error/error" : "quickfix",
        \       "outputter/buffer/close_on_empty": 1,
        \   }
        \}

        "-----------------------
        " Spaceで始まるショートカット
        "-----------------------
        let mapleader="\<Space>"
        nnoremap <buffer> <leader>c :AutoCtagsToggle<CR>
        nnoremap <silent> <buffer> <leader>f :NERDTreeToggle<CR>
        nnoremap <silent> <buffer> <leader>t :TagbarToggle<CR>
        nnoremap <silent> <buffer> <leader>r :QuickRun<CR>
        nnoremap <silent> <buffer> <leader>q :cclose<CR>
        nnoremap <silent> <buffer> <leader>g :GitGutterLineHighlightsToggle<CR>
        nnoremap <buffer> <leader>l :ALEToggle<CR>

        "-----------------------
        " ,で始まるショートカット
        "-----------------------
        " nnoremap <silent> ,n :VBGStepOver<CR>
        " nnoremap <silent> ,s :VBGStepIn<CR>
        " nnoremap <silent> ,S :VBGStepOut<CR>
        " nnoremap <silent> ,c :VBGStepContinue<CR>
        " nnoremap <silent> ,t :VBGtoggleBreakpointThisLine<CR>
        " nnoremap <silent> ,l :VBGclearBreakpoints<CR>
        " nnoremap <silent> ,q :VGBkill<CR>

        "-----------------------
        nnoremap t <Nop>
        nnoremap <silent> tt :Ttoggle<CR>
        nnoremap <silent> tp :T ipython<CR>
        nnoremap <silent> tn :T node<CR>
        nnoremap <silent> tq :Tclose!<CR>
        nnoremap <silent> tl :call neoterm#clear()<CR>
        nnoremap <silent> tc :call neoterm#kill()<CR>
        nnoremap <silent> ts :TREPLSendLine<CR>
        vnoremap <silent> ts :TREPLSendSelection<CR>

        call dein#end()
    endif
else
    let g:bundle_dir = expand('~/.vim/bundle/')
    let g:neobundle_repo_dir = g:bundle_dir  . 'neobundle.vim'
    if isdirectory(g:neobundle_repo_dir)
        execute 'set rtp+=' . g:neobundle_repo_dir
        call neobundle#begin(g:neobundle_dir)
        NeoBundleFetch('Shougo/neobundle.vim')

        NeoBundle('bronson/vim-trailing-whitespace')  " 全角スペースをハイライト
        NeoBundle("tomtom/tcomment_vim") " 一括コメントアウト
        NeoBundle('tpope/vim-surround')  " 括弧などのブロック文字を簡単に変更
        NeoBundle('cohama/lexima.vim')  " 自動でカッコなどを閉じる
        NeoBundle('kana/vim-textobj-user') " textobj設定
        NeoBundle('terryma/vim-expand-region') " 範囲選択をショートカットで
        NeoBundle('scrooloose/nerdtree') " file tree
        NeoBundle('easymotion/vim-easymotion') " 画面内の任意の場所にジャンプ
        " NeoBundle('fatih/vim-go')  " go
        NeoBundle('cespare/vim-toml')
        NeoBundle('chr4/nginx.vim')

        execute 'set rtp+=' . g:neobundle_dir . '/repos/github.com/nanotech/jellybeans.vim'
        NeoBundle('nanotech/jellybeans.vim')

        " 補完
        function! s:meet_neocomplete_requirements()
            return has('lua') && (v:version > 703 || (v:version == 703 && has('patch885')))
        endfunction

        if s:meet_neocomplete_requirements()
            NeoBundle 'Shougo/neocomplete.vim'
            let g:acp_enableAtStartup = 0
            let g:neocomplete#enable_at_startup = 1
            let g:neocomplete#enable_smart_case = 1
            let g:neocomplete#sources#syntax#min_keyword_length = 3

            inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
            function! s:my_cr_function()
                return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
            endfunction

            inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
            inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
            inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
            inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"
        else
            NeoBundle 'Shougo/neocomplcache.vim'
            let g:acp_enableAtStartup = 0
            let g:neocomplcache_enable_at_startup = 1
            let g:neocomplcache_enable_smart_case = 1
            let g:neocomplcache_min_syntax_length = 3

            inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
            function! s:my_cr_function()
                return neocomplcache#smart_close_popup() . "\<CR>"
            endfunction
            inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
            inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
            inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
            inoremap <expr><C-y>  neocomplcache#close_popup()
            inoremap <expr><C-e>  neocomplcache#cancel_popup()
            inoremap <expr><Space> pumvisible() ? neocomplcache#close_popup() : "\<Space>"
        endif

        call neobundle#end()

        NeoBundleCheck
    endif
endif

"=========================================================================
" 共通設定(外部プラグイン関連)
"=========================================================================
let g:lightline_config_path = g:config_dir . '/lightline.vim'
if filereadable(g:lightline_config_path)
    source g:lightline_config_path
endif

let g:nerdtree_config_path = g:config_dir . '/nerdtree.vim'
if filereadable(g:nerdtree_config_path)
    source g:nerdtree_config_path
endif

colorscheme jellybeans

" expand-region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" choosewin
nmap - <Plug>(choosewin)
let g:choosewin_label = 'fjsldka;'

" easymotion
let g:EasyMotion_keys = 'fjdkslaureiwoqpvncm' " ジャンプ用のタグに使う文字の優先順位
let g:EasyMotion_startofline = 0 " keep cursor column when JK motion
nmap ss <Plug>(easymotion-s2)
nmap st <Plug>(easymotion-t2)

" tcomment
let g:tcomment_opleader1 = 'sc'

"  toggle true false
let g:switch_mapping = 's-'

"=========================================================================
" finalize
"=========================================================================
filetype plugin indent on

let &cpo = s:cpo_save "cpoを元に戻す
unlet s:cpo_save

