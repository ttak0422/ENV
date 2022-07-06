local function setup_vim_opt()
  vim.opt.termguicolors = true
end

local function setup_vim_env()
end

local function init()
  setup_vim_opt()
  setup_vim_env()
end

if not vim.g.vscode then
  init()
end
