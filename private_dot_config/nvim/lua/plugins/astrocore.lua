-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

-- vim.g.<key>
-- configure global vim variables (vim.g)
-- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
-- This can be found in the `lua/lazy_setup.lua` file
local opt_g = {}
if vim.fn.filereadable("~/.pyenv/versions/nvim/bin/python") then
  opt_g.python3_host_prog = "~/.pyenv/versions/nvim/bin/python"
end

local opt_opt = { -- vim.opt.<key>
  relativenumber = true, -- sets vim.opt.relativenumber
  number = true, -- sets vim.opt.number
  spell = false, -- sets vim.opt.spell
  signcolumn = "auto", -- sets vim.opt.signcolumn to auto
  wrap = true, -- sets vim.opt.wrap
  jumpoptions = "stack",
}
opt_opt.diffopt = vim.opt.diffopt:get()
table.insert(opt_opt.diffopt, "followwrap")
table.insert(opt_opt.diffopt, "linematch:60")
table.insert(opt_opt.diffopt, "algorithm:histogram")

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 500, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- vim options can be configured here
    options = {
      opt = opt_opt,
      g = opt_g,
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map

        -- navigate buffer tabs with `H` and `L`
        -- L = {
        --   function() require("astrocore.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
        --   desc = "Next buffer",
        -- },
        -- H = {
        --   function() require("astrocore.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
        --   desc = "Previous buffer",
        -- },

        -- mappings seen under group name "Buffer"
        ["<Leader>bD"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Pick to close",
        },
        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        ["<Leader>b"] = { desc = "Buffers" },
        -- quick save
        -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command

        -- Zk mappings
        ["<Leader>z"] = { desc = "Zk" },
        ["<Leader>zn"] = { "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", desc = "Create a new note", noremap = true },
        ["<Leader>zo"] = { "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", desc = "Open notes", noremap = true },
        ["<Leader>zt"] = { "<Cmd>ZkTags<CR>", desc = "Open notes associated with the selected tags", noremap = true },
        ["<Leader>zf"] = { "<Cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>", desc = "Search for the notes matching a given query", noremap = true },

        -- Spawn a terminal in a new tab
        ["<Leader>tn"] = { "<Cmd>tabnew|term<CR>", desc = "Create a new tab with terminal", noremap = true },
      },
      v = {
        ["<Leader>zf"] = { ":'<,'>ZkMatch<CR>", desc = "Search for the notes matching the current visual selection", noremap = true },
      },
      t = {
        -- setting a mapping to false will disable it
        -- ["<esc>"] = false,
      },
    },
  },
}
