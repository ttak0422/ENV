local function setup_vim_opt()
  vim.opt.termguicolors = true
  vim.cmd 'colorscheme elly'
end

local function init()
  setup_vim_opt()
  require'packer.plugins'.load()
end

init()
