syntax enable
filetype plugin indent on
set encoding=utf-8
set relativenumber
set number
set number
set relativenumber
set scrolloff=10
set cursorline
set splitbelow
set splitright
set ruler
set showmatch
set lazyredraw
set foldmethod=manual
set infercase
set backspace=eol,indent,start
set virtualedit=block
set smarttab
set expandtab
set softtabstop=0
set showcmd
set hlsearch
set nowrapscan
set ignorecase
set smartcase
set iskeyword+=-
set fileformats=unix,dos,mac
set ambiwidth=double
set nobackup nowritebackup
set noswapfile
set hidden
set colorcolumn=80
set list listchars=tab:>-,trail:-,nbsp:%,eol:$
set iskeyword=/
set visualbell t_vb=
set conceallevel=0
set autoindent
set shiftwidth=4
set tabstop=4
set updatetime=250
set inccommand=split

augroup SetYAMLIndent
    autocmd!
    autocmd FileType yaml setlocal sw=2 sts=2 ts=2 et
augroup END

augroup DisableAutoComment
    autocmd!
    autocmd FileType * set fo-=cro
augroup END

augroup AutoPclose
    autocmd!
    autocmd InsertLeave * silent! pclose!
augroup END

augroup AutoNoPaste
    autocmd!
    autocmd InsertLeave * set nopaste
augroup END

augroup OpenAtLastClosed
    autocmd!
    autocmd BufRead * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif
augroup END

augroup DisableGitFold
    autocmd!
    autocmd FileType git setlocal nofoldenable foldlevel=0
augroup END

augroup GoHighlight
    autocmd FileType go :highlight goErr cterm=bold ctermfg=214
    autocmd FileType go :match goErr /\<err\>/
augroup END

" function
function! AutoCloseBuf()
    if len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
        :q
    else
        :bd
    endif
endfunction

function! Replace()
    let s:word = input("Replace " . expand('<cword>') . " with:")
    :exe 'bufdo! %s/\<' . expand('<cword>') . '\>/' . s:word . '/gce'
    :unlet! s:word
endfunction

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
        bd
    endif
endfunction

function! OpenBrowser(url)
    if has('unix')
        exe '!open ' . a:url
    else
        exe '!xdg-open ' . a:url
    endif
endfunction

" plug
let g:plug_dir = expand('~/.cache/plug')
let g:plug_window = 'new'

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin(g:plug_dir)

Plug 'sickill/vim-monokai'
Plug 'itchyny/lightline.vim'
Plug 'ap/vim-buftabline'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'

Plug 'sheerun/vim-polyglot'
Plug 'kana/vim-operator-replace'
Plug 'kana/vim-operator-user'
Plug 'kana/vim-textobj-user'
Plug 'coderifous/textobj-word-column.vim'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'roxma/vim-tmux-clipboard'
Plug 'airblade/vim-rooter'
Plug 'mhinz/vim-startify'
Plug 'bronson/vim-trailing-whitespace', {'on': []}

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'airblade/vim-gitgutter', {'on': []}
Plug 'tpope/vim-fugitive'
Plug 'rhysd/committia.vim'
Plug 'itchyny/vim-gitbranch'

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets', {'on': []}
Plug 'buoto/gotests-vim', {'for': 'go', 'on': ['GoTests', 'GoTestsAll']}
Plug '110y/vim-go-expr-completion', {'branch': 'master'}
Plug 'mattn/vim-goimports', {'for': 'go'}
Plug 'dart-lang/dart-vim-plugin', {'for': 'dart'}
Plug 'thosakwe/vim-flutter', {'for': 'dart'}
Plug 'reisub0/hot-reload.vim', {'for': 'dart'}
Plug 'hynek/vim-python-pep8-indent', {'for': 'python'}
Plug 'godlygeek/tabular', {'for': 'markdown'}
Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' , 'for': 'markdown' }
Plug 'ekalinin/Dockerfile.vim', {'for': 'Dockerfile'}
Plug 'hashivim/vim-terraform', {'for': 'tf'}
Plug 'uarun/vim-protobuf', {'for': 'proto'}
Plug 'yasuhiroki/github-actions-yaml.vim', {'for': 'yaml'}
Plug 'xavierchow/vim-swagger-preview', {'for': 'yaml'}
Plug 'google/vim-jsonnet', {'for': 'jsonnet'}
Plug 'andrewstuart/vim-kubernetes', {'for': 'yaml'}
Plug 'cespare/vim-toml', {'for': 'toml'}
Plug 'chr4/nginx.vim', {'for': 'nginx'}
Plug 'tmux-plugins/vim-tmux', {'for': 'tmux'}
Plug 'alvan/vim-closetag', {'for': 'html'}
Plug 'hail2u/vim-css3-syntax', {'for': 'css'}
Plug 'weirongxu/plantuml-previewer.vim'
Plug 'mattn/emmet-vim', {'for': 'html'}
Plug 'tpope/vim-dadbod', { 'on': 'DB' }
Plug 'kristijanhusak/vim-dadbod-ui', { 'on': 'DBUIAddConnection' }

Plug 'junegunn/vim-easy-align', {'on': 'EasyAlign'}
Plug 'cohama/lexima.vim', {'on': []}
Plug 'tomtom/tcomment_vim', {'on': []}
Plug 'tpope/vim-repeat', {'on': []}
Plug 'tpope/vim-surround', {'on': []}
Plug 'jiangmiao/auto-pairs', {'on': []}
Plug 'mattn/vim-sonictemplate', {'on': 'Template'}
Plug 'matze/vim-move', {'on': []}
Plug 'cocopon/vaffle.vim', {'on': 'Vaffle'}
Plug 'brooth/far.vim', {'on': ['Far', 'Farr']}
Plug 'nathanaelkane/vim-indent-guides', { 'on': [] }
Plug 'easymotion/vim-easymotion', {'on': []}
Plug 'vim-scripts/loremipsum'
Plug 'ruanyl/vim-gh-line', {'on': []}
Plug 'tyru/open-browser.vim', {'on': [ 'OpenBrowser', 'OpenBrowserSearch', 'OpenBrowserSmartSearch' ]}
Plug 'tyru/open-browser-github.vim', {'on': [ 'OpenGithubFile', 'OpenGithubIssue', 'OpenGithubPullReq', 'OpenGithubProject' ]}

call plug#end()

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

" color
colorscheme monokai
hi Visual term=reverse cterm=reverse guibg=Grey

" ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-g>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" far
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

" indent guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1

" easymotion
let g:EasyMotion_keys = 'fjdkslaureiwoqpvncm'
let g:EasyMotion_startofline = 0

" dart
let g:lsc_auto_map = v:false

" markdown
let g:vim_markdown_folding_disabled = 1
let g:mkdp_browserfunc = 'OpenBrowser'

" git
let g:gitgutter_sign_added = '✚'
let g:gitgutter_sign_modified = '✹'
let g:gitgutter_sign_removed = '✖'
let g:gitgutter_sign_removed_first_line = '✖'
let g:gitgutter_sign_modified_removed = '✖'

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

" lightline
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

" shortcuts
noremap [Tag] <Nop>

nnoremap ; :
nnoremap : m
nnoremap m ;
vnoremap ; :
vnoremap : m
vnoremap m ;
nnoremap <CR> :<C-u>w<CR>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
nnoremap <C-y> <C-v>
nnoremap <C-r> <Nop>
nnoremap U <C-r>
nnoremap <silent> q :call CloseOnLast()<CR>
nnoremap <silent> Q :q<CR>
nnoremap j gj
nnoremap k gk
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L $
nnoremap vy ggVG
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz
cnoremap <expr> / (getcmdtype() == '/') ? '\/' : '/'
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>
map      <silent> <Space> <Plug>(operator-replace)
nmap     , <Plug>(easymotion-s)
set pastetoggle=<C-b>

nnoremap <silent> tp :<C-u>bprev<CR>
nnoremap <silent> tn :<C-u>bnext<CR>
nnoremap <silent> tz :<C-u>noh<CR>
nnoremap <silent> t, :<C-u>s/\((\zs\\|,\ *\zs\\|)\)/\r&/g<CR><Bar>:'[,']normal ==<CR>']'
nnoremap <silent> tv :<C-u>Vaffle<CR>
nnoremap <silent> td :<C-u>Gdiff<CR>
nnoremap <silent>to :<C-u>Telescope find_files<cr>
nnoremap <silent>te :<C-u>Telescope buffers<cr>
nnoremap <silent>tf :<C-u>Telescope live_grep<cr>
nnoremap <silent>ts :<C-u>CocList symbols<CR>
nmap     <silent> tj <Plug>(GitGutterPrevHunk)
nmap     <silent> tk <Plug>(GitGutterNextHunk)
nmap     <silent> tb <Plug>(openbrowser-smart-search)
let g:gh_line_map = 'twg'

augroup SetYAMLShortcuts
    autocmd!
    autocmd FileType yaml nmap <unique> twd <Plug>GenerateDiagram
augroup END

augroup SetGoShortcuts
    autocmd!
    autocmd FileType go nnoremap <silent> t/ /^\(func\\|type\)<CR>
    autocmd FileType go nnoremap <silent> tr :<C-u>GoTestFunc<CR>
    autocmd FileType go nnoremap <silent> twd :<C-u>GoDocBrowser<CR>
    autocmd FileType go nnoremap <silent> tx :<C-u>silent call go#expr#complete()<CR>
augroup END

augroup SetMdShortcuts
    autocmd!
    autocmd FileType markdown nnoremap <silent> twd :<C-u>MarkdownPreview<CR><CR>
    autocmd FileType markdown nnoremap <silent> tx :<C-u>TableFormat<CR>
augroup END

if filereadable(expand('~/.nvimrc.local'))
    source ~/.nvimrc.local
endif

