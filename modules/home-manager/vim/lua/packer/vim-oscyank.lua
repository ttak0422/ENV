use {
  'ojroques/vim-oscyank',
  opt = true,
  cmd = 'OSCYank',
  setup = function()
    vim.api.nvim_set_keymap('v', '<Leader>y', '<cmd>OSCYank<CR> ', { noremap = true, silent = true })
  end,
}
