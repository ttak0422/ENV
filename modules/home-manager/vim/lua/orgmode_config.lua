require'orgmode'.setup_ts_grammar()

require'nvim-treesitter.configs'.setup {
  highlight=  {
    enable = true,
    additional_vim_regex_highlighting = {'org'},
  },
  ensure_installed = {'org'},
}

require'orgmode'.setup{
}

