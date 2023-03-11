return function(opt)
  local rt = require("rust-tools")
  rt.setup({
    server = {
      on_attach = opt.on_attach,
      capabilities = opt.capabilities,
    },
  })
  rt.inlay_hints.enable()
end
