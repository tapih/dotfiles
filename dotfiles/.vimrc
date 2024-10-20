let g:loaded_gzip = 1
let g:loaded_man = 1
let g:loaded_matchit = 1
let g:loaded_matchparen = 1
let g:loaded_shada_plugin = 1
let g:loaded_tarPlugin = 1
let g:loaded_tar = 1
let g:loaded_zipPlugin = 1
let g:loaded_zip = 1
let g:loaded_netrwPlugin = 1

filetype plugin indent on
syntax on

colorscheme slate

set ruler

set encoding=UTF-8
set cursorline
set showmode
set hidden
set nobackup
set noswapfile
set noundofile
set splitright
set splitbelow
set incsearch
set hlsearch
set smartcase
set ignorecase
set wildmenu
set autoindent
set smartindent
set showmatch
set laststatus=2
set scrolloff=8
set noerrorbells
set pastetoggle=<C-b>
set clipboard=unnamedplus
set nrformats-=octal

au InsertLeave * set nopaste
au FileType * set formatoptions-=cro
au BufReadPost * if line("'\"") > 0 && line ("'\"") <= line("$") | exe "normal g'\"" | endif

set shiftwidth=0
set softtabstop=2
set tabstop=2
set expandtab

au FileType go        setlocal sw=0 sts=4 ts=4
au FileType dart      setlocal sw=0 sts=2 ts=2 et
au FileType python    setlocal sw=0 sts=4 ts=4 et
au FileType yaml      setlocal sw=0 sts=2 ts=2 et
au FileType terraform setlocal sw=0 sts=2 ts=2 et

nnoremap <silent> <CR> :w<CR>
nnoremap q :q<CR>
nnoremap z :qa<CR>
nnoremap <silent> <C-q> :noh<CR>
nnoremap <C-y> <C-v>
nnoremap U <C-r>
nnoremap vy ggVG
nnoremap j gj
nnoremap k gk
