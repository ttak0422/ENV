use {
  'ojroques/nvim-bufdel',
  config = function()
    require('bufdel').setup {
      quit = false,
    }
  end,
}
