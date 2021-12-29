" Start plugin definitions
call plug#begin(stdpath('data') . '/plugged')

"" CoC plugin
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"" Onehalf Theme
Plug 'sonph/onehalf', { 'rtp': 'vim' }
"" Fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
"" Surround
Plug 'tpope/vim-surround'
"" Plugin for statusline/tabline
Plug 'itchyny/lightline.vim'

" End plugin definitions
call plug#end()

syntax on

" Set nvim theme
colorscheme onehalfdark
" Set statusline theme (via lightline)
let g:lightline = {
            \ 'colorscheme': 'one',
            \ }

" Enable true colors if available
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" tab settings
"" whitespaces for one '\t' char 
set tabstop=4
"" whitespaces for level of indentation
set shiftwidth=4
"" change '\t' char to spaces
set expandtab
"" whitespaces for one Tab keypress
set softtabstop=4

" show linenumber
set nu

" mode information is not needed anymore because of lightline plugin
set noshowmode
