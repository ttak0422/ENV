local dap = require("dap")
local dapui = require("dapui")

vim.api.nvim_set_hl(0, "dapblue", { fg = "#3d59a1" })
vim.api.nvim_set_hl(0, "dapgreen", { fg = "#9ece6a" })
vim.api.nvim_set_hl(0, "dapyellow", { fg = "#FFFF00" })
vim.api.nvim_set_hl(0, "daporange", { fg = "#f09000" })

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "dapblue", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = "ﳁ", texthl = "dapblue", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "daporange", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "▶", texthl = "dapgreen", linehl = "", numhl = "" })
vim.fn.sign_define("DapLogPoint", { text = "", texthl = "dapyellow", linehl = "", numhl = "" })

dapui.setup({
  icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
})

dap.listeners.before.event_terminated["dapui_config"] = function()
  -- dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  -- dapui.close()
end

require("nvim-dap-virtual-text").setup({
  commented = true,
  highlight_changed_variables = false,
  all_frames = true,
})
require("dap-go").setup({
  dap_configurations = {
    {
      type = "go",
      name = "Attach remote",
      mode = "remote",
      request = "attach",
    },
  },
  delve = {
    initialize_timeout_sec = 20,
    port = "${port}",
  },
})

-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "dap-repl",
--   callback = function(args)
--     vim.api.nvim_buf_set_option(args.buf, "buflisted", false)
--   end,
-- })

local map = vim.keymap.set
local function desc(d)
  return { noremap = true, silent = true, desc = d }
end

map("n", "<F5>", dap.continue, desc("[dap] continue"))
map("n", "<F10>", dap.step_over, desc("[dap] step over"))
map("n", "<F11>", dap.step_into, desc("[dap] step into"))
map("n", "<F12>", dap.step_out, desc("[dap] step out"))
map("n", "<leader>db", dap.toggle_breakpoint, desc("[dap] toggle breakpoint"))
map("n", "<leader>dr", dap.repl.toggle, desc("[dap] open repl"))
map("n", "<leader>dl", dap.run_last, desc("[dap] run last"))
map("n", "<leader>dB", function()
  dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, desc("[dap] set breakpoint with condition"))
map("n", "<leader>dd", function()
  require("dapui").toggle({ reset = true })
end, desc("[dap] toggle ui"))
