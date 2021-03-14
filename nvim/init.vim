"=========================================================================
" 共通設定
"=========================================================================
let s:cpo_save = &cpoptions "compatible optionsの値を退避
set cpoptions&vim "vimモードに

"-----------------------
" 基本設定
"-----------------------
" ファイルタイプ関連を一旦切っておくfiletype off filetype plugin indent off
syntax enable " シンタックス有効に
set encoding=utf-8 " エンコーディング
set relativenumber
set number     " 行番号の表示
set number relativenumber
set scrolloff=10 " scroll offset
set cursorline   " カーソルライン横
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
set nobackup nowritebackup " backup file作らない
set noswapfile " swap file作らない
set hidden " バッファを移動する際に保存しなくて済む
set colorcolumn=80 " 80行目に線
set list listchars=tab:>-,trail:-,nbsp:%,eol:$ " 不可視文字を表示
set iskeyword-=/ " /を区切り文字に追加
set visualbell t_vb=
set conceallevel=0 " 特殊文字を隠さない
set autoindent " 自動インデント
set shiftwidth=4 " インデントは半角スペース4つ分
set tabstop=4  " タブは半角スペース4つ分で表示
set updatetime=250 " for git-gutter
" set clipboard=unnamedplus
"
if has('nvim')
    set inccommand=split
endif

if has('nvim') && executable('nvr')
  let $GIT_EDITOR = "nvr -cc split --remote-wait +'set bufhidden=wipe'"
endif

let g:python_pyenv_global = $PYENV_ROOT.'/shims/python'
let g:python_host_prog = $PYENV_ROOT.'/versions/neovim2/bin/python'
let g:python3_host_prog = $PYENV_ROOT.'/versions/neovim3/bin/python'

augroup SetYAMLIndent
    autocmd!
    autocmd FileType yaml setlocal sw=2 sts=2 ts=2 et
augroup END

" do not add comment simbol after line break
augroup DisableAutoComment
    autocmd!
    autocmd FileType * set fo-=cro
augroup END

" インサートから抜けたらpreview windowを閉じる
augroup PlugAutoCmd
    autocmd!
    autocmd InsertLeave * silent! pclose!
augroup END

" set nopaste when leaving insert mode
augroup AutoNoPasteLeaveInsert
    autocmd!
    autocmd InsertLeave * set nopaste
augroup END

" 最後にファイルを閉じた場所で開く
augroup OpenAtLastClosed
    autocmd!
    autocmd BufRead * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif
augroup END

" template
augroup Template
    autocmd BufNewFile *.cpp 0r $HOME/.config/nvim/template/competitive_programming.cpp
augroup END

" 編集用のバッファをすべて閉じた時に他のウィンドウ（help, terminalなど）も閉じる
function! AutoCloseBuf()
    if len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
        :q
    else
        :bd
    endif
endfunction

" replace in all opened buffers http://vim.wikia.com/wiki/VimTip382
function! Replace()
    let s:word = input("Replace " . expand('<cword>') . " with:")
    :exe 'bufdo! %s/\<' . expand('<cword>') . '\>/' . s:word . '/gce'
    :unlet! s:word
endfunction


"=========================================================================
" プラグイン
"=========================================================================
if has('nvim')
    if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
        silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
            \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif

    let g:plug_dir = expand('~/.cache/plug')
    let g:plug_window = 'new'
    call plug#begin(g:plug_dir)

    "-----------------------
    " コード入力補助
    "-----------------------
    Plug 'sickill/vim-monokai'
    Plug 'sheerun/vim-polyglot'
    Plug 'kana/vim-operator-replace' " replace current word with yanked text
    Plug 'kana/vim-operator-user' " dependency for operator-replace
    Plug 'kana/vim-textobj-user' " textobj設定
    Plug 'coderifous/textobj-word-column.vim' " 矩形選択を拡張
    Plug 'airblade/vim-rooter' " open nvim at the root of the project
    Plug 'mhinz/vim-startify' " fancy start screen
    Plug 'tmux-plugins/vim-tmux-focus-events' " tmux clipboard
    Plug 'roxma/vim-tmux-clipboard' " tmux clipboard

    Plug 'vim-scripts/loremipsum', {'on': 'Loremipsum'}
    Plug 'junegunn/vim-easy-align', {'on': 'EasyAlign'} " テキスト整形
    Plug 'moll/vim-bbye', {'on': 'Bdelete'} " close buffer but do not close split window

    Plug 'cohama/lexima.vim', {'on': []}  " 自動でカッコなどを閉じる
    Plug 'tomtom/tcomment_vim', {'on': []}  " 一括コメントアウト追加/削除
    Plug 'bronson/vim-trailing-whitespace', {'on': []}  " 全角スペースをハイライト
    Plug 'tpope/vim-repeat', {'on': []} " 独自ショートカットも'.u'できる
    Plug 'tpope/vim-surround', {'on': []}  " 括弧などのブロック文字を簡単に変更
    Plug 'terryma/vim-expand-region', {'on': []} " 範囲選択をショートカットで
    Plug 'jiangmiao/auto-pairs', {'on': []} " automatically delete paired blacket
    Plug 'honza/vim-snippets', {'on': []} " snippets
    Plug 'matze/vim-move', {'on': []} " 独自ショートカットも'.u'できる
    Plug 'ruanyl/vim-gh-line', {'on': []} " jump to the current line on GitHub

    Plug 'tyru/open-browser.vim', {'on': [
                \ 'OpenBrowser',
                \ 'OpenBrowserSearch',
                \ 'OpenBrowserSmartSearch',
                \ ]} " open browser and search the word under cursor
    Plug 'tyru/open-browser-github.vim', {'on': [
                \ 'OpenGithubFile',
                \ 'OpenGithubIssue',
                \ 'OpenGithubPullReq',
                \ 'OpenGithubProject',
                \ ]}

    " vaffle
    Plug 'cocopon/vaffle.vim', {'on': 'Vaffle'} " simple filer
    Plug 'ryanoasis/vim-devicons', {'on': 'Vaffle'} " icons

    function! VaffleRenderCustomIcon(item)
        return WebDevIconsGetFileTypeSymbol(a:item.basename, a:item.is_dir)
    endfunction
    let g:vaffle_render_custom_icon = 'VaffleRenderCustomIcon'

    " echodoc
    Plug 'Shougo/echodoc.vim' " show doc above the function
    let g:echodoc#enable_at_startup = 1
    let g:echodoc#type = 'floating'
    " To use a custom highlight for the float window,
    " " change Pmenu to your highlight group
    highlight link EchoDocFloat Pmenu"

    " ultisnips
    Plug 'SirVer/ultisnips' " snippet engine
    let g:UltiSnipsExpandTrigger="<tab>"
    let g:UltiSnipsJumpForwardTrigger="<c-g>"
    let g:UltiSnipsJumpBackwardTrigger="<c-z>"

    " far
    Plug 'brooth/far.vim', {'on': ['Far', 'Farr']}  " search and replace
    let g:far#collapse_result=1
    let g:far#preview_window_height=25
    let g:far#mapping = {
        \ "toggle_expand_all" : "zA",
        \ "stoggle_expand_all" : "zS",
        \ "expand_all" : "O",
        \ "collapse_all" : "C",
        \
        \ "toggle_expand" : "za",
        \ "stoggle_expand" : "zs",
        \ "expand" : "o",
        \ "collapse" : "c",
        \
        \ "exclude" : "x",
        \ "include" : "i",
        \ "toggle_exclude" : "d",
        \ "stoggle_exclude" : "f",
        \
        \ "exclude_all" : "X",
        \ "include_all" : "I",
        \ "toggle_exclude_all" : "D",
        \ "stoggle_exclude_all" : "F",
        \
        \ "jump_to_source" : "<cr>",
        \ "open_preview" : "p",
        \ "close_preview" : "P",
        \ "preview_scroll_up" : "<c-k>",
        \ "preview_scroll_down" : "<c-j>",
        \
        \ "replace_do" : 's',
        \ "replace_undo" : 'u',
        \ "replace_undo_all" : 'U',
        \ "quit" : 'q',
        \ }

    " インデントを見やすく
    Plug 'nathanaelkane/vim-indent-guides', { 'on': [] }
    let g:indent_guides_enable_on_vim_startup = 1
    let g:indent_guides_start_level = 2
    let g:indent_guides_guide_size = 1

    " 画面内の任意の場所にジャンプ
    Plug 'easymotion/vim-easymotion', {'on': []}
    let g:EasyMotion_keys = 'fjdkslaureiwoqpvncm' " ジャンプ用のタグに使う文字の優先順位
    let g:EasyMotion_startofline = 0 " keep cursor column when JK motion



    " ---
    " fzf
    " ---
    Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary', 'on': 'Clap' }
    let g:clap_enable_icon = 1
    let g:clap_background_shadow_blend = 80
    let g:clap_default_external_filter = "fzf"
    let g:clap_layout = { 'width': '45%', 'height': '80%', 'col': '5%', 'row': '10%' }
    let g:clap_preview_size = 2
    let g:clap_preview_direction = "LR"
    "
    autocmd FileType clap_input inoremap <silent> <buffer> <C-n> <C-R>=clap#navigation#linewise('down')<CR>
    autocmd FileType clap_input inoremap <silent> <buffer> <C-p> <C-R>=clap#navigation#linewise('up')<CR>

    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    let g:fzf_command_prefix = 'Fzf'
    let g:fzf_layout = { 'window': { 'width': 0.95, 'height': 0.95 } }
    let g:fzf_preview_window = ['right:60%', 'ctrl-/']

    " --------
    " lsp 関連
    " --------
    Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install() } }
    Plug 'antoinemadec/coc-fzf'
    Plug 'vn-ki/coc-clap', {'on': 'Clap'}
    let g:coc_fzf_preview = "down:80%:wrap"
    let g:coc_fzf_opts = []
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
    command! -nargs=0 CocFormat :call CocAction('format')

    let g:coc_global_extensions = [
                \ 'coc-ultisnips',
                \ 'coc-snippets',
                \ 'coc-git',
                \ 'coc-json',
                \ 'coc-yaml',
                \ 'coc-toml',
                \ 'coc-html',
                \ 'coc-css',
                \ 'coc-sh',
                \ 'coc-flutter',
                \ 'coc-rls',
                \ 'coc-pyright',
                \ 'coc-highlight',
                \ 'coc-diagnostic',
                \ ]


    "-------------
    " その他言語別
    "-------------
    " Go
    Plug 'buoto/gotests-vim', {'for': 'go', 'on': ['GoTests', 'GoTestsAll']}
    Plug 'fatih/vim-go', {'for': 'go'}
    Plug 'mattn/vim-goimports', {'for': 'go'} " light weight goimports runner
    Plug '110y/vim-go-expr-completion', {'branch': 'master'}
    let g:go_bin_path = $GOPATH . '/bin'
    let g:go_highlight_functions = 1
    let g:go_highlight_methods = 1
    let g:go_highlight_structs = 1
    augroup GoHighlight
        autocmd FileType go :highlight goErr cterm=bold ctermfg=214
        autocmd FileType go :match goErr /\<err\>/
    augroup END

    Plug 'andrewstuart/vim-kubernetes', {'for': 'yaml'}
    Plug 'hashivim/vim-terraform', {'for': 'tf'}
    Plug 'ekalinin/Dockerfile.vim', {'for': 'Dockerfile'}
    Plug 'dart-lang/dart-vim-plugin', {'for': 'dart'}
    Plug 'natebosch/vim-lsc', {'for': 'dart'}
    Plug 'natebosch/vim-lsc-dart', {'for': 'dart'}
    Plug 'thosakwe/vim-flutter', {'for': 'dart'}
    Plug 'chr4/nginx.vim', {'for': 'nginx'}
    Plug 'tmux-plugins/vim-tmux', {'for': 'tmux'}
    Plug 'alvan/vim-closetag', {'for': 'html'}
    Plug 'hail2u/vim-css3-syntax', {'for': 'css'}
    Plug 'vim-scripts/a.vim', {'for': 'c++'}
    Plug 'hynek/vim-python-pep8-indent', {'for': 'python'}
    Plug 'cespare/vim-toml', {'for': 'toml'}
    Plug 'uarun/vim-protobuf', {'for': 'proto'}
    Plug 'godlygeek/tabular', {'for': 'markdown'}
    Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' , 'for': 'markdown' }

    let g:vim_markdown_folding_disabled = 1
    function! OpenBrowser(url)
        exe '!xdg-open ' . a:url
    endfunction
    let g:mkdp_browserfunc = 'OpenBrowser'

    Plug 'mattn/emmet-vim', {'for': 'html'}
    let g:user_emmet_leader_key='<C-q>'

    Plug 'tpope/vim-dadbod', { 'on': 'DB' }
    Plug 'kristijanhusak/vim-dadbod-ui', { 'on': 'DBUIAddConnection' }


    "=========================================================================
    " git
    "=========================================================================
    Plug 'airblade/vim-gitgutter', {'on': []} " 差分のある行にマークをつける
    Plug 'tpope/vim-fugitive'
    Plug 'rhysd/committia.vim'
    Plug 'itchyny/vim-gitbranch'
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
    Plug 'ap/vim-buftabline' " バッファ表示(画面

    let g:lightline = {
        \ 'colorscheme': 'molokai',
        \ 'active': {
        \   'left': [
        \     ['mode', 'paste'],
        \     ['filename'], ['gitbranch', 'fugitive', 'gitgutter', 'cocstatus', 'currentfunction'],
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
        \   'cocstatus': 'StatusDiagnostic',
        \   'gitgutter': 'MyGitGutter',
        \   'fileformat': 'MyFileFormat',
        \   'fileencoding': 'MyFileEncoding',
        \   'filetype': 'MyFileType',
        \   'charcode': 'MyCharCode',
        \   'gitbranch': 'gitbranch#name',
        \ },
        \ 'separator': {'left': '>>', 'right': '|'},
        \ 'subseparator': {'left': '|', 'right': '|'}
        \ }

    function! StatusDiagnostic() abort
        let info = get(b:, 'coc_diagnostic_info', {})
        if empty(info) | return '' | endif
        let msgs = []
        if get(info, 'error', 0)
            call add(msgs, '✔︎:' . info['error'])
        endif
        if get(info, 'warning', 0)
            call add(msgs, '⚠:' . info['warning'])
        endif
        return join(msgs, ' '). ' ' . get(g:, 'coc_status', '')
    endfunction

    function! MyModified()
        return &ft =~ 'help\|nerdtree\|gundo\|tagbar\|terminal' ? '' : &modified ? '+' : &modifiable ? '' : '-'
    endfunction

    function! MyReadOnly()
        return &ft !~? 'help\|vimfiler\|gundo' && &ro ? '|' : ''
    endfunction

    function! MyFileName()
        let fname = expand('%p:t')
        return  &ft == 'tagbar' ? 'TagBar' :
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

    call plug#end()

    " ---------
    " lazy load
    " ---------
    "
    augroup load_us_insert
        autocmd!
        autocmd InsertEnter * call plug#load('lexima.vim') | autocmd! load_us_insert
    augroup END

    function! s:load_plug(timer)
        call plug#load(
        \ 'tcomment_vim',
        \ 'vim-trailing-whitespace',
        \ 'vim-repeat',
        \ 'vim-surround',
        \ 'vim-expand-region',
        \ 'auto-pairs',
        \ 'vim-snippets',
        \ 'vim-move',
        \ 'vim-gh-line',
        \ 'vim-indent-guides',
        \ 'vim-easymotion',
        \ 'vim-gitgutter',
        \ )
    endfunction

    call timer_start(100, function("s:load_plug"))
    colorscheme monokai
    hi Visual term=reverse cterm=reverse guibg=Grey

    if filereadable(expand('~/.nvimrc.local'))
        source ~/.nvimrc.local
    endif
endif

"-----------------------
" コマンド
"-----------------------
nnoremap ; :
nnoremap : m
nnoremap m ;
vnoremap ; :
vnoremap : m
vnoremap m ;

" 検索時に/をエjjスケープしない
cnoremap <expr> / (getcmdtype() == '/') ? '\/' : '/'

if has('nvim')
    function! OpenBufferNumber()
        let count = 0
        for i in range(0, bufnr("$"))
            if buflisted(i)
                let count += 1
            endif
        endfor
        return count
    endfunction

    function! CloseOnLast()
        if OpenBufferNumber() <= 1
            q
        else
            Bdelete
        endif
    endfunction

    nnoremap <silent> q :call CloseOnLast()<CR>
    nnoremap <silent> Q :q<CR>
else
    nnoremap <silent> q :q<CR>
endif

nnoremap <C-s> wa

" タグは使わない
noremap [Tag] <Nop>

" H,Lで行頭、行末に移動
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L $

" Select entire buffer
nnoremap vy ggVG " 検索後にジャンプした際に検索単語を画面中央に持ってくる
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

" expand region
vnoremap <C-v> <Plug>(expand_region_shrink)
vnoremap v <Plug>(expand_region_expand)

"-----------------------
" tで始まるショートカット
"-----------------------
nnoremap <silent> tp :<C-u>bprev<CR>
nnoremap <silent> tn :<C-u>bnext<CR>
nnoremap <silent> tz :<C-u>noh<CR>

" add newline at ,
nnoremap <silent> t, :<C-u>s/\((\zs\\|,\ *\zs\\|)\)/\r&/g<CR><Bar>:'[,']normal ==<CR>']'

set pastetoggle=t;

if has('nvim')
    " replace
    map <silent> <Space> <Plug>(operator-replace)

    " easymotion
    nmap , <Plug>(easymotion-s)

    " vaffle
    nnoremap <silent> tv :<C-u>Vaffle<CR>

    " open browser
    nmap <silent> tww <Plug>(openbrowser-smart-search)

    " gh line
    let g:gh_line_map = 'twg'

    " coc
    inoremap <silent><expr> <C-Space> coc#refresh()
    nmap <silent> th <Plug>(coc-diagnostic-prev)
    nmap <silent> tl <Plug>(coc-diagnostic-next)
    nmap <silent> t] <Plug>(coc-definition)
    nmap <silent> t} <Plug>(coc-type-definition)
    nmap <silent> t" <Plug>(coc-implementation)
    nmap <silent> t' <Plug>(coc-references)
    nmap <silent> tm <Plug>(coc-rename)
    nmap <silent> tt :<C-u>CocFormat<CR>
    nnoremap <silent> <C-d> :call <SID>show_documentation()<CR>
    inoremap <silent> <C-d> <ESC>:call <SID>show_documentation()<CR>

    " git
    nmap tj <Plug>(GitGutterPrevHunk)
    nmap tk <Plug>(GitGutterNextHunk)

    " fzf
    nnoremap <silent> to :<C-u>Clap files<CR>
    nnoremap <silent> te :<C-u>Clap buffers<CR>
    nnoremap <silent> tf :<C-u>Clap blines<CR>
    nnoremap <silent> tF :<C-u>Clap grep<CR>
    nnoremap <silent> ts :<C-u>Clap coc_symbols<CR>
    imap <c-f> <plug>(fzf-complete-path)
    imap <c-l> <plug>(fzf-complete-line)

    nnoremap gi :<C-u>Gdiff<CR>
    nnoremap gs :<C-u>Gstatus<CR>

    " go jump to symbol
    augroup SetGoShortcuts
        autocmd!
        autocmd FileType go nnoremap <silent> tr :<C-u>GoTestFunc<CR>
        autocmd FileType go nnoremap <silent> t/ /^\(func\\|type\)<CR>
        autocmd FileType go nnoremap <silent> twd :<C-u>GoDocBrowser<CR>
        autocmd FileType go nnoremap <silent> tx :<C-u>silent call go#expr#complete()<CR>
    augroup END
endif

" cheatsheet
" C-o go back to the original line
" daw delete outer
" ds" delete surronding "
" GoFmt GoTests
" _

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
