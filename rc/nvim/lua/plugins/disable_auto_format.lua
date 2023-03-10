return {
  {
    "neovim/nvim-lspconfig",
    opts=function (_, opts)
      opts.autoformat = false
      return opts
    end
  }
}
