require("neo-zoom").setup({
  isable_by_cursor = true,
  border = "single",
  exclude_buftypes = {},
  presets = {
    {
      filetypes = { "dapui_.*", "dap-repl" },
      config = {
        top_ratio = 0.25,
        left_ratio = 0.4,
        width_ratio = 0.6,
        height_ratio = 0.65,
      },
      callbacks = {
        function()
          vim.wo.wrap = true
        end,
      },
    },
  },
  popup = {
    enabled = false,
  },
})
