require('specs').setup {
  show_jumps  = true,
  min_jump = 15,
  popup = {
    delay_ms = 0,
    inc_ms = 30,
    blend = 0,
    width = 10,
    winhl = "PMenu",
    fader = require('specs').linear_fader,
    resizer = require('specs').shrink_resizer,
  },
  ignore_filetypes = {},
  ignore_buftypes = {
    nofile = true,
  },
}

