require("neo-zoom").setup({
  exclude_buftypes = {},
  winopts = {
    offset = {
      height = 0.90,
    },
    border = "single",
  },
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
    enabled = true,
  },
})
