local Plug = require 'jy-config/plug'

local is_in_vscode = vim.g.vscode ~= nil

Plug.begin(vim.fn['stdpath']('data') .. '/plugged')
-- Plugins {{{
---- Utility functions for lua
Plug 'nvim-lua/plenary.nvim'
---- LSP related plugins
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
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
---- EditorConfig plugin
Plug 'editorconfig/editorconfig-vim'
---- DAP plugin
Plug 'mfussenegger/nvim-dap'
-- }}}
Plug.ends()

-- Plugin setups{{
require("mason").setup()
require("mason-lspconfig").setup()
-- Setup LSP server using lspconfig AFTER HERE
require("lspconfig").erlangls.setup{}
-- Setup LSP end
require("jy-config/nvim_cmp").setup()
-- }}

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

  -- font setting for gui
  vim.o.guifont = 'Fira Code:h18'
  -- Enable mouse support
  vim.o.mouse = 'a'

  vim.g.CocCurrentFunction = function()
    return vim.b.coc_current_function or ''
  end
  -- Set statusline theme (via lightline)
  vim.g.lightline =
    {
      colorscheme = 'tender',
      active =
        {left = {{'mode', 'paste'},
                 {'filename', 'cocstatus', 'currentfunction', 'readonly', 'modified'}}},
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

  -- Copy to clipboard
  noremap({'n','v'}, 'Y', '"*y')

  vim.o.updatetime = 300

  if not string.find(vim.o.shortmess, 'c') then
      vim.o.shortmess = vim.o.shortmess .. 'c'
  end

  -- open a terminal in a new window
  vim.api.nvim_create_user_command('NewTerm', 'new | term', {nargs = 0})

  -- Navigate vim tabs
  noremap('n', '<c-q>l', ':tabnext<cr>')
  noremap('n', '<c-q><c-l>', ':tabnext<cr>')
  noremap('n', '<c-q>h', ':tabprevious<cr>')
  noremap('n', '<c-q><c-h>', ':tabprevious<cr>')
  noremap('n', '<c-q>n', ':tabnew<cr>')
  noremap('n', '<c-q><c-n>', ':tabnew<cr>')

  noremap('n', '<leader>ev', ':vsplit $MYVIMRC<cr>')
  noremap('n', '<leader>sv', ':source $MYVIMRC<cr>')

  -- use 'rg' as a grep program
  if vim.fn.executable('rg') then
    vim.o.grepprg = 'rg --color=never --vimgrep'
  end

  -- Add a command to delete buffers
  vim.cmd [[
  function! s:list_buffers()
    redir => list
    silent ls
    redir END
    return split(list, "\n")
  endfunction

  function! s:delete_buffers(lines)
    execute 'bwipeout' join(map(a:lines, {_, line -> split(line)[0]}))
  endfunction

  command! BD call fzf#run(fzf#wrap({
    \ 'source': s:list_buffers(),
    \ 'sink*': { lines -> s:delete_buffers(lines) },
    \ 'options': '--multi --reverse --bind ctrl-a:select-all+accept'
  \ }))
  ]]

  -- Fzf related command mappings
  noremap('n', '<leader>]w', ':Windows<cr>')
  noremap('n', '<leader>]r', ':Rg ')
  noremap('n', '<leader>]c', ':Commands<cr>')
  noremap('n', '<leader>]e', '<c-w>v:Explore<cr>') -- this one is not related to fzf, but it works similarly
  noremap('n', '<leader>]f', ':Files<cr>')
  noremap('n', '<leader>]b', ':Buffers<cr>')
  noremap('n', '<leader>]ll', ':Lines<cr>')
  noremap('n', '<leader>]lb', ':BLines<cr>')

  -- lists.vim setting
  vim.g.lists_filetypes = {'wiki', 'markdown'}

  -- DAP configs
  require('dap.lldb_vscode')
  noremap_silent('n', '<leader>db', ":lua require'dap'.toggle_breakpoint()<cr>")
  noremap_silent('n', '<leader>dB', ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>")
  noremap_silent('n', '<leader>dl', ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>")
  noremap_silent('n', '<leader>dr', ":lua require'dap'.repl.open()<cr>")
end
