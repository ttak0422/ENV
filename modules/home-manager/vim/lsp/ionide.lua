return function(opt)
  require("ionide").setup({
    autostart = true,
    on_attach = opt.on_attach,
    capabilities = opt.capabilities,
    flags = {
      debounce_text_changes = 150,
    },
  })
end
