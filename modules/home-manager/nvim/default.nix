{ config, pkgs, lib, ... }:
let
  inherit (builtins) readFile;
  inherit (pkgs) stdenv nix-filter;

  startPlugins = with pkgs.vimPlugins; [
    vim-sensible
    vim-poslist
    {
      plugin = tokyonight-nvim;
      startup = "vim.cmd[[colorscheme tokyonight]] ";
    }
    {
      plugin = nvim-config-local;
      startup = readFile ./config-local.lua;
    }
    # {
    #   plugin = alpha-nvim;
    #   startup = readFile ./alpha.lua;
    # }
    {
      plugin = stickybuf-nvim;
      startup = readFile ./stickybuf.lua;
    }
    # {
    #   plugin = persisted-nvim;
    #   startup = {
    #     lang = "lua";
    #     code = readFile ./persisted.lua;
    #     args = { exclude_ft_path = ./shared/exclude_ft.lua; };
    #   };
    # }
  ];

  # opt plugins.
  motion = with pkgs.vimPlugins; [
    {
      plugin = reacher-nvim;
      config = readFile ./reacher.lua;
      modules = [ "reacher" ];
    }
    # {
    #   plugin = chowcho-nvim;
    #   config = readFile ./chowcho.lua;
    #   modules = [ "chowcho" ];
    # }
    {
      plugin = nvim-window;
      config = readFile ./nvim-window.lua;
      modules = [ "nvim-window" ];
    }
    {
      plugin = JABS-nvim;
      config = readFile ./JABS.lua;
      commands = [ "JABSOpen" ];
    }
    {
      plugin = leap-nvim;
      depends = [ vim-repeat ];
      config = readFile ./leap.lua;
      events = [ "CursorMoved" ];
    }
    {
      plugin = flit-nvim;
      config = readFile ./flit.lua;
      events = [ "CursorMoved" ];
    }
    {
      plugin = tabout-nvim;
      config = readFile ./tabout.lua;
      dependBundles = [ "treesitter" ];
      events = [ "InsertEnter" ];
    }
  ];
  tool = with pkgs.vimPlugins; [
    {
      plugin = toggleterm-nvim;
      config = {
        lang = "lua";
        code = readFile ./toggleterm.lua;
      };
      commands = [ "TermToggle" "TigTermToggle" ];
    }
    {
      plugin = nvim-FeMaco-lua;
      # depends = [ nvim-treesitter' ];
      dependBundles = [ "treesitter" ];
      config = readFile ./femaco.lua;
      commands = [ "FeMaco" ];
    }
    {
      plugin = smart-splits-nvim;
      config = readFile ./smart-splits.lua;
      depends = [{
        plugin = bufresize-nvim;
        config = readFile ./bufresize.lua;
        events = [ "WinNew" ];
      }];
      modules = [ "smart-splits" ];
    }
    {
      plugin = NeoZoom-lua;
      config = readFile ./neo-zoom.lua;
      commands = [ "NeoZoomToggle" ];
    }
    {
      plugin = vim-fontzoom;
      preConfig = readFile ./fontzoom-pre.lua;
      commands = [ "Fontzoom" ];
    }
    {
      plugin = pommodoro-clock;
      depends = [ nui-nvim ];
      config = readFile ./pomodoro.lua;
      commands = [ "Pomodoro" ];
    }
    # {
    #   plugin = hologram-nvim;
    #   config = readFile ./hologram.lua;
    #   filetypes = [ "markdown" ];
    # }
    {
      plugin = pets-nvim;
      depends = [ hologram-nvim nui-nvim ];
      config = readFile ./pets.lua;
      commands = [ "PetsNew" ];
    }
    {
      # regex search panel.
      plugin = nvim-spectre;
      depends = [ plenary-nvim nvim-web-devicons ];
      config = readFile ./spectre.lua;
      extraPackages = with pkgs; [ gnused ripgrep ];
      modules = [ "spectre" ];
    }
    {
      plugin = registers-nvim;
      config = readFile ./registers.lua;
      events = [ "CursorMoved" ];
    }
    {
      plugin = nvim-bufdel;
      config = readFile ./bufdel.lua;
      commands = [ "BufDel" "BufDel!" ];
    }
    # {
    #   plugin = close-buffers-nvim;
    #   config = readFile ./close-buffer.lua;
    #   modules = [ "close_buffers" ];
    #   commands = [ "BDelete" "BDelete!" ];
    # }
    {
      plugin = nvim-tree-lua;
      depends = [ nvim-web-devicons circles-nvim ];
      config = readFile ./nvim-tree.lua;
      commands = [ "NvimTreeToggle" ];
    }
    {
      plugin = obsidian-nvim;
      depends = [ plenary-nvim ];
      config = readFile ./obsidian.lua + ''
        vim.cmd([[silent source ${obsidian-nvim}/after/syntax/markdown.vim]])
      '';
      commands = [
        "ObsidianBacklinks"
        "ObsidianToday"
        "ObsidianYesterday"
        "ObsidianOpen"
        "ObsidianNew"
        "ObsidianSearch"
        "ObsidianQuickSwitch"
        "ObsidianLink"
        "ObsidianLinkNew"
        "ObsidianFollowLink"
      ];
    }
  ];
  ui = with pkgs.vimPlugins; [
    # {
    #   plugin = windows-nvim;
    #   depends = [ middleclass animation-nvim ];
    #   config = {
    #     lang = "lua";
    #     code = readFile ./windows.lua;
    #     args = { exclude_ft_path = ./shared/exclude_ft.lua; };
    #   };
    #   events = [ "WinNew" ];
    # }
    {
      plugin = nvim-treesitter-context;
      # depends = [ nvim-treesitter' ];
      dependBundles = [ "treesitter" ];
      config = readFile ./treesitter-context.lua;
      events = [ "CursorMoved" ];
    }
    {
      plugin = nvim-notify;
      config = readFile ./notify.lua;
      lazy = true;
    }
    {
      plugin = winbar-nvim;
      config = {
        lang = "lua";
        code = readFile ./winbar.lua;
        args = { exclude_ft_path = ./shared/exclude_ft.lua; };
      };
      lazy = true;
    }
    {
      plugin = windline-nvim;
      config = readFile ./windline.lua;
      lazy = true;
    }
    # {
    #   plugin = nvim-scrollbar;
    #   depends = [ gitsigns-nvim ];
    #   config = {
    #     lang = "lua";
    #     code = readFile ./scrollbar.lua;
    #     args = {
    #       exclude_ft_path = ./shared/exclude_ft.lua;
    #       exclude_buf_ft_path = ./shared/exclude_buf_ft.lua;
    #     };
    #   };
    #   events = [ "CursorMoved" ];
    # }
    {
      plugin = satellite-nvim;
      depends = [ gitsigns-nvim ];
      config = {
        lang = "lua";
        code = readFile ./satellite.lua;
        args = { exclude_ft_path = ./shared/exclude_ft.lua; };
      };
      events = [ "CursorMoved" ];
    }
    # {
    #   # MEMO:
    #   #   - `UpdateRemotePlugins` required.
    #   #   - withPython3 required.
    #   plugin = wilder-nvim;
    #   depends = [ fzy-lua-native ];
    #   config = readFile ./wilder.lua;
    #   events = [ "CmdlineEnter" ];
    #   extraPackages = with pkgs; [ fd ];
    # }
    {
      plugin = SmoothCursor-nvim;
      config = {
        lang = "lua";
        code = readFile ./smoothcursor.lua;
        args = { exclude_ft_path = ./shared/exclude_ft.lua; };
      };
      events = [ "CursorMoved" ];
    }
    # {
    #   plugin = minimap-vim;
    #   preConfig = {
    #     lang = "lua";
    #     code = readFile ./minimap-pre.lua;
    #   };
    #   config = readFile ./minimap.lua;
    #   commands = [ "MinimapToggle" ];
    #   extraPackages = [ pkgs.code-minimap ];
    # }
    {
      plugin = colorful-winsep-nvim;
      events = [ "WinNew" ];
      config = readFile ./winsep.lua;
    }
    {
      plugin = scope-nvim;
      config = readFile ./scope.lua;
    }
    {
      plugin = bufferline-nvim;
      depends = [ scope-nvim ];
      config = readFile ./bufferline.lua;
      lazy = true;
    }
  ];
  lang = with pkgs.vimPlugins; [
    {
      plugin = vim-nix;
      filetypes = [ "nix" ];
    }
    {
      plugin = vim-markdown;
      preConfig = readFile ./vim-markdown-pre.lua;
      filetypes = [ "markdown" ];
    }
    # {
    #   plugin = neofsharp-vim;
    #   filetypes = [ "fs" "fsx" "fsi" "fsproj" ];
    # }
  ];
  git = with pkgs.vimPlugins; [
    {
      plugin = git-conflict-nvim;
      config = readFile ./git-conflict.lua;
      lazy = true;
    }
    {
      plugin = gitsigns-nvim;
      depends = [ plenary-nvim ];
      config = readFile ./gitsign.lua;
      events = [ "CursorMoved" ];
    }
    {
      plugin = gin-vim;
      config = readFile ./gin.lua;
      depends = [ denops-vim ];
      # TODO: support denops lazy load
      # commands = [ "Gin" "GinBuffer" "GinLog" "GinStatus" "GinDiff" ];
      lazy = true;
    }
    {
      plugin = neogit;
      depends = [ diffview-nvim plenary-nvim ];
      config = readFile ./neogit.lua;
      commands = [ "Neogit" ];
    }
    {
      plugin = diffview-nvim;
      depends = [ plenary-nvim ];
      commands = [ "DiffviewOpen" "DiffviewToggleFiles" ];
    }
  ];
  code = with pkgs.vimPlugins; [
    {
      plugin = treesj;
      config = readFile ./treesj.lua;
      modules = [ "treesj" ];
    }
    {
      plugin = neogen;
      # depends = [ nvim-treesitter' ];
      dependBundles = [ "treesitter" ];
      config = readFile ./neogen.lua;
      commands = [ "Neogen" ];
    }
    # {
    #   plugin = coman-nvim;
    #   depends = [ nvim-treesitter' ];
    #   config = readFile ./coman.lua;
    #   commands = [ "ComComment" "ComAnnotation" ];
    # }
    {
      plugin = glance-nvim;
      config = readFile ./glance.lua;
      commands = [ "Glance" ];
    }
    {
      plugin = goto-preview;
      config = readFile ./goto-preview.lua;
      modules = [ "goto-preview" ];
    }
    {
      plugin = legendary-nvim;
      dependBundles = [ "telescope" ];
      config = readFile ./legendary.lua;
      commands = [ "Legendary" ];
    }
    {
      # ys, ds, cs, ...
      plugin = nvim-surround;
      config = readFile ./surround.lua;
      events = [ "InsertEnter" ];
    }
    {
      plugin = nvim-ts-autotag;
      # depends = [ nvim-treesitter' ];
      dependBundles = [ "treesitter" ];
      config = readFile ./ts-autotag.lua;
      filetypes = [ "javascript" "typescript" "jsx" "tsx" "vue" "html" ];
    }
    {
      plugin = todo-comments-nvim;
      depends = [ plenary-nvim trouble-nvim ];
      config = readFile ./todo-comments.lua;
      commands = [ "TodoQuickFix" "TodoLocList" "TodoTrouble" "TodoTelescope" ];
      extraPackages = [ pkgs.ripgrep ];
      lazy = true;
    }
    {
      plugin = trouble-nvim;
      config = readFile ./trouble.lua;
      modules = [ "trouble" ];
      commands = [ "TroubleToggle" ];
    }
    {
      plugin = spaceless-nvim;
      config = readFile ./spaceless.lua;
      lazy = true;
    }
    {
      plugin = nvim_context_vt;
      # depends = [ nvim-treesitter' ];
      dependBundles = [ "treesitter" ];
      config = readFile ./context-vt.lua;
      lazy = true;
    }
    # {
    #   plugin = nvim-treesitter';
    #   config = let
    #     nvim-plugintree = (pkgs.vimPlugins.nvim-treesitter.withPlugins
    #       (p: [ p.c p.lua p.nix p.bash p.cpp p.json p.python p.markdown ]));
    #     treesitter-parsers = pkgs.symlinkJoin {
    #       name = "treesitter-parsers";
    #       paths = nvim-plugintree.dependencies;
    #     };
    #   in ''
    #     vim.opt.runtimepath:append("${treesitter-parsers}");
    #   '' + readFile ./treesitter.lua;
    #   extraPackages = [ pkgs.tree-sitter ];
    # }
    {
      plugin = nvim-lint;
      config = {
        lang = "lua";
        code = readFile ./lint.lua;
        args = {
          checkstyle_config_file_path = ./../../../configs/google_checks.xml;
        };
      };
      extraPackages = with pkgs; [
        checkstyle
        luajitPackages.luacheck
        python310Packages.flake8
        statix
      ];

      lazy = true;
    }
    {
      # Java
      plugin = nvim-jdtls;
      depends = [ ];
      dependBundles = [ "lsp" ];
      config = let jdtLsp = pkgs.pkgs-unstable.jdt-language-server;
      in {
        lang = "lua";
        code = readFile ./jdtls.lua;
        args = {
          runtimes = [
            {
              name = "JavaSE-11";
              path = pkgs.jdk11;
            }
            {
              name = "JavaSE-17";
              path = pkgs.jdk17;
              default = true;
            }
          ];
          on_attach_path = ./shared/on_attach.lua;
          capabilities_path = ./shared/capabilities.lua;
          java_bin = "${pkgs.jdk17}/bin/java";
          jdtls_config = "${jdtLsp}/share/config";
          lombok_jar = "${pkgs.lombok}/share/java/lombok.jar";
          jdtls_jar_pattern =
            "${jdtLsp}/share/java/plugins/org.eclipse.equinox.launcher_*.jar";
          jdtls_settings_path = ./jdtls_settings.lua;
          java_debug_jar_pattern =
            "${pkgs.vscode-extensions.vscjava.vscode-java-debug}/share/vscode/extensions/vscjava.vscode-java-debug/server/com.microsoft.java.debug.plugin-*.jar";
          java_test_jar_pattern =
            "${pkgs.vscode-extensions.vscjava.vscode-java-test}/share/vscode/extensions/vscjava.vscode-java-test/server/*.jar";
          jol_jar = pkgs.javaPackages.jol;

        };
      };
      filetypes = [ "java" ];
    }
    {
      # typescript (node)
      plugin = typescript-nvim;
      dependBundles = [ "lsp" ];
      config = {
        lang = "lua";
        code = readFile ./typescript.lua;
        args = {
          on_attach_path = ./shared/on_attach.lua;
          capabilities_path = ./shared/capabilities.lua;
          tsserver_cmd = [
            "${pkgs.nodePackages.typescript-language-server}/bin/typescript-language-server"
            "--stdio"
          ];
          tsserver_path =
            "${pkgs.nodePackages.typescript}/lib/node_modules/typescript/lib/";
        };
      };
      filetypes = [ "typescript" ];
    }
    {
      # Rust
      plugin = rust-tools-nvim;
      depends = [ plenary-nvim nvim-dap ];
      dependBundles = [ "lsp" ];
      config = {
        lang = "lua";
        code = readFile ./rust-tools.lua;
        args = {
          on_attach_path = ./shared/on_attach.lua;
          capabilities_path = ./shared/capabilities.lua;
        };
      };
      filetypes = [ "rust" ];
    }
    {
      # Haskell
      plugin = haskell-tools-nvim;
      depends = [ plenary-nvim ];
      dependBundles = [ "lsp" ];
      extraPackages = with pkgs; [
        haskellPackages.fourmolu
        haskell-language-server
      ];
      config = {
        lang = "lua";
        code = readFile ./haskell-tools.lua;
        args = {
          on_attach_path = ./shared/on_attach.lua;
          capabilities_path = ./shared/capabilities.lua;
        };
      };
      filetypes = [ "haskell" ];
    }
    {
      # Flutter
      plugin = flutter-tools-nvim;
      depends = [ plenary-nvim ];
      dependBundles = [ "lsp" ];
      config = readFile ./flutter-tools.lua;
      filetypes = [ "dart" ];
    }
    {
      # FSharp
      # [WIP] dotnet
      # dotnet tool install -g fsautocomplete
      # dotnet tool install -g dotnet-fsharplint
      # dotnet tool install --global fantomas-tool
      plugin = Ionide-vim;
      dependBundles = [ "lsp" ];
      preConfig = {
        lang = "vim";
        code = ''
          let g:fsharp#lsp_auto_setup = 0
          let g:fsharp#fsautocomplete_command =[ 'fsautocomplete' ]
        '';
      };
      config = {
        lang = "lua";
        code = readFile ./ionide.lua;
        args = {
          on_attach_path = ./shared/on_attach.lua;
          capabilities_path = ./shared/capabilities.lua;
        };
      };
      filetypes = [ "fsharp" ];
    }
    {
      plugin = formatter-nvim;
      config = readFile ./formatter.lua;
      commands = [ "Format" ];
      extraPackages = with pkgs; [
        html-tidy
        stylua
        google-java-format
        nixfmt
        rustfmt
        taplo
        shfmt
        nodePackages.prettier
        nodePackages.fixjson
        yapf
      ];
    }
    {
      plugin = Comment-nvim;
      config = readFile ./comment.lua;
      events = [ "InsertEnter" "CursorMoved" ];
    }
    {
      plugin = denops-vim;
      extraPackages = with pkgs; [ deno ];
    }
  ];
  custom = with pkgs.vimPlugins; [
    {
      plugin = better-escape-nvim;
      config = readFile ./better-escape.lua;
      events = [ "InsertEnter" ];
    }
    {
      plugin = nvim-dd;
      config = readFile ./nvim-dd.lua;
      events = [ "InsertEnter" ];
    }
    {
      plugin = waitevent-nvim;
      config = readFile ./waitevent.lua;
      lazy = true;
    }
    {
      plugin = safe-close-window-nvim;
      config = readFile ./safe-close-window.lua;
      commands = [ "SafeCloseWindow" ];
    }
    {
      plugin = modicator-nvim;
      config = readFile ./modicator.lua;
    }
    {
      plugin = nvim-spider;
      config = readFile ./spider.lua;
      modules = [ "spider" ];
    }
    {
      plugin = noice-nvim;
      depends = [ nui-nvim nvim-notify ];
      dependBundles = [ "treesitter" ];
      config = {
        lang = "lua";
        code = readFile ./noice.lua;
        args = { exclude_ft_path = ./shared/exclude_ft.lua; };
      };
      lazy = true;

    }
    {
      plugin = nvim-fundo;
      depends = [ promise-async ];
      config = readFile ./fundo.lua;
      lazy = true;
      # run
      # require('fundo').install()
    }
    {
      plugin = nvim-early-retirement;
      config = {
        lang = "lua";
        code = readFile ./nvim-early-retirement.lua;
      };
      lazy = true;
    }
    {
      plugin = open-nvim;
      config = readFile ./open.lua;
      modules = [ "open" ];
    }
    {
      plugin = qf-nvim;
      config = readFile ./qf.lua;
      filetypes = [ "qf" ];
      events = [ "QuickFixCmdPre" ];
      lazy = true;
    }
    {
      plugin = toolwindow-nvim;
      modules = [ "toolwindow" ];
    }
    {
      plugin = vimdoc-ja;
      config = "vim.cmd[[set helplang=ja,en]]";
      lazy = true;
    }
    {
      plugin = which-key-nvim;
      config = readFile ./whichkey.lua;
      lazy = true;
    }
    {
      plugin = nvim-bqf;
      config = readFile ./bqf.lua;
      events = [ "QuickFixCmdPre" ];
      lazy = true;
    }
    {
      plugin = nvim-hlslens;
      config = readFile ./hlslens.lua;
      events = [ "CmdlineEnter" ];
    }
    {
      plugin = vim-asterisk;
      config = {
        lang = "vim";
        code = readFile ./asterisk.vim;
      };
      events = [ "CmdlineEnter" ];
    }

    {
      plugin = mkdir-nvim;
      events = [ "CmdlineEnter" ];
    }
    {
      plugin = indent-o-matic;
      config = readFile ./indent-o-matic.lua;
      events = [ "CursorMoved" ];
    }
    {
      plugin = numb-nvim;
      config = readFile ./numb.lua;
      events = [ "CmdlineEnter" ];
    }
    {
      plugin = indent-blankline-nvim;
      # depends = [ nvim-treesitter' ];
      dependBundles = [ "treesitter" ];
      config = {
        lang = "lua";
        code = readFile ./indent-blankline.lua;
        args = { exclude_ft_path = ./shared/exclude_ft.lua; };
      };
    }
    {
      plugin = nvim-ufo;
      depends = [ promise-async statuscol-nvim indent-blankline-nvim ];
      dependBundles = [ "treesitter" ];
      config = readFile ./ufo.lua;
      events = [ "BufRead" ];
    }
    {
      plugin = statuscol-nvim;
      config = readFile ./statuscol.lua;
    }
  ];
  bundles =
    #let
    #  # nvim-treesitter' = pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [p.nix]);
    #  nvim-treesitter' = pkgs.vimPlugins.nvim-treesitter.withAllGrammars;
    # vim.opt.runtimepath:append("${
    # pkgs.symlinkJoin {
    #   name = "treesitter-parsers";
    #   paths = nvim-treesitter'.dependencies;
    # }
    # }")
    #in
    with pkgs.vimPlugins; [

      {
        name = "treesitter";
        plugins = [
          nvim-treesitter
          nvim-yati
          nvim-ts-rainbow2
          vim-matchup
          nvim-treesitter-textobjects
        ];

        # {
        #   plugin = nvim-treesitter-textobjects;
        #   # depends = [ nvim-treesitter' ];
        #   dependBundles = [ "treesitter"];
        #   config = readFile ./treesitter-textobjects.lua;
        #   lazy = true;
        # }
        # {
        #   plugin = vim-matchup;
        #   dependBundles = [ "treesitter"];
        #   config = readFile ./matchup.lua;
        #   events = [ "CursorMoved" ];
        # }
        # {
        #   plugin = nvim-yati;
        #   # depends = [ nvim-treesitter' ];
        #   dependBundles = [ "treesitter"];
        #   config = readFile ./yati.lua;
        #   events = [ "InsertEnter" ];
        # }
        # {
        #   plugin = nvim-treesitter-refactor;
        #   depends = [ nvim-treesitter ];
        #   config = readFile ./treesitter-refactor.lua;
        #   lazy = true;
        # }
        # {
        #   plugin = nvim-ts-rainbow2;
        #   # depends = [ nvim-treesitter' ];
        #   dependBundles = [ "treesitter"];
        #   config = readFile ./ts-rainbow2.lua;
        #   lazy = true;
        # }
        config = readFile ./treesitter.lua;
        extraPackages = [ pkgs.tree-sitter ];
        lazy = true;
      }
      {
        name = "skk";
        plugins = [
          skkeleton
          {
            plugin = skkeleton_indicator-nvim;
            config = readFile ./skk-indicator.lua;
          }
        ];
        depends = [ denops-vim ];
        config = {
          lang = "vim";
          code = readFile ./skk.vim;
          args = { jisyo_path = "${pkgs.skk-dicts}/share/SKK-JISYO.L"; };
        };
        lazy = true;
      }
      {
        name = "telescope";
        plugins = [
          telescope-nvim
          telescope-ui-select-nvim
          {
            plugin = telescope-live-grep-args-nvim;
            extraPackages = with pkgs; [ ripgrep ];
          }
          {
            plugin = telescope-sonictemplate-nvim;
            depends = [{
              plugin = vim-sonictemplate.overrideAttrs (old: {
                src = nix-filter {
                  root = vim-sonictemplate.src;
                  exclude = [ "template/java" "template/make" ];
                };
              });
              preConfig = let
                templates = stdenv.mkDerivation {
                  name = "sonic-custom-templates";
                  src = ./sonic-template;
                  installPhase = ''
                    mkdir $out
                    cp -r ./* $out
                  '';
                };
              in ''
                vim.g.sonictemplate_vim_template_dir = "${templates}"
                vim.g.sonictemplate_key = 0
                vim.g.sonictemplate_intelligent_key = 0
                vim.g.sonictemplate_postfix_key = 0
              '';
            }];
          }
          {
            plugin = project-nvim;
            config = readFile ./project.lua;
          }
        ];
        depends = [ plenary-nvim ];
        config = readFile ./telescope.lua;
        commands = [ "Telescope" ];
      }
      {
        name = "lsp";
        plugins = [
          {
            plugin = nvim-lspconfig;
            # [WIP] dotnet
            # dotnet tool install --global csharp-ls
            extraPackages = (with pkgs; [
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
              taplo-cli
            ]) ++ (with pkgs.pkgs-unstable; [ lua-language-server ]);
            config = {
              lang = "lua";
              code = readFile ./lspconfig.lua;
              args = {
                on_attach_path = ./shared/on_attach.lua;
                capabilities_path = ./shared/capabilities.lua;
                eslint_cmd = [
                  "${pkgs.nodePackages.vscode-langservers-extracted}/bin/vscode-eslint-language-server"
                  "--stdio"
                ];
              };
            };
            lazy = true;
          }
          {
            plugin = actions-preview-nvim;
            config = readFile ./actions-preview.lua;
            dependBundles = [ "telescope" ];
            modules = [ "actions-preview" ];
          }
          {
            plugin = lsp-inlayhints-nvim;
            config = readFile ./inlayhints.lua;
          }
          {
            plugin = vim-illuminate;
            config = readFile ./illuminate.lua;
          }
          {
            plugin = hover-nvim;
            config = readFile ./hover.lua;
          }
          # {
          #   plugin = pretty_hover;
          #   config = readFile ./pretty-hover.lua;
          # }
          # noice-nvim
        ];
        depends = [{
          plugin = fidget-nvim;
          config = readFile ./fidget.lua;
        }];
        lazy = true;
      }
      {
        name = "dap";
        plugins = [
          nvim-dap
          nvim-dap-go
          nvim-dap-ui
          nvim-dap-virtual-text
          # nvim-treesitter'
        ];
        dependBundles = [ "treesitter" ];
        config = readFile ./dap.lua;
        modules = [ "dap" "dapui" ];
        extraPackages = with pkgs; [ delve ];
        filetypes = [ "go" "java" ];
      }
      {
        name = "ddc";
        plugins = [
          ddc-vim
          {
            plugin = ddc-ui-pum;
            depends = [{
              plugin = pum-vim;
              depends = [{
                plugin = nvim-autopairs;
                # depends = [ nvim-treesitter' ];
                dependBundles = [ "treesitter" ];
                config = readFile ./autopairs.lua;
                events = [ "InsertEnter" ];
                modules = [ "nvim-autopairs" ];
              }

                ];
              config = {
                lang = "vim";
                code = readFile ./pum.vim;
              };
            }];
          }
          ddc-buffer
          ddc-converter_remove_overlap
          ddc-converter_truncate
          ddc-fuzzy
          ddc-matcher_head
          ddc-matcher_length
          ddc-sorter_itemsize
          ddc-sorter_rank
          ddc-source-around
          ddc-source-cmdline
          ddc-source-cmdline-history
          ddc-source-file
          ddc-source-input
          ddc-source-line
          ddc-source-nvim-lsp
          ddc-tmux
          ddc-ui-native
          denops-popup-preview-vim
          denops-signature_help
          neco-vim
          # TODO lazy
          {
            plugin = ddc-source-nvim-obsidian;
            depends = [ obsidian-nvim ];
          }
        ];
        depends = [
          denops-vim
          {
            plugin = vim-vsnip-integ;
            depends = [ vim-vsnip ];
          }
        ];
        dependBundles = [ "lsp" ];
        config = {
          lang = "vim";
          code = readFile ./ddc.vim;
        };
        lazy = true;
      }
      # {
      #   name = "ddu";
      #   plugins = [
      #     ddu-vim
      #     ddu-ui-ff
      #     ddu-source-file
      #     ddu-source-file_rec
      #     ddu-source-buffer
      #     {
      #       plugin = ddu-source-file_external;
      #       extraPackages = [ pkgs.fd ];
      #     }
      #     {
      #       plugin = ddu-source-rg;
      #       depends = [ kensaku-vim ];
      #       extraPackages = [ pkgs.ripgrep ];
      #     }
      #     ddu-filter-converter_display_word
      #     ddu-filter-matcher_substring
      #     ddu-filter-fzf
      #     ddu-kind-file
      #   ];
      #   depends = [ denops-vim ];
      #   config = {
      #     lang = "vim";
      #     code = readFile ./ddu.vim;
      #   };
      #   # WIP
      #   lazy = true;
      #   commands = [ ];
      # }
    ];
in {
  programs.oboro-nvim = {
    enable = true;
    extraConfig = ''
      vim.cmd([[
        ${readFile ./disable-default-plugin.vim}
        ${readFile ./prelude.vim}
        ${readFile ./keymap.vim}
      ]])
      vim.loader.enable()
      ${readFile ./prelude.lua}
      ${readFile ./keymap.lua}
    '';
    extraPackages = with pkgs; [ delta ];
    optPlugins = motion ++ tool ++ git ++ lang ++ code ++ ui ++ custom;
    # optPlugins = motion; # ++ tool ++ git ++ lang ++ code ++ ui ++ custom;
    #    optPlugins =
    #	with pkgs.vimPlugins; [
    #    {
    #      plugin = nvim-treesitter';
    #      config = let
    #        nvim-plugintree = (pkgs.vimPlugins.nvim-treesitter.withPlugins
    #          (p: [ p.c p.lua p.nix p.bash p.cpp p.json p.python p.markdown ]));
    #        treesitter-parsers = pkgs.symlinkJoin {
    #          name = "treesitter-parsers";
    #          paths = nvim-plugintree.dependencies;
    #        };
    #      in ''
    #        vim.opt.runtimepath:append("${treesitter-parsers}");
    #      '' + readFile ./treesitter.lua;
    #      extraPackages = [ pkgs.tree-sitter ];
    #    }];

    # bundles =
    #     let
    #       nvim-treesitter' = pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [
    #         p.nix
    #     ]);
    #     in
    # with pkgs.vimPlugins; [
    # 	];
    inherit startPlugins bundles;
  };
}
