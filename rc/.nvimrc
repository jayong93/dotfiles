" Function for conditional plugin loading
function! Cond(Cond, ...)
  let opts = get(a:000, 0, {})
  return a:Cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

" Start plugin definitions
call plug#begin(stdpath('data') . '/plugged')

" Plugins {{{
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
"" Bracket auto pairing
Plug 'jiangmiao/auto-pairs', Cond(!exists('g:vscode'))
" }}}

" End plugin definitions
call plug#end()

if !exists('g:vscode')
    set t_Co=256

    " Syntax highlighting
    syntax on

    " Mouse support. check ':h mouse'
    " set mouse=nv

    " Set nvim theme
    colorscheme zenburn
    " Set statusline theme (via lightline)
    let g:lightline = {
                \ 'colorscheme': 'wombat',
                \ }

    " Close all fold when start editing
    set foldlevelstart=0

" Color Setting {{{
    " Enable true colors if available
    if exists('+termguicolors')
      let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
      let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
      set termguicolors
    endif
" }}}

" Tab Settings {{{
    " whitespaces for one '\t' char 
    set tabstop=4
    " whitespaces for level of indentation
    set shiftwidth=4
    " change '\t' char to spaces
    set expandtab
    " whitespaces for one Tab keypress
    set softtabstop=4
" }}}

" Line Number Settings {{{
    " show linenumber
    set nu
    " show relative linenumber
    set rnu
" }}}

    " mode information is not needed anymore because of lightline plugin
    set noshowmode

    " make the current word uppercase in insert mode
    inoremap <c-u> <esc>viwUea

    " open vimrc
    nnoremap <leader>ev :vsplit $MYVIMRC<cr>
    " source vimrc
    nnoremap <leader>sv :source $MYVIMRC<cr>

" Vimscript File Settings {{{
    augroup filetype_vim
        autocmd!
        autocmd FileType vim setlocal foldmethod=marker
    augroup END
" }}}

" Coc.nvim Key Mappings {{{
    " Show symbol info
    nnoremap <silent> K :call <SID>show_documentation()<CR>
    function! s:show_documentation()
        if (index(['vim', 'help'], &filetype) >= 0)
            execute 'h' expand('<cword>')
        else
            call CocAction('doHover')
        endif
    endfunction

    " Do quick actions
    nnoremap <silent> <c-a> :CocAction<CR>
    
    " Close float with Ctrl-C
    nnoremap <silent><nowait><expr> <c-c> coc#float#has_float() ? coc#float#close_all() : "\<c-c>"

    " Diagnostics navigation
    nmap <silent> [g <plug>(coc-diagnostic-prev)
    nmap <silent> ]g <plug>(coc-diagnostic-next)

    " Code navigation
    nmap <silent> gd <plug>(coc-definition)
    nmap <silent> gy <plug>(coc-type-definition)
    nmap <silent> gi <plug>(coc-implementation)
    nmap <silent> gr <plug>(coc-references)

    " Renaming
    nmap <leader>rn <plug>(coc-rename)

    " Format code
    nmap <leader>f <plug>(coc-format-selected)
    xmap <leader>f <plug>(coc-format-selected)

    " Actions
    xmap <leader>a <plug>(coc-codeaction-selected)
    nmap <leader>a <plug>(coc-codeaction-selected)
    nmap <leader>ac <plug>(coc-codeaction)
    nmap <leader>qf <plug>(coc-fix-current)
    nmap <leader>cl <plug>(coc-codelens-action)

    " Make Ctrl-r trigger completion
    inoremap <silent><expr> <c-r> coc#refresh()

    " Make <tab> completion confirm, snippet expand {{{
	inoremap <silent><expr> <TAB>
	  \ pumvisible() ? coc#_select_confirm() :
      \ "\<tab>"

    " }}}
" }}}

    " open a terminal in a new window
    command NewTerm new | term

    " Navigate vim tabs
    nnoremap <c-q>n :tabnext<cr>
    nnoremap <c-q>p :tabprevious<cr>

    " use 'rg' as a grep program
    if executable('rg')
        set grepprg=rg\ --color=never\ --vimgrep
    endif
endif
