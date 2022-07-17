local wezterm = require 'wezterm';

return {
  color_scheme = 'Ayu Mirage',
  font = wezterm.font('JetBrainsMonoExtraBold Nerd Font Mono', { weight = 'ExtraBold', stretch = 'Normal', style = 'Normal' }),
  keys = {
    { key = '-', mods = 'CMD|SHIFT', action = wezterm.action.IncreaseFontSize },
  },
  enable_tab_bar = false,
	adjust_window_size_when_changing_font_size = false,
}
