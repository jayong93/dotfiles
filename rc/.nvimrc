" Function for conditional plugin loading
function! Cond(Cond, ...)
  let opts = get(a:000, 0, {})
  return a:Cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

" Start plugin definitions
call plug#begin(stdpath('data') . '/plugged')

"" CoC plugin
Plug 'neoclide/coc.nvim', Cond(!exists('g:vscode'), {'branch': 'release'})
"" Onehalf Theme
Plug 'sonph/onehalf', Cond(!exists('g:vscode'), { 'rtp': 'vim' })
"" Zenburn theme (low contrast)
Plug 'jnurmine/Zenburn', Cond(!exists('g:vscode'))
"" Fuzzy finder
Plug 'junegunn/fzf', Cond(!exists('g:vscode'), { 'do': { -> fzf#install() } })
Plug 'junegunn/fzf.vim', Cond(!exists('g:vscode'))
"" Surround
Plug 'tpope/vim-surround'
"" Plugin for statusline/tabline
Plug 'itchyny/lightline.vim', Cond(!exists('g:vscode'))
"" Commening plugin
Plug 'tpope/vim-commentary', Cond(!exists('g:vscode'))
"" Git plugin
Plug 'tpope/vim-fugitive'

" End plugin definitions
call plug#end()

if !exists('g:vscode')
    set t_Co=256

    syntax on

    " Set nvim theme
    colorscheme zenburn
    " Set statusline theme (via lightline)
    let g:lightline = {
                \ 'colorscheme': 'wombat',
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
    " show relative linenumber
    set rnu

    " mode information is not needed anymore because of lightline plugin
    set noshowmode

    " make the current word uppercase in insert mode
    inoremap <c-u> <esc>viwUea
    " make the current word uppercase in normal mode
    nnoremap <c-u> viwU

    " open vimrc
    nnoremap <leader>ev :vsplit $MYVIMRC<cr>
    " source vimrc
    nnoremap <leader>sv :source $MYVIMRC<cr>
endif
