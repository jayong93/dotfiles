local wezterm = require 'wezterm'

local config = {}

-- font setting
config.font = wezterm.font_with_fallback{{family='IosevkaTerm Nerd Font Mono', weight="Medium"},
  'UbuntuMono Nerd Font Mono',
  'Noto Sans CJK KR'
}

extra_keys = {}
if wezterm.target_triple == "x86_64-unknown-linux-gnu" then
  config.font_size = 14
  config.use_ime = true
  config.xim_im_name = "kime"
  config.enable_wayland = false
  extra_keys = {
    {
      key = 'v',
      mods = 'CTRL',
      action = wezterm.action.PasteFrom 'Clipboard'
    }
  }
else
  config.font_size = 25
end
config.freetype_load_target = "Light"
config.freetype_render_target = "HorizontalLcd"
config.freetype_load_flags = 'NO_HINTING'
config.cell_width = 0.9
config.line_height = 0.9


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
for i, key in ipairs(extra_keys) do
  table.insert(config.keys, key)
end
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
