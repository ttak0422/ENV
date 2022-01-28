require'nest'.applyKeymaps {
  { '<leader>', {
    { '<leader>', {
      { 's', '<cmd>HopChar2<cr>' },
      { 'z', '<cmd>ZenMode<cr>' },
      { 'b', '<cmd>NvimTreeToggle<cr>' },
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
    { 'q', '<cmd>BufDel<cr>' },},
  },
}

