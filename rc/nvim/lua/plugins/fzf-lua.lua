---@type LazySpec
return {
  "ibhagwan/fzf-lua",
  opts = {
    grep = {
      actions = {
        ["ctrl-h"] = {require("fzf-lua.actions").toggle_hidden},
        ["ctrl-g"] = {require("fzf-lua.actions").toggle_ignore},
        ["ctrl-r"] = {require("fzf-lua.actions").grep_lgrep},
      }
    }
  },
  config = function (_, opts)
    vim.keymap.del('t', '<C-h>')
    require("fzf-lua").setup(opts)
  end,
  keys = {
    {"<Leader>fa", function() require'fzf-lua'.files({cwd="~/.config/nvim"}) end, desc = "Find config files"},
    {"<Leader>ff", function() require'fzf-lua'.files() end, desc = "Find files"},
    {"<Leader>f/", function() require'fzf-lua'.blines({resume=true}) end, desc = "Find words in current buffer"},
    {"<Leader>f?", function() require'fzf-lua'.lines({resume=true}) end, desc = "Find words buffers"},
    {"<Leader>fw", function() require'fzf-lua'.live_grep({resume=true}) end, desc = "Find words"},
    {"<Leader>fc", function() require'fzf-lua'.grep_cword() end, desc = "Find word under cursor"},
    {"<Leader>fk", function() require'fzf-lua'.keymaps() end, desc = "Find keymaps"},
    {"<Leader>fh", function() require'fzf-lua'.helptags() end, desc = "Find help"},
    {"<Leader>fm", function() require'fzf-lua'.manpages() end, desc = "Find man"},
  }
}
