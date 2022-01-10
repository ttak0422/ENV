require("zen-mode").setup {
  window = {
    width = .85,
    options = {
      signcolumn = "no",
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

