use {
  't9md/vim-choosewin',
  opt = true,
  cmd = { 'ChooseWin', 'ChooseWinSwap' },
  setup = function()
    vim.api.nvim_set_keymap('n', '<Leader>-', '<cmd>ChooseWin<CR> ', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<Leader><Leader>-', '<cmd>ChooseWinSwap<CR> ', { noremap = true, silent = true })
  end,
}
