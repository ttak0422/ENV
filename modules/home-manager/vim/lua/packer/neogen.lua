use {
  'danymat/neogen',
  ft = {
    'lua',
    'python',
    'javascript',
    'cpp',
    'go',
    'java',
    'rust',
    'csharp',
  },
  setup = function()
    vim.api.nvim_set_keymap('n', '<Leader>nc', ":lua require('neogen').generate({ type = 'class' })<CR>", { noremap = true, silent = true })
  end,
}
