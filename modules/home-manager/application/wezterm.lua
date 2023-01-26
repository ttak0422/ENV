local wezterm = require("wezterm")

local my_color = wezterm.color.get_builtin_schemes()["Ayu Mirage"]
my_color.background = "#2a2f33"

return {
  color_schemes = {
    ["My Color"] = my_color,
  },
  color_scheme = "My Color",
  window_background_opacity = 0.96,
  text_background_opacity = 0.5,
  font = wezterm.font("PlemolJP35 Console NFJ", { weight = "Medium", stretch = "Normal", style = "Normal" }),
  keys = {
    { key = "-", mods = "CMD|SHIFT", action = wezterm.action.IncreaseFontSize },
  },
  window_padding = {
    left = 5,
    right = 5,
    top = 5,
    bottom = 0,
  },
  window_decorations = "RESIZE",
  enable_tab_bar = false,
  adjust_window_size_when_changing_font_size = false,
}
