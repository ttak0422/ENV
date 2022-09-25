require'nvim-treesitter.configs'.setup {
  ensure_installed = { 'bash', 'c', 'c_sharp', 'clojure', 'cmake', 'commonlisp', 'cpp', 'css', 'd', 'dart', 'dockerfile', 'elixir', 'elm', 'erlang', 'fennel', 'fish', 'go', 'gomod', 'gowork', 'graphql', 'haskell', 'html', 'java', 'javascript', 'jsdoc', 'json', 'jsonc', 'json5', 'julia', 'kotlin', 'lua', 'make', 'markdown', 'nix', 'ocaml', 'ocaml', 'ocaml_interface', 'python', 'r', 'ruby', 'rust', 'scala', 'scss', 'toml', 'tsx', 'typescript', 'vim', 'vue', 'yaml', 'org' },
  sync_install = false,
  ignore_install = {},
  parser_install_dir = vim.fn.stdpath('data') .. '/treesitter_parser/',
  highlight = {
    enable = true,
    ignore_install = { 'c' },
    disable = { 'c', 'org' },
    additional_vim_regex_highlighting = { 'org' },
  },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  },
  autotag = {
    enable = true,
  },
}
