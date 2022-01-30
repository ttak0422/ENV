local term = require'toggleterm.terminal'.Terminal
local tig = term:new({cmd = 'tig', direction = 'float', hidden = true})

function TigToggle()
  tig:toggle()
end

local wk = require("which-key")

wk.setup()
wk.register({
  ['<leader>'] = {
    ['<leader>'] = {
      name = 'toggle',
      z = { '<cmd>ZenMode<cr>', 'Toggle ZenMode' },
      b = { '<cmd>NvimTreeToggle<cr>', 'Toggle File Tree' },
      g = { '<cmd>lua TigToggle()<cr>', 'Toggle Tig' },
      w = { '<cmd>WhichKey<cr>', 'Toggle WhichKey' },
    },
    ['f'] = {
      name = 'find',
      f = { '<cmd>Telescope live_grep_raw<cr>', 'find contents' },
      p = { '<cmd>Telescope find_files<cr>', 'find files' },
      b = { '<cmd>Telescope buffers<cr>', 'find buffers' },
    },
    ['<c-w>'] = {
      q = { '<cmd>BufDel<cr>', 'close buffer' },
      Q = { '<cmd>BufDel!<cr>', 'close buffer force' },
    },
    s = { '<cmd>HopChar1<cr>', 'hop to char' },
    S = { '<cmd>HopChar2<cr>', 'hop to chars' },
    j = { '<cmd>HopLineAC<cr>', 'hop to under line' },
    k = { '<cmd>HopLineBC<cr>', 'hop to upper line' },
    -- nc = { ':lua require("neogen").generate({ type = "class" })<cr>' }, wip
    ca = { '<cmd>Lspsaga code_action<cr>', 'code action' },
    rn = { '<cmd>Lspsaga rename<cr>', 'rename' },
  }})
