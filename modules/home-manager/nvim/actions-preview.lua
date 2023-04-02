require("actions-preview").setup({
  diff = {
    ctxlen = 3,
    ignore_whitespace = true,
  },
  backend = { "telescope" },
  telescope = require("telescope.themes").get_ivy({}),
})
