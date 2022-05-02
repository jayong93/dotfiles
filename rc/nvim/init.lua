local Plug = require 'plug'

local is_in_vscode = vim.g.vscode ~= nil

Plug.begin(vim.fn['stdpath']('data') .. '/plugged')
-- Plugins {{{
---- CoC plugin
Plug('neoclide/coc.nvim', Plug.cond(not is_in_vscode, {branch = 'release'}))
---- Tender theme
Plug 'jacoborus/tender.vim'
---- Fuzzy finder
Plug('junegunn/fzf', Plug.cond(not is_in_vscode, {run = function() vim.fn['fzf#install']() end}))
Plug('junegunn/fzf.vim', Plug.cond(not is_in_vscode))
---- Surround
Plug 'tpope/vim-surround'
---- Plugin for statusline/tabline
Plug('itchyny/lightline.vim', Plug.cond(not is_in_vscode))
---- Commening plugin
Plug('tpope/vim-commentary', Plug.cond(not is_in_vscode))
---- Git plugin
Plug 'tpope/vim-fugitive'
---- Bracket auto pairing
Plug('jiangmiao/auto-pairs', Plug.cond(not is_in_vscode))
-- }}}
Plug.ends()

local function noremap(mode, key, cmd, opt)
  opt = opt or vim.empty_dict()
  opt.noremap = true
  vim.keymap.set(mode, key, cmd, opt)
end

local function noremap_silent(mode, key, cmd, opt)
  opt = opt or vim.empty_dict()
  opt.silent = true
  noremap(mode, key, cmd, opt)
end

local function map(mode, key, cmd, opt)
  vim.keymap.set(mode, key, cmd, opt)
end

local function map_silent(mode, key, cmd, opt)
  opt = opt or vim.empty_dict()
  opt.silent = true
  map(mode, key, cmd, opt)
end

if not is_in_vscode then
  vim.cmd [[
    syntax on
    colorscheme tender
  ]]

  vim.g.CocCurrentFunction = function()
    return vim.b.coc_current_function or ''
  end
  -- Set statusline theme (via lightline)
  vim.g.lightline =
    {
      colorscheme = 'tender',
      active =
        {left = {{'mode', 'paste'},
                 {'cocstatus', 'currentfunction', 'readonly', 'filename', 'modified'}}},
      component_function =
        {cocstatus = 'coc#status', currentfunction='CocCurrentFunction'}
    }
  vim.o.foldlevelstart = 0
  -- Color Setting {{{
  -- Enable true colors if available
  if vim.fn['exists']('+termguicolors') then
    vim.cmd [[
      let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
      let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    ]]
    vim.o.termguicolors = true
  end
  -- }}}

  -- Tab Settings {{{
  -- whitespaces for one '\t' char 
  vim.o.tabstop=4
  -- whitespaces for level of indentation
  vim.o.shiftwidth=4
  -- change '\t' char to spaces
  vim.o.expandtab = true
  -- whitespaces for one Tab keypress
  vim.o.softtabstop=4
  -- }}}

  -- Line Number Settings {{{
  -- show linenumber
  vim.o.nu = true
  -- show relative linenumber
  vim.o.rnu = true
  -- }}}
  -- mode information is not needed anymore because of lightline plugin
  vim.o.showmode = false

  noremap('i', '<c-u>', '<esc>viwUea')
  noremap_silent('n', 'K', [[:lua require('coc_util').show_document()<CR>]])

  noremap_silent('n', '<c-a>', ':CocAction<CR>')
  -- Close float with Ctrl-C
  noremap_silent('n', '<c-c>', [[coc#float#has_float() ? coc#float#close_all() : "\<c-c>"]], {nowait=true, expr=true})

  -- Diagnostics navigation
  map_silent('n', '[g', '<plug>(coc-diagnostic-prev)')
  map_silent('n', ']g', '<plug>(coc-diagnostic-next)')

  -- Code navigation
  map_silent('n', 'gd', '<plug>(coc-definition)')
  map_silent('n', 'gy', '<plug>(coc-type-definition)')
  map_silent('n', 'gi', '<plug>(coc-implementation)')
  map_silent('n', 'gr', '<plug>(coc-references)')

  -- Renaming
  map('n', '<leader>rn', '<plug>(coc-rename)')

  -- Format code
  map('n', '<leader>f', '<plug>(coc-format)')
  map('x', '<leader>f', '<plug>(coc-format-selected)')

  -- Actions
  map('x', '<leader>a', '<plug>(coc-codeaction-selected)')
  map('n', '<leader>a', '<plug>(coc-codeaction-selected)')
  map('n', '<leader>ac', '<plug>(coc-codeaction)')
  map('n', '<leader>qf', '<plug>(coc-fix-current)')
  map('n', '<leader>cl', '<plug>(coc-codelens-action)')

  -- Make Ctrl-r trigger completion
  noremap_silent('i', '<c-r>', 'coc#refresh()', {expr = true})
  noremap_silent('i', '<TAB>', [[pumvisible() ? coc#_select_confirm() : "\<tab>"]], {expr=true})

  -- Scroll floating window
  noremap_silent('n', '<c-u>', [[coc#float#has_scroll() ? coc#float#scroll(0) : "\<c-u>"]], {expr=true})
  noremap_silent('n', '<c-d>', [[coc#float#has_scroll() ? coc#float#scroll(1) : "\<c-d>"]], {expr=true})

  -- Close floating window with ESC
  noremap_silent('n', '<esc>', [[coc#float#has_float() ? coc#float#close_all() : "\<esc>"]], {expr=true})

  -- open a terminal in a new window
  vim.api.nvim_create_user_command('NewTerm', 'new | term', {nargs = 0})

  -- Navigate vim tabs
  noremap('n', '<c-q>n', ':tabnext<cr>')
  noremap('n', '<c-q>p', ':tabprevious<cr>')

  noremap('n', '<leader>ev', ':vsplit $MYVIMRC<cr>')
  noremap('n', '<leader>sv', ':source $MYVIMRC<cr>')

  -- use 'rg' as a grep program
  if vim.fn.executable('rg') then
    vim.o.grepprg = 'rg --color=never --vimgrep'
  end

  -- Change Coc inlay hint color
  vim.api.nvim_set_hl(0, 'CocHintSign', {fg = '#aaaaaa'})
end
