vim.g.catppuccin_flavour = 'mocha'
require('catppuccin').setup {
  integrations = {
    aerial = true,
    cmp = true,
    fidget = true,
    gitsigns = true,
    hop = true,
    lsp_saga = true,
    lsp_trouble = true,
    mini = false,
    neogit = false,
    notify = true,
    nvimtree = true,
    telescope = true,
    treesitter = true,
    treesitter_context = false,
    ts_rainbow = true,
    vim_sneak = false,
    which_key = true,
    indent_blankline = {
      enabled = true,
      colored_indent_levels = true,
    },
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = { 'italic' },
        hints = { 'italic' },
        warnings = { 'italic' },
        information = { 'italic' },
      },
      underlines = {
        errors = { 'underline' },
        hints = { 'underline' },
        warnings = { 'underline' },
        information = { 'underline' },
      },
    },
  },
}
vim.cmd [[colorscheme catppuccin]]
