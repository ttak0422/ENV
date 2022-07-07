vim.opt.list = true
vim.opt.listchars:append('eol:↴')
require('indent_blankline').setup {
  show_end_of_line = true,
  space_char_blankline = ' ',
  use_treesitter = true,
  show_current_context = true,
  filetype_exclude = { 'alpha', 'lspinfo', 'packer', 'checkhealth', 'help', 'glowpreview', '', },
}
