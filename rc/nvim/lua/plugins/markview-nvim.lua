---@type LazySpec
return {
  "OXY2DEV/markview.nvim",
  lazy = false,      -- Recommended
  -- ft = "markdown" -- If you decide to lazy-load anyway

  opts = {
    markdown = {
      list_items = {
        shift_width = 2
      }
    }
  },
  dependencies = {
    -- You will not need this if you installed the
    -- parsers manually
    -- Or if the parsers are in your $RUNTIMEPATH
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons"
  }
}
