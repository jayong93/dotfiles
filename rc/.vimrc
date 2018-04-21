" vim-plug setting
call plug#begin('~/.vim/plugged')
Plug 'dracula/vim', { 'as': 'dracula' }
call plug#end()

syntax on
colorscheme dracula
set autoindent
set nu
set rnu
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set ignorecase
set smarttab
set scrolloff=7
set incsearch
set autoread
set lazyredraw
set history=1000
set nobackup
set noswapfile
filetype indent on

set fileencodings=utf8,euc-kr
