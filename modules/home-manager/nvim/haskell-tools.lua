local ht = require("haskell-tools")
ht.setup({
  hls = {
    on_attach = dofile(args.on_attach_path),
    capabilities = dofile(args.capabilities_path),
  },
})
