" vim-plug setting
call plug#begin('~/.vim/plugged')
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/syntastic'
Plug 'jiangmiao/auto-pairs'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter'
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
set showcmd
filetype indent on

set fileencodings=utf8,euc-kr

" vim 상단에 버퍼들 표시
let g:airline#extensions#tabline#enabled=1

" syntastic 설정
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=0
let g:syntastic_python_checkers=['pylint']
let g:syntastic_python_pylint_exec="pylint3"
let g:syntastic_python_pylint_args="-E"
