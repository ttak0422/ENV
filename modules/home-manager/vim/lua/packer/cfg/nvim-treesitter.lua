require'nvim-treesitter.configs'.setup {
  ensure_installed = 'maintained',
  sync_install = false,
  ignore_install = {},
  highlight = {
    enable = true,
    ignore_install = { 'c' },
    disable = { 'c' },
    additional_vim_regex_highlighting = false,
  },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  },
  autotag = {
    enable = true,
  },
}
