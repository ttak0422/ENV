use { 'folke/twilight.nvim' }
use {
  'folke/zen-mode.nvim',
  cmd = 'ZenMode',
  setup = function()
    vim.api.nvim_set_keymap('n', '<Leader><Leader>z', '<cmd>ZenMode<CR>', { noremap = true, silent = true })
  end,
  config = function()
    require('zen-mode').setup {
      window = {
        width = .85,
        options = {
          signcolumn = 'no',
          number = false;
          relativenumber = false;
          cursorline = true;
        },
      },
      plugins = {
        options = {
          enabled = true,
          ruler = false,
          showcmd = false,
        },
        twilight = { enable = true },
      },
    }

  end,
}
