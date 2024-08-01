---@type LazySpec
return {
  "leath-dub/snipe.nvim",
  opts = {},
  keys = {
    {"<Leader>fb", function() require("snipe").create_buffer_menu_toggler() end, desc="Find buffer"}
  }
}
