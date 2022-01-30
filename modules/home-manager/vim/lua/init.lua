local function setup_vim_opt()
  vim.opt.termguicolors = true
end

local function load_packer_compile()
  local present, _ = pcall(require, 'packer_compiled')
  if not present then
    assert('Run PackerCompile')
  end
end

local function init()
  setup_vim_opt()
  load_packer_compile()
end

init()
