return {
  n = {
    ["<leader>fp"] = {
      function()
        require("telescope.builtin").pickers {}
      end,
      desc = "Recent pickers"
    }
  }
}
