require'orgmode'.setup_ts_grammar()

require'nvim-treesitter.configs'.setup {
  highlight=  {
    enable = true,
    additional_vim_regex_highlighting = {'org'},
  },
  ensure_installed = {'org'},
}

require'orgmode'.setup{
  org_agenda_files = {'~/org/*','~/org/**/*'},
  org_default_notes_file = '~/org/refile.org',
  org_capture_templates = {
    t = {
      description = 'Todo',
      template = '* TODO %?\n %u',
      target = '~/org/refile.org'
    },
  },
  mappings = {
    global = {
      org_agenda = {'<leader>oa'},
      org_capture = {'<leader>oc'},
    },
    capture = {
      org_capture_finalize = '<Leader>of',
      org_capture_refile = '<Leader>or',
      org_capture_kill = '<Leader>ok',
      org_capture_show_help = 'g?',
    },
    org = {
      org_toggle_checkbox = '<leader><leader>t',
      org_schedule = '<leader>ois',
    },
    edit_src = {
      org_edit_src_abort = '<Leader>oq',
      org_edit_src_save = '<Leader>ow',
      org_edit_src_show_help = 'g?',
    },
  }
}

