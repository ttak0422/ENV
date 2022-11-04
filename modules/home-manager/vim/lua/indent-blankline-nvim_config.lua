vim.opt.list = true
require("indent_blankline").setup({
  show_end_of_line = true,
  space_char_blankline = " ",
  use_treesitter = true,
  show_current_context = true,
  show_current_context_start = false,
  filetype_exclude = { "alpha", "lspinfo", "packer", "checkhealth", "help", "glowpreview", "" },
})
