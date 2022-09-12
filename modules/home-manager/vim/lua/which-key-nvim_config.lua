local wk = require 'which-key'

wk.setup()
wk.register({
  ['<leader>'] = {
    ['<leader>'] = {
      name = 'toggle',
      z = { '<cmd>ZenMode<cr>', 'Toggle ZenMode' },
      b = { '<cmd>NvimTreeToggle<cr>', 'Toggle File Tree' },
      w = { '<cmd>WhichKey<cr>', 'Toggle WhichKey' },
      d = { '<cmd>TroubleToggle document_diagnostics<cr>', 'Toggle Diagnostics (document)' },
      D = { '<cmd>TroubleToggle workspace_diagnostics<cr>', 'Toggle Diagnostics (workspace)' },
      m = { '<cmd>Glow<cr>', 'Toggle Markdown Preview' },
      o = { '<cmd>SidebarNvimToggle<CR>', 'Toggle Outline' },
    },
    ['f'] = {
      name = 'find',
      f = { '<cmd>Telescope live_grep_args<cr>', 'find contents' },
      p = { '<cmd>Telescope find_files<cr>', 'find files' },
      P = { '<cmd>Telescope projects<cr>', 'find projects' },
      b = { '<cmd>Telescope buffers<cr>', 'find buffers' },
    },
    F = { '<cmd>lua require("spectre").open()<cr>', 'find and replace with dark power' },
    ['r'] = {
      name = 'run',
    },
    s = { '<cmd>HopChar1<cr>', 'hop to char' },
    S = { '<cmd>HopChar2<cr>', 'hop to chars' },
    j = { '<cmd>HopLineAC<cr>', 'hop to under line' },
    k = { '<cmd>HopLineBC<cr>', 'hop to upper line' },
    Q = { '<cmd>BufDel!<cr>', 'close buffer force' },
    q = { '<cmd>BufDel<cr>', 'close buffer' },
    ca = { '<cmd>Lspsaga code_action<cr>', 'code action' },
    rn = { '<cmd>Lspsaga rename<cr>', 'rename' },
  },
})

wk.register({
  ['<c-w>'] = {
    z = { '<cmd>ZoomWinTabToggle<cr>', 'zoom pane' },
    ['<c-w>'] = { '<cmd>Chowcho<cr>', 'chose window' }
  },
})

wk.register({
  ['g'] = {
    name = 'goto',
    ['p'] = {
      name = 'preview',
      d = { '<cmd>lua require("goto-preview").goto_preview_definition()<CR>', 'preview definition' },
      i = { '<cmd>lua require("goto-preview").goto_preview_implementation()<CR>', 'preview implementation' },
      r = { '<cmd>lua require("goto-preview").goto_preview_references()<CR>', 'preview references' },
    },
    P = { '<cmd>lua require("goto-preview").close_all_win()<CR>', 'close all preview' },
    b = { '<cmd>BufferLinePick<CR>', 'pick buffer' },
    w = { '<cmd>Chowcho<cr>', 'choose pane' },
  },
})

wk.register({
  ['<leader>'] = {
    c = { '<cmd>OSCYank<CR>', 'OSCYank' },
  },
}, { mode = 'v' })
