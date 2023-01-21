local notify = require("notify")

notify.setup({
  timeout = 3000,
  top_down = false,
  stages = "fade",
  background_colour = "#000000",
})

vim.notify = notify
