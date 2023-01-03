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
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

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
