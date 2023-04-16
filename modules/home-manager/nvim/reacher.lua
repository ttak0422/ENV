local map = vim.keymap.set
local opts = { noremap = true, silent = true, buffer = true }
local reacher = require("reacher")
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "reacher" },
  callback = function()
    map("i", "<cr>", reacher.finish, opts)
    map("i", "<esc>", reacher.cancel, opts)
    map("i", "<Tab>", reacher.next, opts)
    map("i", "<S-Tab>", reacher.previous, opts)
    map("i", "<C-n>", reacher.forward_history, opts)
    map("i", "<C-p>", reacher.backward_history, opts)
  end,
})
