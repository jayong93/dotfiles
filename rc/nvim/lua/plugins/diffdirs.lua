--@type LazySpec
return {
  {
    "jayong93/diffdirs.nvim",
    opts = {},
    cmd = {"DiffDirs"},
    config = function (_, opts)
      require("diffdirs").setup(opts)
      vim.keymap.set('n', '[q', '<Plug>PrevDiff', {silent=true, noremap=true})
      vim.keymap.set('n', ']q', '<Plug>NextDiff', {silent=true, noremap=true})
    end
  },
  {
    "julienvincent/hunk.nvim",
    opts = {},
    dependencies = {"MunifTanjim/nui.nvim"}
  }
}
