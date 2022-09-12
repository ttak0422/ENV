require('sidebar-nvim').setup({
  disable_default_keybindings = 1,
  side = 'right',
  initial_width = 35,
  hide_statusline = false,
  update_interval = 1000,
  sections = { 'git', 'symbols' },
})
