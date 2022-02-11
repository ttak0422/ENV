local function setup_vim_opt()
  vim.opt.termguicolors = true
end

local function init()
  setup_vim_opt()
  require'packer.plugins'.load()
end

init()
