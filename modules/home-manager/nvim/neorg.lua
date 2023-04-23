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
