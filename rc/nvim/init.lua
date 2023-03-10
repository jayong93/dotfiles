-- bootstrap lazy.nvim, LazyVim and your plugins

local function reload(m)
  package.loaded[m] = nil
  return require(m)
end

reload("config.lazy")
