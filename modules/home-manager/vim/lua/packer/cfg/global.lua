local global = {}

function global:init()
  self.vim_path = vim.fn.stdpath('config')
  self.compile_name = 'packer_compiled'
  self.compile_path = self.vim_path .. '/lua/' .. self.compile_name .. '.lua'
end

global:init()

return global
