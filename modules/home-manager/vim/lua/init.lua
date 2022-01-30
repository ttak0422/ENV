local function load_packer_compile()
  present, _ = pcall(require, 'packer_compiled')
  if not present then
    assert('Run PackerCompile')
  end
end

local function init()
  load_packer_compile()
end

init()
