require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  sync_install = false,
  ignore_install = {},
  highlight = {
    enable = true,
    disable = { "c" },
    additional_vim_regex_highlighting = false,
  },
}

