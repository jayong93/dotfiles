-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.motion.mini-surround" },
  { import = "astrocommunity.note-taking.zk-nvim" },
  { import = "astrocommunity.colorscheme.catppuccin" },
  -- { import = "astrocommunity.pack.jj" },
  { import = "astrocommunity.pack.just" },
  -- {
  --   "zschreur/telescope-jj.nvim",
  --   enabled = false
  -- },
  -- import/override with your plugins folder
}
