require("smoothcursor").setup({
  autostart = true,
  fancy = {
    enable = true,
    head = { cursor = " ", texthl = "SmoothCursor", linehl = nil },
    body = {
      { cursor = "", texthl = "SmoothCursorAqua" },
      { cursor = "•", texthl = "SmoothCursorAqua" },
      { cursor = ".", texthl = "SmoothCursorAqua" },
    },
    tail = { cursor = nil, texthl = "SmoothCursor" },
  },
  speed = 25,
  intervals = 35,
  priority = 10,
  timeout = 3000,
  threshold = 3,
  disable_float_win = false,
  disabled_filetypes = dofile(args.exclude_ft_path),
})
