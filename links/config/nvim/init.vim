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

function! GlobalChangedLines(ex_cmd)
  for hunk in GitGutterGetHunks()
    for lnum in range(hunk[2], hunk[2]+hunk[3]-1)
      let cursor = getcurpos()
      silent! execute lnum.a:ex_cmd
      call setpos('.', cursor)
    endfor
  endfor
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

Plug 'airblade/vim-rooter'
Plug 'mhinz/vim-startify'
Plug 'sainnhe/sonokai'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'karb94/neoscroll.nvim'
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'romgrk/barbar.nvim'
Plug 'ap/vim-buftabline'
Plug 'famiu/feline.nvim'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'sindrets/diffview.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'jeffkreeftmeijer/vim-numbertoggle'

Plug 'neovim/nvim-lspconfig'
Plug 'onsails/lspkind-nvim'
Plug 'hrsh7th/nvim-compe'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'fhill2/telescope-ultisnips.nvim'
Plug 'pwntester/octo.nvim'
Plug 'windwp/nvim-spectre'
Plug 'dyng/ctrlsf.vim'
Plug 'kevinhwang91/nvim-hlslens'

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'rhysd/committia.vim'
Plug 'itchyny/vim-gitbranch'
Plug 'sindrets/diffview.nvim'

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

Plug 'kana/vim-operator-replace'
Plug 'kana/vim-operator-user'
Plug 'kana/vim-textobj-user'
Plug 'coderifous/textobj-word-column.vim'
Plug 'haoren/vim-wordmotion'

Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'roxma/vim-tmux-clipboard'

Plug 'windwp/nvim-autopairs'
Plug 'junegunn/vim-easy-align', {'on': 'EasyAlign'}
Plug 'cohama/lexima.vim'
Plug 'JoosepAlviste/nvim-ts-context-commentstring'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'mattn/vim-sonictemplate', {'on': 'Template'}
Plug 'matze/vim-move'
Plug 'easymotion/vim-easymotion'
Plug 'andymass/vim-matchup'
Plug 'bronson/vim-trailing-whitespace'
Plug 'tpope/vim-commentary'
Plug 'folke/todo-comments.nvim'

Plug 'ruanyl/vim-gh-line'
Plug 'tyru/open-browser.vim', {'on': [ 'OpenBrowser', 'OpenBrowserSearch', 'OpenBrowserSmartSearch' ]}
Plug 'tyru/open-browser-github.vim', {'on': [ 'OpenGithubFile', 'OpenGithubIssue', 'OpenGithubPullReq', 'OpenGithubProject' ]}

Plug 'sheerun/vim-polyglot'
Plug 'buoto/gotests-vim', {'for': 'go', 'on': ['GoTests', 'GoTestsAll']}
Plug '110y/vim-go-expr-completion', {'branch': 'master'}
Plug 'mattn/vim-goimports', {'for': 'go'}
Plug 'dart-lang/dart-vim-plugin', {'for': 'dart'}
Plug 'thosakwe/vim-flutter', {'for': 'dart'}
Plug 'akinsho/flutter-tools.nvim'
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
Plug 'vim-scripts/loremipsum'

call plug#end()

" color
colorscheme sonokai
hi Visual term=reverse cterm=reverse guibg=Grey

" ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-g>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

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
command -nargs=1 Glines call GlobalChangedLines(<q-args>)

" shortcuts
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
nnoremap <silent> to :<C-u>Telescope find_files<cr>
nnoremap <silent> te :<C-u>Telescope buffers<cr>
nnoremap <silent> tf :<C-u>Telescope live_grep<cr>
nnoremap <silent> ts :<C-u>CocList symbols<CR>
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

