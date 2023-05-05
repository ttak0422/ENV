-- Neorg sync-parsers
require("neorg").setup({
  load = {
    ["core.defaults"] = {},
    ["core.concealer"] = {},
    ["core.dirman"] = {
      config = {
        workspaces = {
          notes = "~/neorg/notes",
          dialy = "~/neorg/dialy",
        },
      },
    },
  },
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "**/*.norg" },
  callback = function()
    vim.cmd([[
      setl conceallevel=2
      setl nowrap
    ]])
  end,
})
