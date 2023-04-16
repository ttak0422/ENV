vim.env.GIT_EDITOR = require("waitevent").editor({
  open = function(ctx, path)
    vim.cmd.split(path)
    ctx.lcd()
    vim.bo.bufhidden = "wipe"
  end,
})
