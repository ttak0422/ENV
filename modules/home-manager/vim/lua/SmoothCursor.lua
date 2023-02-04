return function(opt)
  require("smoothcursor").setup({
    autostart = true,
    cursor = "",
    texthl = "SmoothCursor",
    linehl = nil,
    type = "default",
    fancy = {
      enable = true,
      head = { cursor = "▷", texthl = "SmoothCursor", linehl = nil },
      body = {
        { cursor = "", texthl = "SmoothCursorRed" },
        { cursor = "", texthl = "SmoothCursorOrange" },
        { cursor = "●", texthl = "SmoothCursorYellow" },
        { cursor = "●", texthl = "SmoothCursorGreen" },
        { cursor = "•", texthl = "SmoothCursorAqua" },
        { cursor = ".", texthl = "SmoothCursorBlue" },
        { cursor = ".", texthl = "SmoothCursorPurple" },
      },
      tail = { cursor = nil, texthl = "SmoothCursor" },
    },
    speed = 25,
    intervals = 35,
    priority = 10,
    timeout = 3000,
    threshold = 3,
    disable_float_win = false,
    disabled_filetypes = opt.exclude_ft,
  })
end
