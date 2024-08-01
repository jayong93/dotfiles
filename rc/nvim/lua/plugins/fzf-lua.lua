---@type LazySpec
return {
  "ibhagwan/fzf-lua",
  opts = {},
  keys = {
    {"<Leader>fa", function() require'fzf-lua'.files({cwd="~/.config/nvim"}) end, desc = "Find config files"},
    {"<Leader>ff", function() require'fzf-lua'.files() end, desc = "Find files"},
    {"<Leader>f/", function() require'fzf-lua'.blines({resume=true}) end, desc = "Find words in current buffer"},
    {"<Leader>f?", function() require'fzf-lua'.lines({resume=true}) end, desc = "Find words buffers"},
    {"<Leader>fw", function() require'fzf-lua'.live_grep({resume=true}) end, desc = "Find words"},
    {"<Leader>fW", function() require'fzf-lua'.live_grep({cmd="rg --no-ignore", resume=true}) end, desc = "Find all words"},
    {"<Leader>fc", function() require'fzf-lua'.grep_cword() end, desc = "Find word under cursor"},
    {"<Leader>fk", function() require'fzf-lua'.keymaps() end, desc = "Find keymaps"},
    {"<Leader>fh", function() require'fzf-lua'.helptags() end, desc = "Find help"},
    {"<Leader>fm", function() require'fzf-lua'.manpages() end, desc = "Find man"},
  }
}
