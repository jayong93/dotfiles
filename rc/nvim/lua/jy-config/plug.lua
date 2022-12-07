local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return {
  setup = function()
    require('packer').startup(function(use)
      use 'wbthomason/packer.nvim'
      -- My plugins here

      ---- Utility functions for lua
      use 'nvim-lua/plenary.nvim'
      ---- LSP related plugins
      use 'neovim/nvim-lspconfig'
      use {'williamboman/mason.nvim',
          config=function() require("mason").setup() end}
      use {'williamboman/mason-lspconfig.nvim',
          config=function() require("mason-lspconfig").setup() end}
      use {'nvim-lua/lsp-status.nvim',
          config=function () require("lsp-status").register_progress() end}
      use 'hrsh7th/cmp-nvim-lsp'
      use 'hrsh7th/cmp-buffer'
      use 'hrsh7th/cmp-path'
      use 'hrsh7th/cmp-cmdline'
      use {'hrsh7th/nvim-cmp',
          config=function() require("jy-config.nvim_cmp").setup({}) end}
      use {'glepnir/lspsaga.nvim', branch='main',
          config=function() require("jy-config.saga").setup() end}
      ---- Snipets
      use 'hrsh7th/cmp-vsnip'
      use 'hrsh7th/vim-vsnip'
      use 'rafamadriz/friendly-snippets'
      ---- Tender theme
      use 'jacoborus/tender.vim'
      ---- Fuzzy finder
      use {'ibhagwan/fzf-lua',
          config=function() require("jy-config.fuzzy-finder").setup() end}
      ---- Surround
      use 'tpope/vim-surround'
      ---- statusline/tabline
      use 'itchyny/lightline.vim'
      ---- Commening plugin
      use 'tpope/vim-commentary'
      ---- Git plugin
      use 'tpope/vim-fugitive'
      ---- Bracket auto pairing
      use 'jiangmiao/auto-pairs'
      ---- EditorConfig plugin
      use 'editorconfig/editorconfig-vim'
      ---- DAP plugin
      use 'mfussenegger/nvim-dap'
      ---- Auto session manage
      use {'rmagatti/auto-session',
          config=function() require("auto-session").setup {
              log_level="error",
              auto_session_suppress_dirs={"~/", "/"}
          } end}
      ---- Project managemant
      use {'ahmedkhalf/project.nvim',
          config = function()
              require("project_nvim").setup{
                  scope_chdir="tab",
                  datapath=vim.fn.stdpath("data")
              }
          end}

      -- Automatically set up your configuration after cloning packer.nvim
      -- Put this at the end after all plugins
      if packer_bootstrap then
          require('packer').sync()
      end
    end)
  end
}

