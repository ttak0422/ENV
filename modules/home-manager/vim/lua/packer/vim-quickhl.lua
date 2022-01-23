use {
  't9md/vim-quickhl',
  keys = {
    '<Plug>(quickhl-manual-this)',
    '<Plug>(quickhl-manual-reset)',
  },
  setup = function()
    vim.api.nvim_set_keymap('n', '<Leader>m', '<Plug>(quickhl-manual-this)', { silent = true })
    vim.api.nvim_set_keymap('x', '<Leader>m', '<Plug>(quickhl-manual-this)', { silent = true })
    vim.api.nvim_set_keymap('n', '<Leader>M', '<Plug>(quickhl-manual-reset)', { silent = true })
    vim.api.nvim_set_keymap('x', '<Leader>M', '<Plug>(quickhl-manual-reset)', { silent = true })
  end,
}
