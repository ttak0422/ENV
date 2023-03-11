local wk = require("which-key")

wk.setup()
wk.register({
  ["<leader>"] = {
    -- easy motion
    ["<leader>"] = { "<cmd>HopChar1<cr>", "hop to char" },
    -- j = { "<cmd>HopLineAC<cr>", "hop to under line" },
    -- k = { "<cmd>HopLineBC<cr>", "hop to upper line" },
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
      o = { "<cmd>ToggleOutline<cr>", "toggle outline" },
      O = { "<cmd>SidebarNvimToggle<cr>", "toggle outline" },
      q = { "<cmd>lua require('toolwindow').close()<cr>", "toggle toolwindows" },
      C = { "<cmd>ColorizerToggle<cr>", "toggle colorize" },
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
      u = { "<cmd>Telescope undo theme=ivy<cr>", "find undo tree" },
      h = { "<cmd>Legendary<cr>", "find command palette" },
      F = { "<cmd>lua require('spectre').open()<cr>", "find and replace with dark power" },
    },

    -- find (ddu)
    ["u"] = {
      p = { "<cmd>Ddu file_rec<cr>", "find contents" },
      b = { "<cmd>Ddu buffer<cr>", "find contents" },
    },

    -- comment
    ["n"] = {
      name = "comment",
      c = { "<cmd>Neogen class<cr>", "comment (class)" },
      f = { "<cmd>Neogen func<cr>", "comment (func)" },
      t = { "<cmd>Neogen type<cr>", "comment (type)" },
    },

    -- obsidian
    ["o"] = {
      o = { "<cmd>ObsidianFollowLink<cr>", "open link" },
      O = { "<cmd>ObsidianOpen<cr>", "open link with app" },
      r = { "<cmd>ObsidianBacklinks<cr>", "show backlist" },
      t = { "<cmd>ObsidianToday<cr>", "open today diary" },
      f = { "<cmd>ObsidianSearch<cr>", "search content" },
      p = { "<cmd>ObsidianQuickSwitch<cr>", "search note" },
      n = {
        function()
          vim.cmd("ObsidianNew " .. vim.fn.input("name: "))
        end,
        "create note",
      },
    },

    -- other
    q = { "<cmd>BufDel<cr>", "close buffer" },
    Q = { "<cmd>BufDel!<cr>", "close buffer force" },
    G = { "<cmd>ToggleTig<cr>", "tig" },
    T = { "<cmd>tabnew<cr>", "tabnew" },
    j = { "<cmd>SplitjoinJoin<cr>", "to oneline" },
    s = { "<cmd>SplitjoinSplit<cr>", "to multiline" },
  },
})

wk.register({
  ["<c-w>"] = {
    z = { "<cmd>NeoZoomToggle<cr>", "zoom pane" },
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
    x = { "<cmd>lua require('open').open_cword()<cr>", "opener" },
  },
})

wk.register({
  -- ["<Tab>"] = { [[@=(foldlevel('.')?'za':"\<Tab>")<CR>]], "toggle fold" },
  ["<C-t>"] = { "<cmd>ToggleTerm<cr>", "toggle terminal" },
  ["<C-h>"] = { '<cmd>lua require("cybu").cycle("prev")<cr>', "move prev buf" },
  ["<C-l>"] = { '<cmd>lua require("cybu").cycle("next")<cr>', "move next buf" },
  ["<C-k>"] = { '<cmd>lua require("cybu").cycle("prev", "last_used")<cr>', "move prev last used buf" },
  ["<C-j>"] = { '<cmd>lua require("cybu").cycle("next", "last_used")<cr>', "move next last used buf" },
  --["<C-t>"] = {
  --  "<cmd>lua require('toolwindow').open_window('term', nil)<cr>",
  --  "toggle terminal",
  --},
})

wk.register({
  ["<C-t>"] = { "<cmd>ToggleTerm<cr>", "toggle terminal" },
  -- ["<C-t>"] = {
  --   "<cmd>lua require('toolwindow').open_window('term', nil)<cr>",
  --   "toggle terminal",
  -- },
}, { mode = "t" })

wk.register({
  --  ['<leader>'] = {
  --    T = { '<cmd>Translate<cr>', 'translate' },
  --  },
}, { mode = "v" })
