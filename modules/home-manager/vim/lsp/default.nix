{ config, pkgs, lib, ... }:

let
  inherit (builtins) readFile;
  lspSharedDepends = with pkgs.vimPlugins; [
    fidget-nvim
    nvim-cmp
    lspsaga-nvim
    # virtual-types-nvim
    lsp-inlayhints-nvim
    telescope-nvim
    actions-preview-nvim
    vim-illuminate
  ];
  lspSharedExtraPackages = [ ];
in with pkgs.vimPlugins; [
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
  # java
  {
    plugin = nvim-jdtls;
    depends = lspSharedDepends ++ [ ];
    extraPackages = lspSharedExtraPackages;
    config = ''
      local jdtls = require("jdtls")
      local root = require("jdtls.setup").find_root({".git", "mvnw", "gradlew"})
      local workspace = os.getenv("HOME") .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root, ":p:h:t")
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
      local config = {
        on_attach = dofile("${./on_attach.lua}"),
        capabilities = dofile("${./capabilities.lua}"),
        cmd = {
          "${pkgs.jdk17}/bin/java",
          "-Declipse.application=org.eclipse.jdt.ls.core.id1",
          "-Dosgi.bundles.defaultStartLevel=4",
          "-Declipse.product=org.eclipse.jdt.ls.core.product",
          "-Dosgi.sharedConfiguration.area=${pkgs.jdt-language-server}/share/config",
          "-Dosgi.sharedConfiguration.area.readOnly=true",
          "-Dosgi.checkConfiguration=true",
          "-Dosgi.configuration.c:ascaded=true",
          "-Dlog.level=NONE",
          "-XX:+UseG1GC",
          "-XX:GCTimeRatio=4",
          "-XX:AdaptiveSizePolicyWeight=90",
          "-XX:MaxGCPauseMillis=200",
          "-Dsun.zip.disableMemoryMapping=true",
          "-Xms1G",
          "-Xmx12G",
          "-Xlog:disable",
          "-javaagent:${pkgs.lombok}/share/java/lombok.jar",
          "-jar",
          vim.fn.glob("${pkgs.jdt-language-server}/share/java/plugins/org.eclipse.equinox.launcher_*.jar"),
          "--add-modules=ALL-SYSTEM",
          "--add-opens java.base/java.util=ALL-UNNAMED",
          "--add-opens java.base/java.lang=ALL-UNNAMED",
          "-data",
          workspace,
        },
        root_dir = root,
        settings = dofile("${./jdt_settings.lua}")(runtimes),
        init_options = {
          bundles = {},
        },
        flags = {
          debounce_text_changes = 500,
          allow_incremental_sync = false,
        },
        handlers = {
          ["client/registerCapability"] = function(_, _, _, _)
            return {
              result = nil,
              error = nil,
            }
          end,
        },
      }
      jdtls.start_or_attach(config)
      vim.api.nvim_create_augroup("jdtls_lsp", { clear = true, })
      vim.api.nvim_create_autocmd({ "FileType" }, {
        group = group_name,
        pattern = {"java"},
        callback = function()
          jdtls.start_or_attach(config)
        end,
      })
    '';
    fileTypes = [ "java" ];
  }
  # haskell
  # {
  #   plugin = haskell-tools-nvim;
  #   depends = lspSharedDepends ++ (with pkgs; [ plenary-nvim nvim-lspconfig ]);
  #   extraPackages = lspSharedExtraPackages ++ (with pkgs; [
  #     haskellPackages.fourmolu
  #     haskellPackages.haskell-language-server
  #   ]);
  #   config = ''
  #     local ht = require('haskell-tools')
  #     ht.setup {
  #       -- hls = {
  #       --   on_attach = dofile("${./on_attach.lua}"),
  #       --   capabilities = dofile("${./capabilities.lua}"),
  #       -- },
  #     }
  #   '';
  #   fileTypes = [ "haskell" ];
  # }
  {
    plugin = nvim-lspconfig;
    depends = lspSharedDepends ++ [ ];
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

      local signs = {
        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn", text = "" },
        { name = "DiagnosticSignHint", text = "" },
        { name = "DiagnosticSignInfo", text = "" },
      }

      for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
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
        }
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
