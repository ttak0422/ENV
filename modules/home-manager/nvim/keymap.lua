vim.g.mapleader = " "

local key_opts = { noremap = true, silent = true }
local function desc(d)
  return { noremap = true, silent = true, desc = d }
end

local function toggle_tool()
  local is_open = false
  local pre_id = nil
  return function(id, mod, opt)
    return function()
      local t = require("toolwindow")
      if pre_id ~= id then
        t.open_window(mod, opt)
        is_open = true
      else
        if is_open then
          t.close()
          is_open = false
        else
          t.open_window(mod, opt)
          is_open = true
        end
      end
      pre_id = id
    end
  end
end
local toggle = toggle_tool()
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
  { "<c-w>q", "<cmd>SafeCloseWindow<cr>" },
  { "<c-w><c-q>", "<cmd>SafeCloseWindow<cr>" },
  -- { "<leader>g", "<cmd>JABSOpen<cr>" },
  -- split/join
  { "<leader>m", "<cmd>lua require('treesj').toggle()<cr>", desc("toggle split/join") },
  {
    "<leader>M",
    "<cmd>lua require('treesj').toggle({ split = { recursive = true } })<cr>",
    desc("toggle split/join rec"),
  },
  -- motion
  {
    "<c-w><c-w>",
    "<cmd>lua require('nvim-window').pick()<cr>",
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
  { "<leader>E", "<cmd>FeMaco<cr>", desc("edit code block") },
  -- toggle
  { "<leader>tb", "<cmd>NvimTreeToggle<cr>" },
  { "<leader>tq", toggle(1, "quickfix", nil), desc("open quickfix") },
  {
    "<leader>td",
    toggle(2, "trouble", { mode = "document_diagnostics" }),
    desc("open diagnostics (document)"),
  },
  {
    "<leader>tD",
    toggle(3, "trouble", { mode = "workspace_diagnostics" }),
    desc("open diagnostics (workspace)"),
  },
  -- finder
  { "<leader>ff", "<cmd>Telescope live_grep_args<cr>", desc("search by content") },
  { "<leader>fp", "<cmd>Telescope find_files<cr>", desc("search by file name") },
  { "<leader>fP", "<cmd>Telescope projects<cr>", desc("search project") },
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
  -- neorg
  { "<leader>nn", "<cmd>Neorg index<cr>" },
  { "<leader>nt", "<cmd>Neorg journal today<cr>", desc("neorg today") },
  { "<leader>ny", "<cmd>Neorg journal yesterday<cr>", desc("neorg today") },
}

for _, keymap in ipairs(normal_keymaps) do
  map("n", keymap[1], keymap[2], keymap[3] or key_opts)
end

for _, key in ipairs({ "w", "e", "b" }) do
  map("n", key, "<cmd>lua require('spider').motion('" .. key .. "')<cr>")
end

-- toggle term
for i = 0, 9 do
  map("n", "<leader>t" .. i, "<cmd>TermToggle " .. i .. "<cr>", desc("toggle terminal " .. i))
end
map("n", "<leader>tg", "<cmd>TigTermToggle<cr>", desc("toggle tig terminal "))

-- reacher
map({ "n", "x" }, "gs", "<cmd>lua require('reacher').start()<cr>", desc("search displayed"))
map({ "n", "x" }, "gS", "<cmd>lua require('reacher').start_multiple()<cr>", desc("search displayed"))
