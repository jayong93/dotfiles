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
"" Fuzzy finder
Plug 'junegunn/fzf', Cond(!exists('g:vscode'), { 'do': { -> fzf#install() } })
Plug 'junegunn/fzf.vim', Cond(!exists('g:vscode'))
"" Surround
Plug 'tpope/vim-surround'
"" Plugin for statusline/tabline
Plug 'itchyny/lightline.vim', Cond(!exists('g:vscode'))
"" Commening plugin
Plug 'tpope/vim-commentary', Cond(!exists('g:vscode'))

" End plugin definitions
call plug#end()

if !exists('g:vscode')

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

endif
