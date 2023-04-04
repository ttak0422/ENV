require("satellite").setup({
  urrent_only = false,
  winblend = 10,
  excluded_filetypes = dofile(args.exclude_ft_path),
  width = 2,
  handlers = {
    search = {
      enable = true,
    },
    diagnostic = {
      enable = true,
      signs = { "-", "=", "≡" },
      min_severity = vim.diagnostic.severity.WARN,
    },
    gitsigns = {
      enable = true,
      signs = {
        add = "│",
        change = "│",
        delete = "-",
      },
    },
    marks = {
      enable = false,
      show_builtins = false,
    },
  },
})
