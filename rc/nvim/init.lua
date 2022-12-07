---@diagnostic disable: undefined-global
require('plenary.reload').reload_module('jy-config')
require('jy-config/plug').setup()

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

vim.cmd [[
syntax on
colorscheme tender
]]

vim.g.neovide_input_macos_alt_is_meta = true

-- font setting for gui
vim.o.guifont = 'Fira Code:h18'
-- Enable mouse support
vim.o.mouse = 'a'

vim.cmd [[
let Lsp_status = luaeval('require("lsp-status").status')
]]
-- Set statusline theme (via lightline)
vim.g.lightline =
{
  colorscheme = 'tender',
  active =
    {left = {{'mode', 'paste'},
             {'filename', 'readonly', 'modified'}, {'lsp'}}},
  component_function = {lsp='Lsp_status'}
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

-- Symbol highlight
vim.api.nvim_set_hl(0, 'LspReferenceText', {bg = '#555555'})

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

noremap('n', '<leader>E', ':Ntree<cr>')

-- use 'rg' as a grep program
if vim.fn.executable('rg') then
vim.o.grepprg = 'rg --color=never --vimgrep'
end

-- DAP configs
require('dap.lldb_vscode')
noremap_silent('n', '<leader>db', ":lua require'dap'.toggle_breakpoint()<cr>")
noremap_silent('n', '<leader>dB', ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>")
noremap_silent('n', '<leader>dl', ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>")
noremap_silent('n', '<leader>dr', ":lua require'dap'.repl.open()<cr>")

-- Snipet configs
vim.cmd [[
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
]]

-- Copy paste
noremap_silent({'n','i'}, '<D-v>', [[<C-\><C-o>"+p]])
