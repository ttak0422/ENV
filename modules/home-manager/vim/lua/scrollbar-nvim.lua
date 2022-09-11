vim.api.nvim_create_augroup('ScrollbarInit', {})
vim.api.nvim_create_autocmd({ 'WinScrolled', 'VimResized', 'QuitPre', 'WinEnter', 'FocusGained' }, {
  group = 'ScrollbarInit',
  callback = function()
    require('scrollbar').show()
  end,
})
vim.api.nvim_create_autocmd({ 'WinLeave', 'BufLeave', 'BufWinLeave', 'FocusLost' }, {
  group = 'ScrollbarInit',
  callback = function()
    require('scrollbar').clear()
  end,
})
