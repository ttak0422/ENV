local global = {}

function global:init()
  self.vim_path = vim.fn.stdpath('config')
  self.data_dir = vim.fn.stdpath('data') .. '/site/'
end

global:init()

return global
