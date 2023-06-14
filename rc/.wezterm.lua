-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices
config.font = wezterm.font('FiraCode Nerd Font Mono', {weight="Medium"})
config.font_size = 16.0
config.term = "wezterm"
-- config.freetype_load_target = "Mono"

config.keys = {
  {
    key = 'a',
    mods = 'CTRL',
    action = wezterm.action.ActivateKeyTable {
      name = 'mux',
      timeout_milliseconds = 700,
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
    -- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
    {
      key = 'a',
      mods = 'CTRL',
      action = wezterm.action.SendKey { key = 'a', mods = 'CTRL' },
    },
  }
}

-- and finally, return the configuration to wezterm
return config
