local wk = require 'which-key'

wk.setup()
wk.register({
  ['<leader>'] = {
    -- easy motion
    ['<leader>'] = { '<cmd>HopChar1<cr>', 'hop to char' },
    j = { '<cmd>HopLineAC<cr>', 'hop to under line' },
    k = { '<cmd>HopLineBC<cr>', 'hop to upper line' },
    S = { '<cmd>HopChar2<cr>', 'hop to chars' },

    -- toggle
    ['t'] = {
      name = 'toggle',
      z = { '<cmd>ZenMode<cr>', 'toggle zen' },
      b = { '<cmd>NvimTreeToggle<cr>', 'toggle file tree' },
      w = { '<cmd>WhichKey<cr>', 'toggle WhichKey' },
      d = { '<cmd>TroubleToggle document_diagnostics<cr>', 'toggle diagnostics (document)' },
      D = { '<cmd>TroubleToggle workspace_diagnostics<cr>', 'toggle diagnostics (workspace)' },
      m = { '<cmd>Glow<cr>', 'toggle markdown' },
      o = { '<cmd>SidebarNvimToggle<CR>', 'toggle outline' },
    },

    -- find
    ['f'] = {
      name = 'find',
      f = { '<cmd>Telescope live_grep_args<cr>', 'find contents' },
      p = { '<cmd>Telescope find_files<cr>', 'find files' },
      P = { '<cmd>Telescope projects<cr>', 'find projects' },
      b = { '<cmd>Telescope buffers previewer=false theme=cursor<cr>', 'find buffers' },
    },

    -- lsp
    ca = { '<cmd>Lspsaga code_action<cr>', 'code action' },
    rn = { '<cmd>Lspsaga rename<cr>', 'rename' },

    -- other
    q = { '<cmd>BufDel<cr>', 'close buffer' },
    Q = { '<cmd>BufDel!<cr>', 'close buffer force' },
    F = { '<cmd>lua require("spectre").open()<cr>', 'find and replace with dark power' },
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
  ['<S-Tab>'] = { [[@=(foldlevel('.')?'za':"\<Tab>")<CR>]], 'toggle fold' },
})

wk.register({
--  ['<leader>'] = {
--    T = { '<cmd>Translate<cr>', 'translate' },
--  },
}, { mode = 'v' })
