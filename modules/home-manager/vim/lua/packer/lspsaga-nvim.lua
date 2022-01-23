use {
  -- maintained fork version
  'tami5/lspsaga.nvim',
  opt = true,
  cmd = 'Lspsaga',
  setup = function()
      vim.api.nvim_set_keymap('n', '<Leader>ca', '<cmd>Lspsaga code_action<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('v', '<Leader>ca', ':<C-u>Lspsaga range_code_action<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<Leader>ca', '<cmd>Lspsaga rename<CR> ', { noremap = true, silent = true })
  end,
  config = function()
    local saga = require 'lspsaga'
    saga.init_lsp_saga {
    }
  end,
}

