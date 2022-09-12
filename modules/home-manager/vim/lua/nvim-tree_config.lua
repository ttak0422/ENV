require 'nvim-tree'.setup {
  hijack_cursor = true,
  view = {
    width = 35,
    side = 'left',
    hide_root_folder = true,
    adaptive_size = true,
    mappings = {
      custom_only = true,
      list = {
        { key = { '<CR>', 'o' }, action = 'edit' },
        { key = 'O', action = 'system_open' },
        { key = 'a', action = 'create' },
        { key = 'd', action = 'remove' },
        { key = 'r', action = 'rename' },
        { key = 'R', action = 'refresh' },
        { key = '?', action = 'toggle_help' },
      },
    },
  },
  update_focused_file = {
    enable = true,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
  },
}
