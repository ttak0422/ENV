local rt = require("rust-tools")
rt.setup({
  server = {
    on_attach = dofile(args.on_attach_path),
    capabilities = dofile(args.capabilities_path),
    settings = {
      ["rust-analyzer"] = {
        files = {
          excludeDirs = { ".direnv" },
        },
      },
    },
  },
})
rt.inlay_hints.enable()

vim.cmd([[LspStart]])
