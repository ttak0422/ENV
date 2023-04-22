local parser_install_dir = vim.fn.stdpath("data") .. "/treesitter_parser"
vim.opt.runtimepath:append(parser_install_dir)
require("nvim-treesitter.configs").setup({
  sync_install = false,
  auto_install = false,
  ignore_install = {},
  parser_install_dir = parser_install_dir,
  highlight = {
    enable = true,
  },
  yati = {
    enable = true,
    default_lazy = true,
    default_fallback = "auto",
  },
  indent = {
    enable = false,
  },
  rainbow = {
    enable = true,
    query = "rainbow-parens",
    strategy = require("ts-rainbow").strategy.global,
  },
  matchup = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
      },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        ["]f"] = "@function.outer",
      },
      goto_next_end = {
        ["]F"] = "@function.outer",
      },
      goto_previous_start = {
        ["[f"] = "@function.outer",
      },
      goto_previous_end = {
        ["[F"] = "@function.outer",
      },
    },
  },
})
