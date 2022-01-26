
require('indent_blankline').setup {
  after = 'nvim-treesitter',
  show_end_of_line = true,
  space_char_blankline = ' ',
  use_treesitter = true,
  show_current_context = true,
  filetype_exclude = { 'alpha' , 'lspinfo', 'packer', 'checkhealth', 'help', ''},
}

