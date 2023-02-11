{ config, pkgs, lib, nix-filter, ... }:

let
  inherit (builtins) readFile;
  inherit (lib.strings) fileContents;
  inherit (pkgs) callPackage;
  myPlugins = callPackage ./my-plugins.nix { };
  external = callPackage ./external.nix { };

  extraPackages = with pkgs; [ ];

  editorconfigTemplate = pkgs.writeText "editorconfig" ''
    root = true

    [*]
    indent_style = space
    indent_size = 2
    # indent_style = tab
    # tab_width = 2
    end_of_line = lf
    insert_final_newline = true
    charset = utf-8
  '';

  extraConfig = ''
    ${fileContents ./vim/nvim.vim}
    ${fileContents ./vim/util.vim}
  '';
  extraConfigLua = ''
    dofile("${./lua/neovim.lua}")({
      editor_config = "${editorconfigTemplate}",
    })
  '';

  startup = with pkgs.vimPlugins; [
    {
      plugin = impatient-nvim;
      config = ''
        require('impatient')
        require'impatient'.enable_profile()
      '';
      optional = false;
      enable = false;
    }
    {
      plugin = vim-sensible;
      optional = false;
      comment = "必須設定群";
    }
    {
      plugin = nvim-config-local;
      config = readFile ./lua/nvim-config-local.lua;
      optional = false;
    }
    {
      plugin = alpha-nvim;
      config = readFile ./lua/alpha-nvim_config.lua;
      optional = false;
      enable = false;
      comment = "splashscreen";
    }
    {
      plugin = editorconfig-nvim;
      optional = false;
    }
    {
      plugin = which-key-nvim;
      config = readFile ./lua/which-key-nvim_config.lua;
      optional = false;
      comment = "whichkey";
    }
    {
      plugin = onedarkpro-nvim;
      config = ''
        vim.cmd("colorscheme onedark")
      '';
      optional = false;
      delay = true;
      enable = false;
    }
    {
      plugin = nightfox-nvim;
      startup = "vim.cmd([[colorscheme nightfox]])";
      enable = false;
    }
    {
      plugin = vim-poslist;
      optional = false;
      enable = false;
      config = ''
        vim.cmd[[
          nmap <Leader>gh <Plug>(poslist-prev-buf)
          nmap <Leader>gl <Plug>(poslist-next-buf)
        ]]
      '';
    }
  ];

  input = with pkgs.vimPlugins; [
    {
      plugin = leap-nvim;
      config = readFile ./lua/leap.lua;
      events = [ "InsertEnter" ];
    }
    {
      plugin = flit-nvim;
      config = readFile ./lua/flit.lua;
      depends = [ leap-nvim ];
      events = [ "InsertEnter" ];
    }
    {
      plugin = tabout-nvim;
      config = readFile ./lua/tabout.lua;
      depends = [ nvim-treesitter ];
      events = [ "CursorMoved" ];
    }
    {
      plugin = skkeleton;
      depends = [ denops-vim ddc-vim skkeleton_indicator-nvim ];
      config = ''
        vim.cmd([[
          call skkeleton#config({
            \ 'globalJisyo': '${pkgs.skk-dicts}/share/SKK-JISYO.L',
            \ 'globalJisyoEncoding': 'utf-8',
            \ 'useSkkServer': v:true,
            \ 'skkServerHost': '127.0.0.1',
            \ 'skkServerPort': 1178,
            \ 'skkServerReqEnc': 'euc-jp',
            \ 'skkServerResEnc': 'euc-jp',
            \ 'markerHenkan': '',
            \ 'markerHenkanSelect': '',
            \ })
        ]])
      '' + readFile ./lua/skkeleton_config.lua
        + readFile ./lua/skkeleton_indicator_config.lua;
      delay = true;
    }
    {
      plugin = dps-dial-vim;
      depends = [ denops-vim ];
      config = readFile ./lua/dps-dial-vim.lua;
      delay = true;
    }
    {
      plugin = nvim-surround;
      config = readFile ./lua/nvim-surround.lua;
      delay = true;
      comment = "brackets, braces";
    }
    {
      plugin = Comment-nvim;
      config = readFile ./lua/Comment-nvim.lua;
      delay = true;
    }
  ];

  custom = with pkgs.vimPlugins; [
    {
      plugin = noice-nvim;
      config = ''
        dofile("${./lua/noice.lua}")({
          exclude_ft = dofile("${./exclude_ft.lua}"),
        })
      '';
      depends = [ nui-nvim nvim-notify ];
      delay = true;
    }
    {
      plugin = open-nvim;
      config = readFile ./lua/open.lua;
      modules = [ "open" ];
    }
    # {
    #   plugin = fine-cmdline-nvim;
    #   depends = [ nui-nvim ];
    #   startup = ''
    #     vim.api.nvim_set_keymap('n', ':', '<cmd>FineCmdline<CR>', { noremap = true, silent = true })
    #   '';
    #   config = readFile ./lua/fine-cmdline-nvim.lua;
    #   commands = [ "FineCmdline" ];
    # }
    # {
    #   plugin = searchbox-nvim;
    #   depends = [ nui-nvim ];
    #   commands = [ "SearchBoxIncSearch" ];
    # }
    {
      plugin = vim-matchup;
      delay = true;
    }
    {
      plugin = persisted-nvim;
      depends = [ telescope-nvim ];
      config = readFile ./lua/persisted-nvim.lua;
      delay = true;
    }
    {
      plugin = vim-asterisk;
      config = ''
        vim.cmd[[
          ${readFile ./vim/asterisk.vim}
        ]]
      '';
      events = [ "CmdlineEnter" ];
    }
    {
      plugin = colorful-winsep-nvim;
      events = [ "WinNew" ];
      config = readFile ./lua/colorful-winsep-nvim.lua;
    }
    {
      plugin = stickybuf-nvim;
      config = ''
        require('stickybuf').setup()
      '';
      commands = [ "Stickybuf" ];
      modules = [ "stickybuf" ];
    }
    {
      plugin = confirm-quit-nvim;
      delay = true;
    }
    {
      plugin = zoomwintab-vim;
      commands = [ "ZoomWinTabToggle" ];
      enable = false;
    }
    # {
    #   plugin = pretty-fold-nvim;
    #   # depends = [ fold-preview-nvim ];
    #   startup = ''
    #     -- default
    #     vim.opt.foldmethod = 'indent'
    #     vim.opt.foldlevel = 20
    #   '';
    #   config = readFile ./lua/pretty-fold-nvim.lua;
    #   delay = true;
    #   comment = "折り畳み強化";
    #   enable = false;
    # }
    {
      plugin = statuscol-nvim;
      config = readFile ./lua/statuscol.lua;
    }
    {
      plugin = nvim-ufo;
      depends = [ nvim-treesitter promise-async statuscol-nvim ];
      config = readFile ./lua/nvim-ufo.lua;
      delay = true;
    }
    {
      plugin = nvim-bqf;
      fileTypes = [ "qf" ];
      events = [ "QuickFixCmdPre" ];
      delay = true;
      comment = "QuickFix強化";
    }
    {
      plugin = nvim-hlslens;
      events = [ "CmdlineEnter" ];
      comment = "hl強化";
      config = readFile ./lua/nvim-hlslens.lua;
    }
  ];

  statusline = with pkgs.vimPlugins; [
    {
      plugin = lualine-nvim;
      config = readFile ./lua/lualine_config.lua;
      delay = true;
      enable = false;
    }
    {
      plugin = windline-nvim;
      delay = true;
      config = ''
        require('wlsample.vscode')
      '';
    }
  ];

  commandline = with pkgs.vimPlugins; [
    {
      plugin = wilder-nvim;
      depends = [ fzy-lua-native ];
      events = [ "CmdlineEnter" ];
      config = readFile ./lua/wilder-nvim_config.lua;
      extraPackages = with pkgs; [ fd ];
    }
    {
      plugin = mkdir-nvim;
      events = [ "CmdlineEnter" ];
    }
  ];

  language = with pkgs.vimPlugins; [
    {
      plugin = vim-nix;
      fileTypes = [ "nix" ];
    }
    {
      plugin = neofsharp-vim;
      enable = false;
      fileTypes = [ "fs" "fsx" "fsi" "fsproj" ];
    }
  ];

  view = with pkgs.vimPlugins; [
    {
      plugin = winbar-nvim;
      config = ''
        dofile("${./lua/winbar.lua}")({
          exclude_ft = dofile("${./exclude_ft.lua}"),
        })
      '';
      delay = true;
    }
    {
      plugin = themer-lua;
      config = readFile ./lua/themer.lua;
    }
    {
      plugin = lsp-colors-nvim;
      config = ''
        require("lsp-colors").setup({})
      '';
      delay = true;
    }
    {
      plugin = catppuccin-nvim;
      config = readFile ./lua/catppuccin.lua;
      modules = [ "catppuccin" "catppuccin.groups.integrations.bufferline" ];
      enable = false;
    }
    {
      plugin = nvim-scrollview;
      config = readFile ./lua/nvim-scrollview.lua;
      delay = true;
    }
    {
      plugin = nvim-scrollbar;
      config = readFile ./lua/nvim-scrollbar.lua;
      depends = [ gitsigns-nvim ];
      enable = false;
      delay = true;
    }
    {
      plugin = nvim-notify;
      config = readFile ./lua/nvim-notify.lua;
      delay = true;
    }
    {
      plugin = nvim-web-devicons;
      config = ''
        require'nvim-web-devicons'.setup {
         default = true;
        }
      '';
    }
    {
      plugin = sidebar-nvim;
      config = readFile ./lua/sidebar-nvim.lua;
      commands = [ "SidebarNvimToggle" "SidebarNvimOpen" ];
    }
    {
      plugin = aerial-nvim;
      config = readFile ./lua/aerial-nvim.lua;
      commands = [ "ToggleOutline" ];
    }
    {
      plugin = symbols-outline-nvim;
      config = readFile ./lua/symbols-outline-nvim.lua;
      commands = [ "SymbolsOutline" ];
    }
    {
      plugin = incline-nvim;
      config = readFile ./lua/incline_config.lua;
      delay = true;
      comment = "ペインにファイル名を表示";
      enable = false;
    }
    {
      plugin = nvim-transparent;
      config = ''
        require("transparent").setup({
          enable = true,
        })
      '';
      # commands = [ "TransparentEnable" "TransparentDisable" "TransparentToggle" ];
    }
    {
      plugin = serenade;
      config = ''
        vim.cmd([[
          colorscheme serenade
          hi DiagnosticError guifg=#d76e6e
          hi DiagnosticWarn  guifg=#e5a46b
          hi DiagnosticInfo  guifg=#82abbc
          hi DiagnosticHint  guifg=#9aa1a8
          hi NotifyERRORBorder guifg=#d76e6e
          hi NotifyWARNBorder  guifg=#e5a46b
          hi NotifyINFOBorder  guifg=#82abbc
          hi NotifyERRORIcon guifg=#d76e6e
          hi NotifyWARNIcon  guifg=#e5a46b
          hi NotifyINFOIcon  guifg=#82abbc
          hi NotifyERRORTitle  guifg=#d76e6e
          hi NotifyWARNTitle guifg=#e5a46b
          hi NotifyINFOTitle guifg=#82abbc
        ]])
      '';
      depends = [ nvim-transparent ];
      delay = true;
      # optional = false;
    }
    {
      plugin = headlines-nvim;
      config = readFile ./lua/headlines_config.lua;
      fileTypes = [ "markdown" "rmd" "vimwiki" "orgmode" ];
      enable = false;
    }
    {
      plugin = indent-blankline-nvim;
      depends = [ nvim-treesitter ];
      config = readFile ./lua/indent-blankline-nvim_config.lua;
      delay = true;
    }
    {
      plugin = neoscroll-nvim;
      enable = false;
      delay = true;
      config = ''
        require'neoscroll'.setup{
          mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>'},
          easing_function = 'sine',
        }
      '';
    }
    {
      plugin = bufferline-nvim;
      depends = [
        nvim-web-devicons
        {
          plugin = scope-nvim;
          config = ''
            require("scope").setup()
          '';
        }
      ];
      config = readFile ./lua/bufferline_config.lua;
      delay = true;
    }
    {
      plugin = gitsigns-nvim;
      depends = [ plenary-nvim ];
      config = readFile ./lua/gitsigns_config.lua;
      delay = true;
    }
  ];

  lsp = callPackage ./lsp { };
  dap = callPackage ./dap { };
  template = callPackage ./template { };

  code = with pkgs.vimPlugins;

    [
      {
        plugin = nvim-docs-view;
        enable = false;
        config = readFile ./lua/nvim-docs-view.lua;
        commands = [ "DocsViewToggle" ];
      }
      {
        plugin = nvim-treesitter;
        dependsAfter = [ nvim-ts-rainbow nvim-ts-autotag ];
        delay = true;
        config = readFile ./lua/nvim-treesitter_config.lua;
        extraPackages = with pkgs; [ tree-sitter ];
        commands = [ "TSBufEnable" ];
      }
      # {
      #   plugin = range-highlight-nvim;
      #   depends = [ cmd-parser-nvim ];
      #   config = ''
      #     require('range-highlight').setup{}
      #   '';
      #   events = [ "CmdlineEnter" ];
      # }
      {
        plugin = myPlugins.nvim-dd;
        config = ''
          require('dd').setup({
            timeout = 1000
          })
        '';
        delay = true;
        comment = "diagnostics throttle";
      }
      {
        plugin = Shade-nvim;
        config = readFile ./lua/Shade-nvim.lua;
        events = [ "WinNew" ];
        enable = false;
        comment = "フォーカスしていないPaneを暗く";
      }
      {
        plugin = tint-nvim;
        config = ''
          require('tint').setup()
        '';
        events = [ "WinNew" ];
        enable = false;
        comment = "フォーカスしていないPaneを暗く";
      }
      {
        plugin = luasnip;
        depends = [ friendly-snippets ];
        config = readFile ./lua/luasnip_config.lua;
      }
      {
        plugin = vim-vsnip-integ;
        config = ''
          vim.cmd[[
            ${readFile ./vim/vim-vsnip-integ.vim}
          ]]
        '';
        depends = [{
          plugin = vim-vsnip;
          config = ''
            vim.cmd[[
              ${readFile ./vim/vsnip.vim}
            ]]
          '';
        }];
      }
      {
        plugin = ddc-vim;
        depends = [
          {
            plugin = ddc-ui-pum;
            depends = [ pum-vim ];
          }
          ddc-ui-native
          denops-vim
          ddc-source-around
          ddc-source-nvim-lsp
          ddc-source-file
          ddc-matcher_head
          ddc-sorter_rank
          ddc-sorter_itemsize
          ddc-buffer
          ddc-fuzzy
          denops-signature_help
          denops-popup-preview-vim
          ddc-source-cmdline
          ddc-source-cmdline-history
          neco-vim
          ddc-tmux
          ddc-converter_truncate
          ddc-converter_remove_overlap
          ddc-matcher_length
        ];
        config = ''
          vim.cmd[[
            ${readFile ./vim/ddc.vim}
          ]]
        '';
        delay = true;
      }
      # {
      #   plugin = nvim-cmp;
      #   dependsAfter = [
      #     {
      #       plugin = lspkind-nvim;
      #       config = readFile ./lua/lspkind_config.lua;
      #     }
      #     {
      #       plugin = cmp-vsnip;
      #       depends = [ vim-vsnip ];
      #       enable = false;
      #     }
      #     nvim-autopairs
      #     nvim-treesitter
      #     cmp-path
      #     cmp-buffer
      #     cmp-calc
      #     cmp-treesitter
      #     cmp-nvim-lsp
      #     cmp-nvim-lua
      #     {
      #       plugin = cmp_luasnip;
      #       depends = [ luasnip ];
      #     }
      #     cmp-nvim-lsp-signature-help
      #     # cmp-cmdline
      #     # cmp-cmdline-history
      #     # cmp-nvim-lsp-document-symbol
      #   ];
      #   config = ''
      #     vim.cmd[[
      #       silent source ${cmp-path}/after/plugin/cmp_path.lua
      #       silent source ${cmp-buffer}/after/plugin/cmp_buffer.lua
      #       silent source ${cmp-calc}/after/plugin/cmp_calc.lua
      #       silent source ${cmp-treesitter}/after/plugin/cmp_treesitter.lua
      #       silent source ${cmp-nvim-lsp}/after/plugin/cmp_nvim_lsp.lua
      #       silent source ${cmp_luasnip}/after/plugin/cmp_luasnip.lua
      #       silent source ${cmp-nvim-lua}/after/plugin/cmp_nvim_lua.lua
      #       silent source ${cmp-nvim-lsp-signature-help}/after/plugin/cmp_nvim_lsp_signature_help.lua
      #       " silent source ${cmp-cmdline}/after/plugin/cmp_cmdline.lua
      #       " silent source ${cmp-cmdline-history}/after/plugin/cmp_cmdline_history.lua
      #       " silent source ${cmp-nvim-lsp-document-symbol}/after/plugin/cmp_nvim_lsp_document_symbol.lua
      #     ]]

      #   '' + (readFile ./lua/nvim-cmp_config.lua);
      #   delay = true;
      #   enable = false;
      # }
      {
        plugin = nvim-lint;
        config = ''
          local lint = require("lint")
          local local_config = vim.g.checkstyle_config_file
          if local_config ~= nil then
            lint.linters.checkstyle.config_file = local_config
          else
            lint.linters.checkstyle.config_file = '${
              pkgs.writeText "checkstyle.xml"
              (readFile ./../../../configs/google_checks.xml)
            }'
          end
          lint.linters_by_ft = {
            java = { "checkstyle" },
          }
          vim.api.nvim_create_autocmd({ "BufWritePost" }, {
            callback = function()
              require("lint").try_lint()
            end,
          })
        '';
        extraPackages = [ pkgs.checkstyle ];
        fileTypes = [ "java" ];
      }
      {
        plugin = todo-comments-nvim;
        depends = [ plenary-nvim trouble-nvim ];
        commands =
          [ "TodoQuickFix" "TodoLocList" "TodoTrouble" "TodoTelescope" ];
        config = ''
          require'todo-comments'.setup {}
        '';
        delay = true;
      }
      {
        plugin = trouble-nvim;
        depends = [ nvim-web-devicons ];
        commands = [ "TroubleToggle" ];
        config = readFile ./lua/trouble_config.lua;
      }
      {
        plugin = spaceless-nvim;
        config = ''
          require'spaceless'.setup()
        '';
        delay = true;
        enable = false;
      }
      {
        plugin = nvim_context_vt;
        depends = [ nvim-treesitter ];
        delay = true;
        config = readFile ./lua/nvim_context_vt_config.lua;
      }
      {
        plugin = vim-oscyank;
        commands = [ "OSCYank" ];
        startup = ''
          vim.g.oscyank_term = 'default'
        '';
      }
      {
        plugin = dressing-nvim;
        config = readFile ./lua/dressiong-nvim.lua;
      }
      {
        plugin = legendary-nvim;
        depends = [ telescope-nvim ];
        commands = [ "Legendary" ];
        config = readFile ./lua/legendary-nvim.lua;
      }
      {
        plugin = nvim-bufdel;
        commands = [ "BufDel" "BufDel!" ];
        config = ''
          require'bufdel'.setup {
            quit = false,
          }
        '';
      }
      # {
      #   plugin = vim-buffer-history;
      #   commands = [ "BufferHistoryBack" "BufferHistoryForward" ];
      #   delay = true;
      # }
      {
        plugin = cybu-nvim;
        depends = [ nvim-web-devicons plenary-nvim ];
        config = ''
          dofile("${./lua/cybu.lua}")({
            exclude_ft = dofile("${./exclude_ft.lua}"),
          })
        '';
        modules = [ "cybu" ];
      }
      {
        plugin = nvim-colorizer-lua;
        config = readFile ./lua/nvim-colorizer.lua;
        commands = [ "ColorizerToggle" ];
      }
      {
        plugin = registers-nvim;
        config = readFile ./lua/registers_config.lua;
        delay = true;
      }
      {
        plugin = lexima-vim;
        config = ''
          vim.cmd[[
            ${readFile ./vim/lexima.vim}
          ]]
        '';
        # delay = true;
      }
    ];
  movement = with pkgs.vimPlugins; [
    {
      plugin = telescope-nvim;
      depends = [
        plenary-nvim
        telescope-file-browser-nvim
        telescope-ui-select-nvim
        telescope-undo-nvim
        {
          plugin = telescope-live-grep-args-nvim;
          extraPackages = [ pkgs.ripgrep ];
        }
        {
          plugin = project-nvim;
          config = readFile ./lua/project-nvim.lua;
        }
        {
          plugin = telescope-sonictemplate-nvim;
          depends = [ vim-sonictemplate ];
          startup = ''
            vim.g.sonictemplate_key = 0
            vim.g.sonictemplate_intelligent_key = 0
            vim.g.sonictemplate_postfix_key = 0
          '';
        }
      ];
      config = readFile ./lua/telescope-nvim_config.lua;
      commands = [ "Telescope" ];
      # modules = [ "telescope" ];
      extraPackages = with pkgs.pkgs-stable; [ ripgrep ];
    }
    {
      plugin = hop-nvim;
      commands = [ "HopChar1" "HopChar2" "HopLineAC" "HopLineBC" ];
      config = ''
        require'hop'.setup()
      '';
    }
    # {
    #   plugin = quick-scope;
    #   startup = ''
    #     vim.g.qs_highlight_on_keys = {'f', 'F', 't', 'T'}
    #   '';
    #   events = [ "CursorMoved" ];
    # }
    # {
    #   plugin = flare-nvim;
    #   config = readFile ./lua/flare_config.lua;
    #   events = [ "InsertEnter" ];
    # }
    {
      plugin = SmoothCursor-nvim;
      config = ''
        dofile("${./lua/SmoothCursor.lua}")({
          exclude_ft = dofile("${./exclude_ft.lua}"),
        })
      '';
      #config = readFile ./lua/SmoothCursor.lua;
      events = [ "CursorMoved" ];
    }
    {
      plugin = chowcho-nvim;
      depends = [ nvim-web-devicons ];
      commands = [ "Chowcho" ];
      config = readFile ./lua/chowcho-nvim.lua;
    }
    {
      plugin = vim-migemo;
      config = ''
        vim.g.migemodict = '${external.migemo-dict}/migemo-dict'
      '';
      extraPackages = [ pkgs.cmigemo ];
      enable = false;
    }
    {
      plugin = migemo-search;
      extraPackages = [ pkgs.cmigemo ];
      config = ''
        vim.g.migemosearch_migemodict = '${external.migemo-dict}/migemo-dict}'
      '';
      enable = false;
    }
    {
      plugin = goto-preview;
      config = readFile ./lua/goto-preview-nvim_config.lua;
      modules = [ "goto-preview" ];
    }
  ];

  tool = with pkgs.vimPlugins; [
    {
      plugin = obsidian-nvim;
      config = readFile ./lua/obsidian.lua;
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
    {
      plugin = nomodoro;
      config = readFile ./lua/nomodoro.lua;
      commands = [ "NomoWork" ];
    }
    {
      plugin = vimdoc-ja;
      config = "vim.cmd[[set helplang=ja,en]]";
      delay = true;
    }
    {
      plugin = winresizer;
      delay = true;
    }
    {
      plugin = tig-explorer-vim;
      depends = [ bclose-vim ];
      commands = [ "TigOpenProjectRootDir" ];
    }
    {
      plugin = toolwindow-nvim;
      modules = [ "toolwindow" ];
    }
    {
      plugin = comfortable-motion-vim;
      config = ''
        vim.g.comfortable_motion_scroll_down_key = "j"
        vim.g.comfortable_motion_scroll_up_key = "k"
      '';
    }
    {
      plugin = vim-translator;
      config = ''
        vim.g.translator_target_lang = 'ja'
      '';
      commands = [ "Translate" ];
    }
    {
      plugin = git-conflict-nvim;
      delay = true;
      config = ''
        require'git-conflict'.setup()
      '';
    }
    {
      plugin = mdeval-nvim;
      config = readFile ./lua/mdeval_config.lua;
      extraPackages = [ pkgs.coreutils-full ];
    }
    {
      plugin = org-bullets-nvim;
      depends = [ nvim-treesitter ];
      config = readFile ./lua/org-bullets_config.lua;
      enable = false;
    }
    {
      plugin = headlines-nvim;
      config = readFile ./lua/headlines_config.lua;
      enable = false;
    }
    {
      plugin = orgmode;
      depends = [ nvim-cmp nvim-treesitter org-bullets-nvim headlines-nvim ];
      startup = ''
        vim.opt.conceallevel = 2
        vim.opt.concealcursor = 'nc'
      '';
      config = readFile ./lua/orgmode_config.lua;
      fileTypes = [ "org" ];
      enable = false;
    }
    {
      plugin = zen-mode-nvim;
      # depends = [ twilight-nvim ];
      config = readFile ./lua/zen-mode_config.lua;
      commands = [ "ZenMode" ];
    }
    # {
    #   plugin = true-zen;
    #   config = readFile ./lua/true-zen.lua;
    #   commands = [ "TZFocus" ];
    # }
    {
      plugin = NeoZoom-lua;
      config = readFile ./lua/NeoZoom.lua;
      commands = [ "NeoZoomToggle" ];
    }
    {
      plugin = twilight-nvim;
      depends = [ nvim-treesitter ];
      config = readFile ./lua/twilight_config.lua;
    }
    {
      plugin = glow-nvim;
      commands = [ "Glow" ];
      startup = ''
        vim.g.glow_border = 'none'
      '';
      extraPackages = [ pkgs.glow ];
    }
    {
      plugin = nvim-spectre;
      depends = [ plenary-nvim nvim-web-devicons ];
      config = readFile ./lua/spectre_config.lua;
      extraPackages = [ pkgs.gnused ];
      modules = [ "spectre" ];
    }
    {
      plugin = neogit;
      config = readFile ./lua/neogit.lua;
      depends = [ diffview-nvim plenary-nvim ];
      commands = [ "Neogit" ];
    }
    {
      plugin = diffview-nvim;
      depends = [{ plugin = plenary-nvim; }];
      commands = [ "DiffviewOpen" "DiffviewToggleFiles" ];
      config = ''
        require'diffview'.setup()
      '';
      delay = true;
    }
    {
      plugin = nvim-tree-lua;
      depends = [ nvim-web-devicons ];
      commands = [ "NvimTreeToggle" ];
      config = readFile ./lua/nvim-tree_config.lua;
      delay = true;
    }
    {
      plugin = venn-nvim;
      config = "";
    }
    {
      plugin = toggleterm-nvim;
      config = readFile ./lua/toggleterm_config.lua;
      commands = [ "ToggleTerm" "ToggleTig" ];
    }
  ];
  util = with pkgs.vimPlugins; [
    {
      plugin = denops-vim;
      extraPackages = with pkgs; [ deno ];
    }
    {
      plugin = pum-vim;
      depends = [ lexima-vim vim-vsnip-integ ];
      config = ''
        vim.cmd[[
          ${readFile ./vim/pum.vim}
        ]]
      '';
    }
  ];
in {
  home.packages = with pkgs; [ neovim-remote ];
  programs.rokka-nvim = {
    inherit extraConfig extraConfigLua extraPackages;
    compileInitFile = true;
    # logLevel = "debug";
    enable = true;
    plugins = startup ++ input ++ custom ++ statusline ++ commandline
      ++ language ++ view ++ code ++ lsp ++ dap ++ template ++ movement ++ tool
      ++ util;
    withNodeJs = true;
    withPython3 = true;
  };
}
