---@type LazySpec
return {
  {
    "jayong93/diffdirs.nvim",
    opts = {},
    cmd = {"DiffDirs"},
    config = function (_, opts)
      local diffdirs = require("diffdirs")
      diffdirs.setup(opts)
      vim.keymap.set('n', '[q', '<Plug>PrevDiff', {silent=true, noremap=true, desc="Previous diff tab"})
      vim.keymap.set('n', ']q', '<Plug>NextDiff', {silent=true, noremap=true, desc="Next diff tab"})
      vim.keymap.set('n', '<Leader>fd', function()
        require('fzf-lua').fzf_exec(diffdirs.diff_files(),
          {actions = {['default'] = function(selected) diffdirs.jump_diff_tab(selected[1]) end}})
      end, {silent=true, noremap=true, desc="Find diff tabs"})
    end,
    dependencies = {"ibhagwan/fzf-lua"}
  },
  {
    "julienvincent/hunk.nvim",
    opts = {},
    dependencies = {"MunifTanjim/nui.nvim"}
  }
}
