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
      -- s = { '<cmd>SidebarNvimToggle<cr>', 'Toggle Sidebar Toggle' },
      d = { '<cmd>TroubleToggle<cr>', 'Toggle Diagnostics' },
      m = { '<cmd>Glow<cr>', 'Toggle Markdown Preview' },
      o = { '<cmd>AerialToggle<cr>', 'Toggle Outline' },
    },
    ['f'] = {
      name = 'find',
      f = { '<cmd>Telescope live_grep_raw<cr>', 'find contents' },
      p = { '<cmd>Telescope find_files<cr>', 'find files' },
      b = { '<cmd>Telescope buffers<cr>', 'find buffers' },
    },
    ['r'] = {
      name = 'run',
      f = { '<cmd>RunFile<cr>', 'run file' },
      p = { '<cmd>RunProject<cr>', 'run project' },
    },
    s = { '<cmd>HopChar1<cr>', 'hop to char' },
    S = { '<cmd>HopChar2<cr>', 'hop to chars' },
    j = { '<cmd>HopLineAC<cr>', 'hop to under line' },
    k = { '<cmd>HopLineBC<cr>', 'hop to upper line' },
    Q = { '<cmd>BufDel!<cr>', 'close buffer force' },
    q = { '<cmd>BufDel<cr>', 'close buffer' },
    -- nc = { ':lua require("neogen").generate({ type = "class" })<cr>' }, wip
    ca = { '<cmd>Lspsaga code_action<cr>', 'code action' },
    rn = { '<cmd>Lspsaga rename<cr>', 'rename' },
  },
})

wk.register({
  ['<c-w>'] = {
    z = { '<cmd>ZoomWinTabToggle<cr>', 'zoom pane' },
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
  },
})
