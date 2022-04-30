local function setup_vim_opt()
  vim.opt.termguicolors = true
  vim.opt.laststatus = 3
end

local function init()
  setup_vim_opt()
  require'packer.plugins'.load()
end

if not vim.g.vscode then
  init()
end
