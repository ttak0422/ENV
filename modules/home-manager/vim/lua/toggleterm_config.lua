require("toggleterm").setup({
  direction = "horizontal",
  size = math.floor(vim.o.lines * 0.8),
})

local term = require("toggleterm.terminal").Terminal
local tig = term:new({
  cmd = "tig",
  hidden = true,
  direction = "float",
  count = 2,
})

vim.api.nvim_create_user_command("ToggleTig", function()
  tig:toggle()
end, {})
