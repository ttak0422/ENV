local node_root_dir = require("lspconfig").util.root_pattern("package.json", "node_modules")
local buf_name = vim.api.nvim_buf_get_name(0)
local current_buf = vim.api.nvim_get_current_buf()
local is_node = node_root_dir(buf_name, current_buf) ~= nil

if is_node then
  require("typescript").setup({
    disable_commands = false,
    debug = false,
    go_to_source_definition = {
      fallback = true,
    },
    server = {
      on_attach = dofile(args.on_attach_path),
      capabilities = dofile(args.capabilities_path),
      cmd = args.tsserver_cmd,
      init_options = {
        hostInfo = "neovim",
        maxTsServerMemory = 8192,
        tsserver = {
          path = args.tsserver_path,
        },
        preferences = {
          allowIncompleteCompletions = true,
        },
      },
      single_file_support = false,
    },
  })

  vim.cmd([[LspStart]])
end
