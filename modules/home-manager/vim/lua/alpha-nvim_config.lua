local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")
local neovim_icon = {
  "███    ██ ███████  ██████  ██    ██ ██ ███    ███",
  "████   ██ ██      ██    ██ ██    ██ ██ ████  ████",
  "██ ██  ██ █████   ██    ██ ██    ██ ██ ██ ████ ██",
  "██  ██ ██ ██      ██    ██  ██  ██  ██ ██  ██  ██",
  "██   ████ ███████  ██████    ████   ██ ██      ██",
}
dashboard.section.header.val = neovim_icon
dashboard.section.buttons.val = {
  dashboard.button("e", " New file", "<cmd>ene<cr>"),
  dashboard.button("<Leader>fP", " Find Project"),
  dashboard.button("<Leader>fp", " Find File"),
  dashboard.button("<Leader>ff", " Find Word"),
  dashboard.button("ConfigEdit", " Edit Config"),
}
alpha.setup(dashboard.opts)
