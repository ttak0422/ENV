function _OpenTig()
  vim.cmd([[
    execute 'new term://tig status'
    setlocal bufhidden=delete
    setlocal noswapfile
    setlocal nobuflisted
  ]])
end

local wk = require("which-key")

wk.setup()
wk.register({
  ["<leader>"] = {
    -- easy motion
    ["<leader>"] = { "<cmd>HopChar1<cr>", "hop to char" },
    j = { "<cmd>HopLineAC<cr>", "hop to under line" },
    k = { "<cmd>HopLineBC<cr>", "hop to upper line" },
    S = { "<cmd>HopChar2<cr>", "hop to chars" },

    -- toggle
    ["t"] = {
      name = "toggle",
      z = { "<cmd>ZenMode<cr>", "toggle zen" },
      b = { "<cmd>NvimTreeToggle<cr>", "toggle file tree" },
      w = { "<cmd>WhichKey<cr>", "toggle WhichKey" },
      d = {
        "<cmd>lua require('toolwindow').open_window('trouble', {mode = 'document_diagnostics'})<cr>",
        "toggle diagnostics (document)",
      },
      D = {
        "<cmd>lua require('toolwindow').open_window('trouble', {mode = 'workspace_diagnostics'})<cr>",
        "toggle diagnostics (workspace)",
      },
      m = { "<cmd>Glow<cr>", "toggle markdown" },
      o = { "<cmd>SymbolsOutline<cr>", "toggle outline" },
      O = { "<cmd>SidebarNvimToggle<cr>", "toggle outline" },
      q = { "<cmd>lua require('toolwindow').close()<cr>", "toggle toolwindows" },
    },

    -- find
    ["f"] = {
      name = "find",
      f = { "<cmd>Telescope live_grep_args theme=ivy<cr>", "find contents" },
      p = { "<cmd>Telescope find_files theme=ivy<cr>", "find files" },
      r = { "<cmd>Telescope oldfiles theme=ivy<cr>", "find files" },
      P = { "<cmd>Telescope projects theme=ivy<cr>", "find projects" },
      b = { "<cmd>Telescope buffers theme=ivy<cr>", "find buffers" },
      c = { "<cmd>Telescope command_history theme=ivy<cr>", "find command history" },
      C = { "<cmd>Telescope command_palette<cr>", "find command history" },
      t = { "<cmd>Telescope sonictemplate templates theme=ivy<cr>", "find templates" },
    },

    -- lsp
    ca = { "<cmd>Lspsaga code_action<cr>", "code action" },
    rn = { "<cmd>Lspsaga rename<cr>", "rename" },

    -- comment
    ["n"] = {
      name = "comment",
      c = { "<cmd>Neogen class<cr>", "comment (class)" },
      f = { "<cmd>Neogen func<cr>", "comment (func)" },
      t = { "<cmd>Neogen type<cr>", "comment (type)" },
    },

    -- other
    q = { "<cmd>BufDel<cr>", "close buffer" },
    Q = { "<cmd>BufDel!<cr>", "close buffer force" },
    G = { "<cmd>lua _OpenTig()<cr>", "tig" },
    H = { "<cmd>Legendary<cr>", "command palette" },
    -- F = { '<cmd>lua require("spectre").open()<cr>', 'find and replace with dark power' },
  },
})

wk.register({
  ["<c-w>"] = {
    z = { "<cmd>TZFocus<cr>", "zoom pane" },
    ["<c-w>"] = { "<cmd>Chowcho<cr>", "chose window" },
  },
})

wk.register({
  ["g"] = {
    name = "goto",
    ["p"] = {
      name = "preview",
      d = { '<cmd>lua require("goto-preview").goto_preview_definition()<CR>', "preview definition" },
      i = { '<cmd>lua require("goto-preview").goto_preview_implementation()<CR>', "preview implementation" },
      r = { '<cmd>lua require("goto-preview").goto_preview_references()<CR>', "preview references" },
    },
    P = { '<cmd>lua require("goto-preview").close_all_win()<CR>', "close all preview" },
    b = { "<cmd>BufferLinePick<CR>", "pick buffer" },
    w = { "<cmd>Chowcho<cr>", "choose pane" },
  },
})

wk.register({
  ["<Tab>"] = { [[@=(foldlevel('.')?'za':"\<Tab>")<CR>]], "toggle fold" },
  --["<C-t>"] = { "<cmd>ToggleTerm<cr>", "toggle terminal" },
  ["<C-t>"] = {
    "<cmd>lua require('toolwindow').open_window('term', nil)<cr>",
    "toggle terminal",
  },
})

wk.register({
  -- ["<C-t>"] = { "<cmd>ToggleTerm<cr>", "toggle terminal" },
  ["<C-t>"] = {
    "<cmd>lua require('toolwindow').open_window('term', nil)<cr>",
    "toggle terminal",
  },
}, { mode = "t" })

wk.register({
  --  ['<leader>'] = {
  --    T = { '<cmd>Translate<cr>', 'translate' },
  --  },
}, { mode = "v" })
