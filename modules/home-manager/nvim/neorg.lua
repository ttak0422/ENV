-- Neorg sync-parsers
require("neorg").setup({
  load = {
    ["core.defaults"] = {},
    ["core.export"] = {},
    ["core.concealer"] = {
      config = {
        dim_code_blocks = {
          conceal = false,
        },
      },
    },
    ["core.dirman"] = {
      config = {
        default_workspace = "notes",
        workspaces = {
          notes = "~/neorg/notes",
          dialy = "~/neorg/dialy",
        },
      },
    },
  },
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.norg" },
  callback = function()
    vim.cmd([[
      setl conceallevel=2
      setl nowrap
    ]])
  end,
})
