local term = require'toggleterm.terminal'.Terminal
local tig = term:new({cmd = 'tig', direction = 'float', hidden = true})

function TigToggle()
  tig:toggle()
end

require'nest'.applyKeymaps {
  { '<leader>', {
    { '<leader>', {
      { 's', '<cmd>HopChar2<cr>' },
      { 'z', '<cmd>ZenMode<cr>' },
      { 'b', '<cmd>NvimTreeToggle<cr>' },
      { 'g', '<cmd>lua TigToggle()<cr>' }
    },},
    { 's', '<cmd>HopChar1<cr>' },
    { 'j', '<cmd>HopLineAC<cr>' },
    { 'k', '<cmd>HopLineBC<cr>' },
    { 'nc',  ':lua require("neogen").generate({ type = "class" })<cr>' },
    { 'ca', '<cmd>Lspsaga code_action<cr>' },
    { 'rn', '<cmd>Lspsaga rename<cr>' },
    { 'f', {
      { 'f', '<cmd>Telescope live_grep_raw<cr>' },
      { 'p', '<cmd>Telescope find_files<cr>' },
      { 'b', '<cmd>Telescope buffers<cr>' }, }
    }, }
  },
  { '<c-w>', {
    { 'q', '<cmd>BufDel<cr>' },
    { 'Q', '<cmd>BufDel!<cr>' },},
  },
}

