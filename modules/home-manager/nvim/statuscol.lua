vim.o.foldcolumn = "1"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

local builtin = require("statuscol.builtin")

require("statuscol").setup({
  setopt = true,
  relculright = true,
  segments = {
    { text = { "%s" }, click = "v:lua.scsa" },
    {
      text = { " ", builtin.foldfunc, " " },
      condition = { builtin.not_empty, true, builtin.not_empty },
      click = "v:lua.scfa",
    },
    { text = { builtin.lnumfunc }, click = "v:lua.scla" },
  },
})
