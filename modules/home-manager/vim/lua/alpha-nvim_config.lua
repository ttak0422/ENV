local alpha = require 'alpha'
local dashboard = require 'alpha.themes.dashboard'
local logo = {
  '            ▒       ▒▒▒▒      ▒▒',
  '          ▒▓▓▓▒     ░▒▒▒▒   ▒▒▒▒░',
  '          ▒▓▓▓▓▒     ░▒▒▒▒  ▒▒▒▒░',
  '           ▒▓▓▓▓      ░▒▒▒░▒▒▒▒░',
  '            ▓▓▓▓▓      ▒▒▒▒▒▒▒░',
  '       ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒      ▒',
  '      ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░     ▓▓▒',
  '     ▒▒▒▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓   ▓▓▓▓',
  '           ▒▒▒▒▒▓         ▒▒▒▒▒▓ ▓▓▓▓▓',
  '          ▒▒▒▒▒▓           ▒▒▒▒░▓▓▓▓▓',
  '  ▒▒▒▒▒▒▒▒▒▒▒▒░             ▒▒░▓▓▓▓▓▒▒▒▒▒',
  ' ░▒▒▒▒▒▒▒▒▒▒▒░               ▒▓▓▓▓▓▓▓▓▓▓▓▓',
  ' ░▒▒▒▒▒▒▒▒▒▒░▒               ▒▓▓▓▓▓▓▓▓▓▓▓▓     _______   ___    __',
  '  ▒▒▒▒▒▒▒▒▒░▓▓▓             ▒▓▓▓▓▒            / ____/ | / / |  / /',
  '      ░▒▒▒▒▒▓▓▓▓           ▒▓▓▓▓▒            / __/ /  |/ /| | / /',
  '     ░▒▒▒▒  ▓▓▓▓▒         ▒▓▓▓▓▒            / /___/ /|  / | |/ /',
  '     ▒▒▒▒▒   ▓▓▓▓▒▓▓▓▓▓▓▓▓░░░░░▓▓▓▓▓▓▓     /_____/_/ |_/  |___/',
  '      ▒▒▒    ▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒',
  '       ▒     ▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒       _    __           ___',
  '            ▓▓▓▓▓▓▓▓▒     ░▒▒▒▒            | |  / /__  _____ |__ \\',
  '           ▒▓▓▓▓▒▓▓▓▓      ░▒▒▒░           | | / / _ \\/ ___/ __/ /',
  '          ▒▓▓▓▓  ▒▓▓▓▓      ░▒▒▒░          | |/ /  __/ /  _ / __/ ',
  '          ▒▓▓▓    ▒▓▓▓▓      ▒▒▒▓          |___/\\___/_/  (_)____/',
}
dashboard.section.header.val = logo
dashboard.section.buttons.val = {
  dashboard.button('<Leader>fP', '  Find Project'),
  dashboard.button('<Leader>fp', '  Find File'),
  dashboard.button('<Leader>ff', '  Find Word'),
}
alpha.setup(dashboard.opts)
