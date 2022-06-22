require'flare'.setup {
  enabled = true,
  hl_group = "IncSearch",
  x_threshold = 10,
  y_threshold = 5,
  expanse = 10,
  file_ignore = {
    "NvimTree",
    "TelescopePrompt",
    "TelescopeResult",
    "Trouble",
  },
  fade = true,
  underline = false,
  timeout = 150,
}
