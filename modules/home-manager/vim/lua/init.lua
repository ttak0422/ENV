local function setup_vim_opt()
  vim.opt.termguicolors = true
  vim.opt.laststatus = 3
end

local function setup_vim_env()
end

local function init()
  setup_vim_opt()
  setup_vim_env()
  require'packer.plugins'.load()
end

if not vim.g.vscode then
  init()
end
