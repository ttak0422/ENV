use {
  'folke/todo-comments.nvim',
  requires = 'nvim-lua/plenary.nvim',
  cmd = {
    'TodoQuickFix',
    'TodoLocList',
    'TodoTrouble',
    'TodoTelescope',
  },
  opt = true,
  config = function()
    require('todo-comments').setup {
    }
  end,
}
