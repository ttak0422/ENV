return function(opt)
  local lspconfig = opt.lspconfig
  local util = opt.util
  local on_attach = opt.on_attach
  local capabilities = opt.capabilities
  local eslint_cmd = opt.eslint_cmd
  local tsserver_cmd = opt.tsserver_cmd
  local tsserver_path = opt.tsserver_path

  -- lua
  lspconfig.lua_ls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
        },
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
        },
        telemetry = {
          enable = false,
        },
      },
    },
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

  -- deno
  lspconfig.denols.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    root_dir = util.root_pattern("deno.json", "deno.jsonc", "denops"),
    single_file_support = false,
  })

  -- node
  lspconfig.tsserver.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = tsserver_cmd,
    root_dir = util.root_pattern("package.json"),
    iniy_options = {
      hostInfo = "neovim",
      maxTsServerMemory = 8192,
      tsserver = {
        path = tsserver_path,
      },
    },
    single_file_support = false,
  })

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
  -- lspconfig.rust_analyzer.setup({
  --   on_attach = on_attach,
  --   capabilities = capabilities,
  -- })

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

  -- html
  lspconfig.html.setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })

  -- css, scss, less
  lspconfig.cssls.setup({
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
