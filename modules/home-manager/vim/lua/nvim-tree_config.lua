require'nvim-tree'.setup {
  hijack_cursor = true,
  view = {
    width = 35,
    side = 'left',
    hide_root_folder = true,
  },
  update_focused_file = {
    enable = true,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
}
