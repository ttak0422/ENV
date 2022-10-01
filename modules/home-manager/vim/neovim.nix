{ config, pkgs, lib, ... }:

let
  inherit (builtins) concatStringsSep map fetchTarball readFile;
  inherit (lib.strings) fileContents;
  inherit (lib.lists) singleton;
  inherit (pkgs) fetchFromGitHub;
  inherit (pkgs.stdenv) mkDerivation;
  inherit (pkgs.vimUtils) buildVimPluginFrom2Nix;
  templates = pkgs.callPackage ./templates { };
  external = pkgs.callPackage ./external.nix { };
  myPlugins = pkgs.callPackage ./my-plugins.nix { };

  # TODO: smart override
  custom-nvim-treesitter = myPlugins.nvim-treesitter;
  custom-gitsigns-nvim = myPlugins.gitsigns-nvim;

  extraConfig = ''
    let g:neovide_cursor_vfx_mode = "pixiedust"

    ${fileContents ./vim/nvim.vim}
    ${fileContents ./vim/util.vim}
  '';

  startup = with pkgs.vimPlugins; [
    {
      plugin = myPlugins.filetype-nvim;
      startup = ''
        vim.g.did_load_filetypes = 1
      '';
      optional = false;
    }
    {
      plugin = myPlugins.serenade;
      startup = "vim.cmd([[colorscheme serenade]])";
      optional = false;
      enable = false;
    }
    {
      plugin = nightfox-nvim;
      startup = "vim.cmd([[colorscheme nightfox]])";
      optional = false;
    }
    {
      plugin = lsp-colors-nvim;
      config = ''
        require("lsp-colors").setup({})
      '';
      optional = false;
    }
    {
      plugin = vim-sensible;
      optional = false;
      comment = "必須設定群";
    }
    {
      plugin = myPlugins.alpha-nvim;
      config = readFile ./lua/alpha-nvim_config.lua;
      optional = false;
      comment = "splashscreen";
    }
    {
      plugin = which-key-nvim;
      config = readFile ./lua/which-key-nvim_config.lua;
      optional = false;
      comment = "whichkey";
    }
  ];

  ime = [{
    plugin = myPlugins.skkeleton;
    depends = [ myPlugins.denops-vim ];
    dependsAfter = [ myPlugins.skkeleton_indicator-nvim ];
    startup = ''
      vim.cmd([[
        function! s:skkeleton_init() abort
          call skkeleton#config({
            \ 'globalJisyo': '${pkgs.skk-dicts}/share/SKK-JISYO.L',
            \ 'globalJisyoEncoding': 'utf-8',
            \ 'useSkkServer': v:true,
            \ 'skkServerHost': '127.0.0.1',
            \ 'skkServerPort': 1178,
            \ 'skkServerReqEnc': 'euc-jp',
            \ 'skkServerResEnc': 'euc-jp',
            \ })
        endfunction
        augroup skkeleton-initialize-pre
          autocmd!
          autocmd User skkeleton-initialize-pre call s:skkeleton_init()
        augroup END
      ]])
    '';
    config = readFile ./lua/skkeleton_config.lua
      + readFile ./lua/skkeleton_indicator_config.lua;
    delay = true;
  }];

  custom = with pkgs.vimPlugins; [
    {
      plugin = myPlugins.pretty-fold-nvim;
      depends = [ myPlugins.fold-preview-nvim ];
      startup = ''
        -- default
        vim.opt.foldmethod = 'indent'
        vim.opt.foldlevel = 10
      '';
      config = readFile ./lua/pretty-fold-nvim.lua;
      delay = true;
      comment = "折り畳み強化";
    }
    {
      plugin = nvim-bqf;
      fileTypes = [ "qf" ];
      events = [ "QuickFixCmdPre" ];
      comment = "QuickFix強化";
    }
    {
      plugin = nvim-hlslens;
      events = [ "CmdlineEnter" ];
      comment = "hl強化";
    }
  ];

  statusline = with pkgs.vimPlugins; [
    {
      plugin = lualine-nvim;
      startup = ''
        vim.opt.laststatus = 3
      '';
      config = readFile ./lua/lualine_config.lua;
      delay = true;
    }
    {
      plugin = myPlugins.windline-nvim;
      startup = ''
        vim.opt.laststatus = 3
      '';
      delay = true;
      config = ''
        require('wlsample.vscode')
      '';
      enable = false;
    }
  ];

  commandline = with pkgs.vimPlugins; [
    {
      plugin = wilder-nvim;
      depends = [ myPlugins.fzy-lua-native ];
      events = [ "CmdlineEnter" ];
      config = readFile ./lua/wilder-nvim_config.lua;
      extraPackages = with pkgs; [ fd ];
    }
    {
      plugin = mkdir-nvim;
      events = [ "CmdlineEnter" ];
    }
  ];

  window = with pkgs.vimPlugins; [
    { plugin = myPlugins.winresizer; }
    {
      plugin = myPlugins.chowcho-nvim;
      depends = [ nvim-web-devicons ];
      commands = [ "Chowcho" ];
      config = ''
        require'chowcho'.setup {
          icon_enabled = true,
        }
      '';
    }
  ];

  language = with pkgs.vimPlugins; [
    {
      plugin = vim-nix;
      fileTypes = [ "nix" ];
    }
    {
      plugin = myPlugins.neofsharp-vim;
      fileTypes = [ "fs" "fsx" "fsi" "fsproj" ];
    }
  ];

  view = with pkgs.vimPlugins; [
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
      plugin = myPlugins.sidebar-nvim;
      config = readFile ./lua/sidebar-nvim.lua;
      commands = [ "SidebarNvimToggle" "SidebarNvimOpen" ];
    }
    {
      plugin = aerial-nvim;
      config = readFile ./lua/aerial-nvim.lua;
      commands = [ "AerialToggle" ];
    }
    {
      plugin = myPlugins.incline-nvim-pr;
      config = readFile ./lua/incline_config.lua;
      # delay = true;
      comment = "ペインにファイル名を表示";
    }
    {
      plugin = myPlugins.nvim-transparent;
      config = ''
        require("transparent").setup({
          enable = true,
        })
      '';
      commands =
        [ "TransparentEnable" "TransparentDisable" "TransparentToggle" ];
    }
    {
      plugin = myPlugins.headlines-nvim;
      config = readFile ./lua/headlines_config.lua;
      fileTypes = [ "markdown" "rmd" "vimwiki" "orgmode" ];
      enable = false;
    }
    {
      plugin = stabilize-nvim;
      config = ''
        require'stabilize'.setup()
      '';
      delay = true;
    }
    {
      plugin = indent-blankline-nvim;
      depends = [ custom-nvim-treesitter ];
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
      depends = [ nvim-web-devicons ];
      delay = true;
      config = readFile ./lua/bufferline_config.lua;
    }
    {
      plugin = custom-gitsigns-nvim;
      depends = [ plenary-nvim ];
      config = readFile ./lua/gitsigns_config.lua;
      delay = true;
    }
  ];

  code = with pkgs.vimPlugins;

    let
      # require lspsaga nvim-cmp(lsp)
      lspSharedConfig = ''
        local on_attach = function(client, bufnr)
          local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

          local opts = { noremap = true, silent = true }
          vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
          vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

          local bufopts = { noremap = true, silent = true, buffer = bufnr }
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
          vim.keymap.set('n', 'gh', '<cmd>Lspsaga lsp_finder<CR>', { silent = true })

          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
          -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
          vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<CR>', { silent = true })
          vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)

          vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
          vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
          vim.keymap.set('n', '<space>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, bufopts)

          vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
          -- vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
          vim.keymap.set('n', 'rn', '<cmd>Lspsaga rename<CR>', { silent = true })

          -- vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
          vim.keymap.set('n', '<leader>ca', '<cmd>Lspsaga code_action<CR>', { silent = true })
          vim.keymap.set('n', '<space>f', vim.lsp.buf.format, bufopts)

          if client.supports_method('textDocument/formatting') then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd('BufWritePre', {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({ bufnr = bufnr })
              end,
            })
          end
        end

        local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
      '';
    in [
      {
        plugin = custom-nvim-treesitter;
        dependsAfter = [ nvim-ts-rainbow nvim-ts-autotag ];
        delay = true;
        config = readFile ./lua/nvim-treesitter_config.lua;
        extraPackages = with pkgs; [ tree-sitter ];
      }
      {
        plugin = range-highlight-nvim;
        depends = [ cmd-parser-nvim ];
        config = ''
          require('range-highlight').setup{}
        '';
        events = [ "CmdlineEnter" ];
      }
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
        plugin = myPlugins.vim-migemo;
        config = ''
          vim.g.migemodict = '${external.migemo-dict}/migemo-dict'
        '';
        extraPackages = [ pkgs.cmigemo ];
        enable = false;
      }
      {
        plugin = myPlugins.migemo-search;
        extraPackages = [ pkgs.cmigemo ];
        config = ''
          vim.g.migemosearch_migemodict = '${external.migemo-dict}/migemo-dict}'
        '';
        enable = false;
      }
      {
        plugin = Shade-nvim;
        config = readFile ./lua/Shade-nvim.lua;
        events = [ "WinNew" ];
      }
      {
        plugin = luasnip;
        depends = [ friendly-snippets ];
        config = readFile ./lua/luasnip_config.lua;
      }
      {
        plugin = myPlugins.flare-nvim;
        config = readFile ./lua/flare_config.lua;
        events = [ "InsertEnter" ];
        enable = false;
        delay = true;
      }
      { plugin = vim-vsnip; }
      {
        plugin = nvim-cmp;
        dependsAfter = [
          {
            plugin = lspkind-nvim;
            config = readFile ./lua/lspkind_config.lua;
          }
          {
            plugin = cmp-vsnip;
            depends = [ vim-vsnip ];
          }
          nvim-autopairs
          custom-nvim-treesitter
          cmp-path
          cmp-buffer
          cmp-calc
          cmp-treesitter
          cmp-nvim-lsp
          cmp-nvim-lua
          {
            plugin = cmp_luasnip;
            depends = [ luasnip ];
          }
          myPlugins.cmp-nvim-lsp-signature-help
        ];
        config = ''
          vim.cmd[[silent source ${cmp-path}/after/plugin/cmp_path.lua]]
          vim.cmd[[silent source ${cmp-buffer}/after/plugin/cmp_buffer.lua]]
          vim.cmd[[silent source ${cmp-calc}/after/plugin/cmp_calc.lua]]
          vim.cmd[[silent source ${cmp-treesitter}/after/plugin/cmp_treesitter.lua]]
          vim.cmd[[silent source ${cmp-nvim-lsp}/after/plugin/cmp_nvim_lsp.lua]]
          vim.cmd[[silent source ${cmp_luasnip}/after/plugin/cmp_luasnip.lua]]
          vim.cmd[[silent source ${cmp-nvim-lua}/after/plugin/cmp_nvim_lua.lua]]
          vim.cmd[[silent source ${myPlugins.cmp-nvim-lsp-signature-help}/after/plugin/cmp_nvim_lsp_signature_help.lua]]
        '' + (readFile ./lua/nvim-cmp_config.lua);
        delay = true;
      }
      {
        plugin = myPlugins.lspsaga-nvim;
        depends = [ nvim-lspconfig ];
        # config = ''
        #   require 'lspsaga'.init_lsp_saga {}
        # '';
        config = readFile ./lua/lspsaga-nvim.lua;

        commands = [ "Lspsaga" ];
        delay = true;
      }
      {
        plugin = nvim-jdtls;
        depends = [ nvim-cmp myPlugins.lspsaga-nvim ];
        config = ''
          ${lspSharedConfig}
          local config = {
            on_attach = on_attach,
            capabilities = capabilities,
            cmd = {
              '${pkgs.jdt-language-server}/bin/jdt-language-server',
              '-data',
              os.getenv("HOME") .. '/.cache/jdtls/workspace',
              '-Xms128m',
              '-Xmx5G',
              '-XX:+UseG1GC',
            },
          }
          require('jdtls').start_or_attach(config)

          local group_name = 'jdtls_lsp'
          vim.api.nvim_create_augroup(group_name, { clear = true, })
          vim.api.nvim_create_autocmd({ 'FileType' }, {
            group = group_name,
            pattern = {'java'},
            callback = function()
              require('jdtls').start_or_attach(config)
            end,
          })
        '';
        fileTypes = [ "java" ];
      }
      {
        plugin = nvim-lspconfig;
        depends = [
          {
            plugin = fidget-nvim;
            config = ''
              require'fidget'.setup{}
            '';
          }
          nvim-cmp
          null-ls-nvim
          myPlugins.lspsaga-nvim
        ];
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

          -- null-ls
          local null_ls = require('null-ls')
          null_ls.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            sources = {
              -- prettier
              null_ls.builtins.formatting.prettier.with {
                prefer_local = 'node_modules/.bin'
              },
            },
          })
        '';
        extraPackages = (with pkgs; [
          gopls
          rnix-lsp
          rubyPackages.solargraph
          rust-analyzer
          sumneko-lua-language-server
          nodePackages.vscode-langservers-extracted
        ]) ++ (with pkgs.pkgs-stable; [
          deno
          nodePackages.bash-language-server
          nodePackages.pyright
          nodePackages.typescript-language-server
          nodePackages.yaml-language-server
          taplo-cli
        ]);
        delay = true;
      }
      {
        plugin = todo-comments-nvim;
        depends = [ plenary-nvim ];
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
        plugin = myPlugins.spaceless-nvim;
        config = ''
          require'spaceless'.setup()
        '';
        delay = true;
      }
      {
        plugin = nvim_context_vt;
        depends = [ custom-nvim-treesitter ];
        delay = true;
        config = readFile ./lua/nvim_context_vt_config.lua;
      }
      {
        plugin = goto-preview;
        config = readFile ./lua/goto-preview-nvim_config.lua;
        delay = true; # WIP
      }
      {
        plugin = hop-nvim;
        commands = [ "HopChar1" "HopChar2" "HopLineAC" "HopLineBC" ];
        config = ''
          require'hop'.setup()
        '';
      }
      {
        plugin = vim-oscyank;
        commands = [ "OSCYank" ];
        startup = ''
          vim.g.oscyank_term = 'default'
        '';
        optional = false;
      }
      {
        plugin = editorconfig-nvim;
        delay = true;
      }
      {
        plugin = telescope-nvim;
        depends = [
          plenary-nvim
          {
            plugin = myPlugins.telescope-fzf-native-nvim;
            optimize = false;
          }
          myPlugins.telescope-live-grep-args-nvim
          {
            plugin = project-nvim;
            config = readFile ./lua/project-nvim.lua;
          }
        ];
        config = readFile ./lua/telescope-nvim_config.lua;
        commands = [ "Telescope" ];
        extraPackages = with pkgs.pkgs-stable; [ fzf ripgrep ];
      }
      {
        plugin = quick-scope;
        startup = ''
          vim.g.qs_highlight_on_keys = {'f', 'F', 't', 'T'}
        '';
        events = [ "CursorMoved" ];
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
      {
        plugin = nvim-colorizer-lua;
        config = ''
          require 'colorizer'.setup()
        '';
        delay = true;
      }
      {
        plugin = registers-nvim;
        config = readFile ./lua/registers_config.lua;
        delay = true;
      }
      {
        plugin = nvim-autopairs;
        depends = [ custom-nvim-treesitter ];
        config = readFile ./lua/nvim-autopairs_config.lua;
        events = [ "InsertEnter" ];
      }
    ];

  tool = with pkgs.vimPlugins; [
    {
      plugin = myPlugins.vim-translator;
      config = ''
        vim.g.translator_target_lang = 'ja'
      '';
      commands = [ "Translate" ];
    }
    {
      plugin = myPlugins.git-conflict-nvim;
      delay = true;
      config = ''
        require'git-conflict'.setup()
      '';
    }
    {
      plugin = myPlugins.mdeval-nvim;
      config = readFile ./lua/mdeval_config.lua;
      extraPackages = [ pkgs.coreutils-full ];
    }
    {
      plugin = myPlugins.org-bullets-nvim;
      depends = [ custom-nvim-treesitter ];
      config = readFile ./lua/org-bullets_config.lua;
      enable = false;
    }
    {
      plugin = myPlugins.headlines-nvim;
      config = readFile ./lua/headlines_config.lua;
      enable = false;
    }
    {
      plugin = myPlugins.orgmode;
      depends = [
        nvim-cmp
        custom-nvim-treesitter
        myPlugins.org-bullets-nvim
        myPlugins.headlines-nvim
      ];
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
      depends = [ twilight-nvim twilight-nvim ];
      config = readFile ./lua/zen-mode_config.lua;
      commands = [ "ZenMode" ];
    }
    {
      plugin = twilight-nvim;
      depends = [ custom-nvim-treesitter ];
      config = readFile ./lua/twilight_config.lua;
    }
    {
      plugin = glow-nvim;
      commands = [ "Glow" ];
      startup = ''
        vim.g.glow_border = 'rounded'
      '';
      extraPackages = [ pkgs.glow ];
    }
    {
      plugin = nvim-spectre;
      depends = [ plenary-nvim nvim-web-devicons ];
      config = readFile ./lua/spectre_config.lua;
      extraPackages = [ pkgs.gnused ];
    }
    {
      plugin = diffview-nvim;
      depends = [{ plugin = plenary-nvim; }];
      commands = [ "DiffviewOpen" "DiffviewToggleFiles" ];
      config = ''
        require'diffview'.setup()
      '';
    }
    {
      plugin = nvim-tree-lua;
      depends = [ nvim-web-devicons ];
      commands = [ "NvimTreeToggle" ];
      config = readFile ./lua/nvim-tree_config.lua;
    }
    {
      plugin = venn-nvim;
      config = "";
    }
    {
      plugin = toggleterm-nvim;
      config = readFile ./lua/toggleterm_config.lua;
      optional = false;
    }
  ];
in {
  programs.rokka-nvim = {
    inherit extraConfig;
    enable = true;
    plugins = startup ++ ime ++ custom ++ statusline ++ commandline ++ window
      ++ language ++ view ++ code ++ tool;
    withNodeJs = true;
    withPython3 = true;
  };
  home = {
    sessionVariables = {
      JAVA_OPTS = "-javaagent:${pkgs.lombok}/share/java/lombok.jar";
    };
  };
}
