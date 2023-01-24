return function(opt)
  local lspconfig = opt.lspconfig
  local util = opt.util
  local on_attach = opt.on_attach
  local capabilities = opt.capabilities
  local eslint_cmd = opt.eslint_cmd
  local tsserver_cmd = opt.tsserver_cmd

  -- lua
  lspconfig.sumneko_lua.setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })

  -- nix
  -- lspconfig.rnix.setup({
  --   on_attach = on_attach,
  --   capabilities = capabilities,
  -- })
  -- nix
  -- require nil, nixpkgs-fmt
  lspconfig.nil_ls.setup({
    autostart = true,
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      ["nil"] = {
        formatting = {
          command = { "nixpkgs-fmt" },
        },
      },
    },
  })

  -- bash
  lspconfig.bashls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })

  -- fsharp (use ionide-vim)

  local node_root_dir = util.root_pattern("package.json", "node_modules")
  local is_node_repo = node_root_dir(".") ~= nil

  if not is_node_repo then
    -- deno
    vim.g.markdown_fenced_languages = { "ts=typescript" }
    lspconfig.denols.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
  else
    -- node
    lspconfig.tsserver.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      cmd = tsserver_cmd,
    })
  end

  -- csharp (use csharp_ls)
  lspconfig.csharp_ls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })

  -- python
  lspconfig.pyright.setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })

  -- ruby
  lspconfig.solargraph.setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })

  -- toml
  lspconfig.taplo.setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })

  -- rust
  lspconfig.rust_analyzer.setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })

  -- go
  lspconfig.gopls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
        },
      },
      staticcheck = true,
    },
  })

  -- dart
  lspconfig.dartls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })

  -- yaml
  lspconfig.yamlls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })

  -- eslint
  lspconfig.eslint.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = eslint_cmd,
  })
end
