use {
  'sindrets/diffview.nvim',
  requires = 'nvim-lua/plenary.nvim',
  cmd = { 'DiffviewOpen', 'DiffviewToggleFiles' },
  opt = true,
  config = function()
    require'diffview'.setup()
  end,
}
