local notify = require('notify')

notify.setup {
  timeout = 3000,
  top_down = false,
  stages = 'fade',
}

vim.notify = notify
