require 'zen-mode'.setup {
  window = {
    backdrop = 0.90,
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
    twilight = { enable = false },
    gitsigns = { enabled = false },
    tmux = { enabled = false },
    kitty = {
      enabled = false,
      font = "+2",
    },
  },
}
