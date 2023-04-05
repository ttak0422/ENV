vim.g.mapleader = " "

local key_opts = { noremap = true, silent = true }
local function desc(d)
  return { noremap = true, silent = true, desc = d }
end
local map = vim.keymap.set

local normal_keymaps = {
  -- utils
  { "<esc><esc>", "<cmd>nohl<cr>" },
  { "q", "<nop>" },
  { "j", "gj" },
  { "k", "gk" },
  { "<c-h>", "<cmd>bprev<cr>" },
  { "<c-l>", "<cmd>bnext<cr>" },
  { "[q", "<cmd>lua require('qf').above('c')<cr>" },
  { "]q", "<cmd>lua require('qf').below('c')<cr>" },
  { "[Q", "<cmd>cfirst<cr>" },
  { "]Q", "<cmd>clast<cr>" },
  -- { "<leader>g", "<cmd>JABSOpen<cr>" },
  -- comment
  { "<leader>nc", "<cmd>Neogen class<cr>", desc("class comment") },
  { "<leader>nf", "<cmd>Neogen func<cr>", desc("fn comment") },
  -- motion
  {
    "<c-w><c-w>",
    "<cmd>lua require('chowcho').run()<cr>",
    desc("choose window"),
  },
  {
    "gpd",
    "<cmd>lua require('goto-preview').goto_preview_definition()<CR>",
    desc("preview definition"),
  },
  {
    "gpi",
    "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>",
    desc("preview implementation"),
  },
  {
    "gpr",
    "<cmd>lua require('goto-preview').goto_preview_references()<CR>",
    desc("preview references"),
  },
  {
    "gP",
    "<cmd>lua require('goto-preview').close_all_win()<CR>",
    desc("close all preview"),
  },
  -- git
  {
    "<leader>gg",
    function()
      vim.cmd("Gin " .. vim.fn.input("git command: "))
    end,
    desc("git command (echo)"),
  },
  {
    "<leader>gG",
    function()
      vim.cmd("GinBuffer " .. vim.fn.input("git command: "))
    end,
    desc("git command (buffer)"),
  },
  {
    "<leader>gB",
    "<cmd>GinBuffer ++processor=delta blame %:p<cr>",
    desc("git blame"),
  },
  {
    "<leader>gs",
    "<cmd>GinStatus<cr>",
    desc("git status"),
  },
  {
    "<leader>gl",
    "<cmd>GinLog<cr>",
    desc("git log"),
  },
  {
    "<leader>G",
    "<cmd>Neogit<cr>",
    desc("open git tui"),
  },
  -- window
  { "<c-w>z", "<cmd>NeoZoomToggle<cr>" },
  { "<c-w>e", "<cmd>lua require('smart-splits').start_resize_mode()<cr>", desc("window resize mode") },
  -- tools
  { "<leader>q", "<cmd>BufDel<cr>" },
  { "<leader>Q", "<cmd>BufDel!<cr>" },
  -- toggle
  { "<leader>tb", "<cmd>NvimTreeToggle<cr>" },
  -- { "<leader>tm", "<cmd>MinimapToggle<cr>" },
  { "<leader>tq", "<cmd>lua require('toolwindow').open_window('quickfix', nil)<cr>" },
  {
    "<leader>td",
    "<cmd>lua require('toolwindow').open_window('trouble', {mode = 'document_diagnostics'})<cr>",
    desc("toggle diagnostics (document)"),
  },
  {
    "<leader>tD",
    "<cmd>lua require('toolwindow').open_window('trouble', {mode = 'workspace_diagnostics'})<cr>",
    desc("toggle diagnostics (workspace)"),
  },
  -- finder
  { "<leader>ff", "<cmd>Telescope live_grep_args<cr>", desc("search by content") },
  { "<leader>fp", "<cmd>Telescope find_files<cr>", desc("search by file name") },
  { "<leader>fb", "<cmd>Telescope buffers<cr>", desc("search buffer") },
  { "<leader>fh", "<cmd>Legendary<cr>", desc("search buffer") },
  { "<leader>ft", "<cmd>Telescope sonictemplate templates<cr>", desc("search template") },
  {
    "<leader>fF",
    "<cmd>lua require('spectre').open()<cr>",
    desc("find and replace with dark power"),
  },
  -- obsidian
  { "<leader>oo", "<cmd>ObsidianFollowLink<cr>" },
  { "<leader>oO", "<cmd>ObsidianOpen<cr>" },
  { "<leader>or", "<cmd>ObsidianBacklinks<cr>" },
  { "<leader>ot", "<cmd>ObsidianToday<cr>" },
  { "<leader>of", "<cmd>ObsidianSearch<cr>" },
  { "<leader>op", "<cmd>ObsidianQuickSwitch<cr>" },
  {
    "<leader>on",
    function()
      vim.cmd("ObsidianNew " .. vim.fn.input("name: "))
    end,
    desc("create new note"),
  },
}

for _, keymap in ipairs(normal_keymaps) do
  map("n", keymap[1], keymap[2], keymap[3] or key_opts)
end
