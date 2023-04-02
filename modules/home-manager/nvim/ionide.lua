require("ionide").setup({
  autostart = true,
  on_attach = dofile(args.on_attach_path),
  capabilities = dofile(args.capabilities_path),
  flags = {
    -- debounce_text_changes = 150,
  },
})

vim.cmd([[LspStart]])
