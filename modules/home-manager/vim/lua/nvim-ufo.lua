local ufo = require("ufo")

ufo.setup({
  provider_selector = function(bufnr, filetype, buftype)
    return { "treesitter", "indent" }
  end,
})

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "zR", ufo.openAllFolds, opts)
vim.keymap.set("n", "zM", ufo.closeAllFolds, opts)
vim.keymap.set("n", "zr", ufo.openFoldsExceptKinds, opts)
vim.keymap.set("n", "zm", ufo.closeFoldsWith, opts)
