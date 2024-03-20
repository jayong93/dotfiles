local wezterm = require 'wezterm'

local config = {}

-- font setting
config.font = wezterm.font_with_fallback{{family='MonaspiceNe Nerd Font Mono', weight="Medium"},
  'D2CodingLigature Nerd Font Mono',
  'Noto Sans CJK KR'
}
config.dpi = 72
config.font_size = 20

-- key setting
config.keys = {
  {
    key = 'a',
    mods = 'CTRL',
    action = wezterm.action.ActivateKeyTable {
      name = 'mux',
      timeout_milliseconds = 1400,
    },
  }
}
config.key_tables = {
  mux = {
    {
      key = 'h',
      action = wezterm.action.ActivatePaneDirection 'Left',
    },
    {
      key = 'j',
      action = wezterm.action.ActivatePaneDirection 'Down',
    },
    {
      key = 'k',
      action = wezterm.action.ActivatePaneDirection 'Up',
    },
    {
      key = 'l',
      action = wezterm.action.ActivatePaneDirection 'Right',
    },
    {
      key = '"',
      mods = 'SHIFT',
      action = wezterm.action.SplitVertical {domain="CurrentPaneDomain"},
    },
    {
      key = '|',
      mods = 'SHIFT',
      action = wezterm.action.SplitHorizontal {domain="CurrentPaneDomain"},
    },
    {
      key = 'p',
      action = wezterm.action.ActivateTabRelative(-1),
    },
    {
      key = 'n',
      action = wezterm.action.ActivateTabRelative(1),
    },
    {
      key = 'c',
      action = wezterm.action.SpawnTab("CurrentPaneDomain"),
    },
    -- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
    {
      key = 'a',
      mods = 'CTRL',
      action = wezterm.action.SendKey { key = 'a', mods = 'CTRL' },
    },
  }
}

return config
