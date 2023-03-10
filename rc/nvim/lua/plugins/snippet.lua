return {
  "L3MON4D3/LuaSnip",
  keys = function() 
    return {
      {
        "<c-t>",
        function()
          return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or ""
        end,
        expr = true, silent = true, mode = "i",
      },
      { "<c-t>", function() require("luasnip").jump(1) end, mode = "s" },
      { "<c-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
    }
  end,
}
