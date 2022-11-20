{ config, pkgs, lib, ... }:

let
  inherit (builtins) concatStringsSep map fetchTarball readFile;
  inherit (lib.strings) fileContents;
  inherit (lib.lists) singleton;
  inherit (pkgs) fetchFromGitHub writeText;
  inherit (pkgs.stdenv) mkDerivation;
  inherit (pkgs.vimUtils) buildVimPluginFrom2Nix;
  lspSharedConfig = readFile ./lsp-share.lua;
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
  lspSharedExtraPackages = with pkgs; [ ];
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
  {
    plugin = nvim-jdtls;
    depends = lspSharedDepends ++ [ ];
    extraPackages = lspSharedExtraPackages ++ (with pkgs; [ jdk ]);
    config = ''
      local jdtls = require('jdtls')

      local make_settings = function()
        local url = vim.g.java_format_settings_url
        local profile = vim.g.java_format_settings_profile
        local cfg = {
          java = {
            import = {
              gradle = {
                enabled = true,
                offline = {
                  enabled = true
                }
              },
              maven = {
                enabled = true
              },
              exclusions = {
                "**/node_modules/**",
                "**/.metadata/**",
                "**/archetype-resources/**",
                "**/META-INF/maven/**",
              },
            },
            eclipse = {
              downloadSources = true,
            },
            configuration = {
              updateBuildConfiguration = "automatic",
            },
            maven = {
              downloadSources = true,
              updateSnapshots = true,
            },
            implementationsCodeLens = {
              enabled = true,
            },
            referencesCodeLens = {
              enabled = true,
            },
            references = {
              includeDecompiledSources = true,
            },
            inlayHints = {
              parameterNames = {
                enabled = 'literals', -- literals, all, none
              },
            },
            signatureHelp = { enabled = true, description = { enabled = true } },
            completion = {
              enabled = true,
              guessMethodArguments = true,
              favoriteStaticMembers = {
                'org.hamcrest.MatcherAssert.assertThat',
                'org.hamcrest.Matchers.*',
                'org.hamcrest.CoreMatchers.*',
                'org.junit.jupiter.api.Assertions.*',
                'java.util.Objects.requireNonNull',
                'java.util.Objects.requireNonNullElse',
                'org.mockito.Mockito.*'
              },
              importOrder = {
                'org.springframework',
                'java.util',
                'java',
                'javax',
                'com',
                'org'
              },
              filteredTypes = {
                'com.sun.*',
                'io.micrometer.shaded.*',
                'java.awt.*',
                'jdk.*',
                'sun.*',
              },
            },
          },
        }
        if url ~= nil then
          cfg['java.format.settings.url'] = url
        end
        if profile ~= nil then
          cfg['java.format.settings.profile'] = profile
        end
        return cfg
      end

      local mk_config = function()
        local root = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'})
        local workspace = os.getenv('HOME') .. '/.local/share/eclipse/' .. vim.fn.fnamemodify(root, ':p:h:t')
        ${lspSharedConfig}
        return {
          on_attach = on_attach,
          capabilities = capabilities,
          cmd = {
            'java',
            '-Declipse.application=org.eclipse.jdt.ls.core.id1',
            '-Dosgi.bundles.defaultStartLevel=4',
            '-Declipse.product=org.eclipse.jdt.ls.core.product',
            '-Dosgi.sharedConfiguration.area=${pkgs.jdt-language-server}/share/config',
            '-Dosgi.sharedConfiguration.area.readOnly=true',
            '-Dosgi.checkConfiguration=true',
            '-Dosgi.configuration.c:ascaded=true',
            '-Dlog.level=ALL',
            '-XX:+UseG1GC',
            '-XX:GCTimeRatio=4',
            '-XX:AdaptiveSizePolicyWeight=90',
            '-XX:MaxGCPauseMillis=200',
            '-Dsun.zip.disableMemoryMapping=true',
            '-Xms128m',
            '-Xmx12G',
            '-Xlog:disable',
            '-javaagent:${pkgs.lombok}/share/java/lombok.jar',
            '-jar',
            vim.fn.glob('${pkgs.jdt-language-server}/share/java/plugins/org.eclipse.equinox.launcher_*.jar'),
            '--add-modules=ALL-SYSTEM',
            '--add-opens',
            'java.base/java.util=ALL-UNNAMED',
            '--add-opens',
            'java.base/java.lang=ALL-UNNAMED',
            '-data',
            workspace,
          },
          root_dir = root,
          settings = make_settings(),
          init_options = {
            bundles = {},
          },
          flags = {
            debounce_text_changes = 150,
            allow_incremental_sync = true,
            -- server_side_fuzzy_completion = true,
          },
          handlers = {
            ['client/registerCapability'] = function(_, _, _, _)
              return {
                result = nil,
                error = nil,
              }
            end
          },
        }
      end
      jdtls.start_or_attach(mk_config())

      local group_name = 'jdtls_lsp'
      vim.api.nvim_create_augroup(group_name, { clear = true, })
      vim.api.nvim_create_autocmd({ 'FileType' }, {
        group = group_name,
        pattern = {'java'},
        callback = function()
          jdtls.start_or_attach(mk_config())
        end,
      })
    '';
    fileTypes = [ "java" ];
  }
  {
    plugin = nvim-lspconfig;
    depends = lspSharedDepends ++ (with pkgs; [ ]);
    extraPackages = lspSharedExtraPackages ++ (with pkgs; [
      gopls
      rnix-lsp
      rubyPackages.solargraph
      rust-analyzer
      sumneko-lua-language-server
      # stylua
      # nodePackages.prettier
      nodePackages.vscode-langservers-extracted
      # statix
      # nixfmt
      google-java-format
      deno
      dart
    ]) ++ (with pkgs.pkgs-stable; [
      nodePackages.bash-language-server
      nodePackages.pyright
      nodePackages.typescript-language-server
      nodePackages.yaml-language-server
      taplo-cli
    ]);
    config = ''
      ${lspSharedConfig}

      local lspconfig = require('lspconfig')
      local util = require 'lspconfig.util'

      vim.diagnostic.config {
        severity_sort = true
      }

      local signs = {
        { name = 'DiagnosticSignError', text = '' },
        { name = 'DiagnosticSignWarn', text = '' },
        { name = 'DiagnosticSignHint', text = '' },
        { name = 'DiagnosticSignInfo', text = '' },
      }

      for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
      end

      -- lua
      lspconfig.sumneko_lua.setup {
        on_attach = on_attach,
        capabilities = capabilities,
      }

      -- nix
      lspconfig.rnix.setup {
        on_attach = on_attach,
        capabilities = capabilities,
      }

      -- bash
      lspconfig.bashls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
      }

      -- fsharp
      -- `dotnet tool install --global fsautocomplete`
      lspconfig.fsautocomplete.setup {
        on_attach = on_attach,
        capabilities = capabilities,
      }

      local node_root_dir = util.root_pattern('package.json', 'node_modules')
      local is_node_repo = node_root_dir('.') ~= nil

      if not is_node_repo then
        -- deno
        vim.g.markdown_fenced_languages = {'ts=typescript'}
        lspconfig.denols.setup {
          on_attach = on_attach,
          capabilities = capabilities,
        }
      else
        -- node
        lspconfig.tsserver.setup {
          on_attach = on_attach,
          capabilities = capabilities,
        }
      end

      -- python
      lspconfig.pyright.setup {
        on_attach = on_attach,
        capabilities = capabilities,
      }

      -- ruby
      lspconfig.solargraph.setup {
        on_attach = on_attach,
        capabilities = capabilities,
      }

      -- toml
      lspconfig.taplo.setup {
        on_attach = on_attach,
        capabilities = capabilities,
      }

      -- rust
      lspconfig.rust_analyzer.setup {
        on_attach = on_attach,
        capabilities = capabilities,
      }

      -- go
      lspconfig.gopls.setup {
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
      }

      -- dart
      lspconfig.dartls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
      }

      -- yaml
      lspconfig.yamlls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
      }

      -- eslint
      lspconfig.eslint.setup{
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = { '${pkgs.nodePackages.vscode-langservers-extracted}/bin/vscode-eslint-language-server', '--stdio' },
      }
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
