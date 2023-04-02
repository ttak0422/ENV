require("scrollbar").setup({
  how_in_active_only = true,
  handlers = {
    cursor = true,
    diagnostic = false,
    gitsigns = true,
    handle = false,
    search = false,
    ale = false,
  },
  handle = {
    blend = 0,
  },
  marks = {
    Cursor = {
      text = "•",
      priority = 0,
      highlight = "Normal",
    },
    GitAdd = {
      text = "▊",
      highlight = "GitSignsAdd",
    },
    GitChange = {
      text = "▊",
      highlight = "GitSignsChange",
    },
    GitDelete = {
      text = "▊",
      highlight = "GitSignsDelete",
    },
  },
  exclude_ft = dofile(args.exclude_ft_path),
  exclude_buf_ft = dofile(args.exclude_buf_ft_path),
})
require("scrollbar.handlers.gitsigns").setup()
