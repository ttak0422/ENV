local telescope = require'telescope'
telescope.setup {
  defaults = {
    layout_strategy = 'vertical',
    layout_config = { height = 0.95 },
    -- path_display={'smart'},
    shorten_path = true;
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = 'smart_case',
    },
    live_grep_args = {
      auto_quoting = true,
    },
  },
}

telescope.load_extension('live_grep_args')
telescope.load_extension('fzf')
