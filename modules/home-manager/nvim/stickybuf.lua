local stickybuf = require("stickybuf")
stickybuf.setup({
  get_auto_pin = function(bufnr)
    return stickybuf.should_auto_pin(bufnr)
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    if not stickybuf.is_pinned() and (vim.wo.winfixwidth or vim.wo.winfixheight) then
      stickybuf.pin()
    end
  end,
})
