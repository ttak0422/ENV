local notify = require("notify")

notify.setup({
  timeout = 2500,
  top_down = true,
  stages = "static",
  background_colour = "#000000",
})

vim.notify = notify
