return function(opt)
  local ht = require("haskell-tools")
  ht.setup({
    hls = {
      on_attach = opt.on_attach,
      capabilities = opt.capabilities,
    },
  })
end
