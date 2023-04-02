require("illuminate").configure({
  providers = {
    "lsp",
    "treesitter",
  },
  delay = 300,
  filetypes_denylist = {
    "NvimTree",
    "TelescopePrompt",
    "TelescopeResult",
    "toggleterm",
    "SidebarNvim",
    "Outline",
    "alpha",
  },
  modes_allowlist = { "n" },
  under_cursor = true,
  large_file_cutoff = 10000,
  min_count_to_highlight = 1,
})
