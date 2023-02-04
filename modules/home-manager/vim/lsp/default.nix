{ config, pkgs, lib, ... }:

let
  inherit (builtins) readFile;
  lspSharedDepends = with pkgs.vimPlugins; [
    fidget-nvim
    lspsaga-nvim
    # virtual-types-nvim
    lsp-inlayhints-nvim
    telescope-nvim
    actions-preview-nvim
    vim-illuminate
    hover-nvim
    # glow-hover-nvim
  ];
  lspSharedExtraPackages = [ ];
in with pkgs.vimPlugins; [
  {
    plugin = neogen;
    depends = [ nvim-treesitter luasnip ];
    config = readFile ./neogen.lua;
    commands = [ "Neogen" ];
  }
  {
    plugin = lspsaga-nvim;
    depends = [ nvim-lspconfig ];
    config = readFile ./lspsaga-nvim.lua;
    commands = [ "Lspsaga" ];
  }
  {
    plugin = formatter-nvim;
    config = readFile ./formatter-nvim.lua;
    commands = [ "Format" ];
    extraPackages = with pkgs; [ stylua google-java-format nixfmt ];
  }
  {
    plugin = actions-preview-nvim;
    config = readFile ./actions-preview-nvim.lua;
  }
  {
    plugin = fidget-nvim;
    config = ''
      require'fidget'.setup{}
    '';
  }
  {
    plugin = lsp-inlayhints-nvim;
    config = ''
      require('lsp-inlayhints').setup{}
    '';
  }
  {
    plugin = vim-illuminate;
    config = readFile ./vim-illuminate.lua;
  }
  {
    plugin = hover-nvim;
    config = readFile ./hover-nvim.lua;
  }
  {
    plugin = glow-hover-nvim;
    config = ''
      require'glow-hover'.setup {
        max_width = 80,
        padding = 1,
        glow_path = 'glow'
      }
    '';
  }
  # java
  {
    plugin = nvim-jdtls;
    depends = lspSharedDepends ++ [ nvim-dap ];
    extraPackages = lspSharedExtraPackages;
    config = ''
      local runtimes = {
        {
          name = "JavaSE-11",
          path = "${pkgs.jdk11}/",
        },
        {
          name = "JavaSE-17",
          path = "${pkgs.jdk17}/",
          default = true,
        },
      }
      dofile("${./jdt.lua}")({
        on_attach = dofile("${./on_attach.lua}"),
        capabilities = dofile("${./capabilities.lua}"),
        java_bin = "${pkgs.jdk17}/bin/java",
        jdtls_config = "${pkgs.jdt-language-server}/share/config",
        lombok_jar = "${pkgs.lombok}/share/java/lombok.jar",
        jdtls_jar = vim.fn.glob("${pkgs.jdt-language-server}/share/java/plugins/org.eclipse.equinox.launcher_*.jar"),
        jdtls_settings = dofile("${./jdt_settings.lua}")(runtimes),
        java_debug_jar = vim.fn.glob("${pkgs.vscode-extensions.vscjava.vscode-java-debug}/share/vscode/extensions/vscjava.vscode-java-debug/server/com.microsoft.java.debug.plugin-*.jar", 1),
        java_test_jar = vim.fn.glob("${pkgs.vscode-extensions.vscjava.vscode-java-test}/share/vscode/extensions/vscjava.vscode-java-test/server/*.jar", 1),
        jol_jar = "${pkgs.javaPackages.jol}",
      })
    '';
    fileTypes = [ "java" ];
  }
  # haskell
  {
    plugin = haskell-tools-nvim;
    depends = lspSharedDepends ++ (with pkgs; [ plenary-nvim nvim-lspconfig ]);
    extraPackages = lspSharedExtraPackages ++ (with pkgs.pkgs-stable; [
      haskellPackages.fourmolu
      haskell-language-server
    ]);
    config = ''
      dofile("${./haskell.lua}")({
        on_attach = dofile("${./on_attach.lua}"),
        capabilities = dofile("${./capabilities.lua}"),
      })
    '';
    fileTypes = [ "haskell" ];
  }
  # fsharp
  {
    plugin = Ionide-vim;
    depends = lspSharedDepends ++ [ nvim-lspconfig ];
    # extraPackages = WIP...
    # [WIP] dotnet
    # dotnet tool install -g fsautocomplete
    # dotnet tool install -g dotnet-fsharplint
    # dotnet tool install --global fantomas-tool
    startup = ''
      vim.cmd([[
        let g:fsharp#lsp_auto_setup = 0
        let g:fsharp#fsautocomplete_command =[ 'fsautocomplete' ]
      ]])
    '';
    config = ''
      dofile("${./ionide.lua}")({
        on_attach = dofile("${./on_attach.lua}"),
        capabilities = dofile("${./capabilities.lua}"),
      })
    '';
    delay = true;
  }
  {
    plugin = nvim-lspconfig;
    depends = lspSharedDepends ++ [ ];
    # [WIP] dotnet
    # dotnet tool install --global csharp-ls
    extraPackages = lspSharedExtraPackages ++ (with pkgs; [
      dart
      deno
      google-java-format
      gopls
      nil
      nodePackages.bash-language-server
      nodePackages.pyright
      nodePackages.typescript
      nodePackages.vscode-langservers-extracted
      nodePackages.yaml-language-server
      rubyPackages.solargraph
      rust-analyzer
      sumneko-lua-language-server
      taplo-cli
    ]);
    config = ''
      vim.diagnostic.config {
        severity_sort = true
      }
      vim.lsp.set_log_level("off")

      local signs = {
        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn", text = "" },
        { name = "DiagnosticSignHint", text = "" },
        { name = "DiagnosticSignInfo", text = "" },
      }

      for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = "", numhl = "" })
      end

      dofile("${./lspconfig.lua}")({
        lspconfig = require("lspconfig"),
        util = require("lspconfig.util"),
        on_attach = dofile("${./on_attach.lua}"),
        capabilities = dofile("${./capabilities.lua}"),
        eslint_cmd = {
          "${pkgs.nodePackages.vscode-langservers-extracted}/bin/vscode-eslint-language-server",
          "--stdio",
        },
        tsserver_cmd = {
          "${pkgs.nodePackages.typescript-language-server}/bin/typescript-language-server",
          "--stdio",
          "--tsserver-path",
          "${pkgs.nodePackages.typescript}/lib/node_modules/typescript/lib/",
        },
      })
    '';
    delay = true;
  }
  {
    plugin = flutter-tools-nvim;
    depends = [ plenary-nvim ];
    config = ''
      require("flutter-tools").setup ({})
    '';
    fileTypes = [ "dart" ];
  }
]
