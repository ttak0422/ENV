local tel = require'telescope'
local l = tel.load_extension

tel.setup{
  defaults = {
    layout_strategy = 'flex',
    layout_config = { height = 0.95 },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = 'smart_case',
    },
  },
}


l 'fzf'
l 'live_grep_raw'

