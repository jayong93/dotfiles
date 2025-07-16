---@type LazySpec
return {
  {
    "max397574/better-escape.nvim",
    enabled=false,
  },
  {
    "nvim-telescope/telescope.nvim",
    enabled=false,
  },
  -- Disable lazy load for smart-splits.nvim
  -- https://github.com/mrjones2014/smart-splits.nvim?tab=readme-ov-file#wezterm
  {
    "mrjones2014/smart-splits.nvim",
    opts = {
      multiplexer_integration=false,
    }
  },
  {
    "kevinhwang91/nvim-ufo",
    enabled=false,
  },
}

