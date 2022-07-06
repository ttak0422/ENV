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
  lua = luaCode: ''
    lua <<EOF
    ${luaCode}
    EOF
  '';
  readLua = path: lua (fileContents path);

  extraConfig = ''
    " set filetypes
    autocmd BufNewFile,BufRead *.fs,*.fsi,*.fsx set filetype=fsharp

    ${fileContents ./vim/util.vim}
  '';

  startupPlugins = with pkgs.vimPlugins; [
    {
      plugin = impatient-nvim;
      enable = false;
      optional = false;
      config = ''
        require('impatient').enable_profile()
      '';
    }
    {
      plugin = vim-sensible;
      optional = false;
    }
    {
      plugin = myPlugins.serenade;
      startup = ''
        vim.cmd([[colorscheme serenade]])
      '';
      optional = false;
    }
    {
      plugin = myPlugins.alpha-nvim;
      config = readFile ./lua/alpha-nvim_config.lua;
      optional = false;
    }
  ];

  statusline = with pkgs.vimPlugins; [{
    plugin = lualine-nvim;
    startup = ''
      vim.opt.laststatus = 3
    '';
    config = readFile ./lua/lualine_config.lua;
    delay = true;
  }];

  commandline = with pkgs.vimPlugins; [
    {
      plugin = wilder-nvim;
      depends = [ myPlugins.fzy-lua-native ];
      events = [ "CmdlineEnter" ];
      config = readFile ./lua/wilder-nvim_config.lua;
      extraPackages = with pkgs; [ fd ];
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

  view = with pkgs.vimPlugins; [
    # {
    #   plugin = myPlugins.incline-nvim;
    #   config = readFile ./lua/incline_config.lua;
    #   enable = false;
    #   delay = true;
    # }
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
      config = readFile ./lua/indent-blankline-nvim_config.lua;
      delay = true;
    }
    {
      plugin = nvim-scrollview;
      delay = true;
    }
    {
      plugin = neoscroll-nvim;
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
      plugin = gitsigns-nvim;
      depends = [ plenary-nvim ];
      config = readFile ./lua/gitsigns_config.lua;
      delay = true;
    }
  ];

  ime = [
    {
      plugin = myPlugins.skkeleton;
      depends = [
        myPlugins.denops-vim
        myPlugins.skkeleton_indicator-nvim
      ];
      startup = ''
        vim.cmd([[
          function! s:skkeleton_init() abort
            call skkeleton#config({
              \ 'useSkkServer': v:true,
              \ 'globalJisyo': '${external.skk-dict}/SKK-JISYO.L',
              \ })
          endfunction
          augroup skkeleton-initialize-pre
            autocmd!
            autocmd User skkeleton-initialize-pre call s:skkeleton_init()
          augroup END
        ]])
      '';
      config = readFile ./lua/skkeleton_config.lua + readFile ./lua/skkeleton_indicator_config.lua;
      delay = true;
    }
  ];

  code = with pkgs.vimPlugins; [
    {
      plugin = myPlugins.filetype-nvim;
      startup = ''
        vim.g.did_load_filetypes = 1
      '';
      optional = false;
    }
    {
      plugin = vim-nix;
      fileTypes = [ "nix" ];
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
      depends = [
        {
          plugin = lspkind-nvim;
          config = readFile ./lua/lspkind_config.lua;
        }
        {
          plugin = cmp-vsnip;
          depends = [ vim-vsnip ];
        }
        nvim-autopairs
        nvim-treesitter
        cmp-path
        cmp-buffer
        cmp-calc
        cmp-treesitter
        cmp-nvim-lsp
        myPlugins.cmp-nvim-lsp-signature-help
        myPlugins.orgmode
        {
          plugin = myPlugins.cmp-skkeleton;
          depends = [ myPlugins.skkeleton ];
        }
      ];
      config = ''
        vim.cmd[[silent source ${cmp-path}/after/plugin/cmp_path.lua]]
        vim.cmd[[silent source ${cmp-buffer}/after/plugin/cmp_buffer.lua]]
        vim.cmd[[silent source ${cmp-calc}/after/plugin/cmp_calc.lua]]
        vim.cmd[[silent source ${cmp-treesitter}/after/plugin/cmp_treesitter.lua]]
        vim.cmd[[silent source ${cmp-nvim-lsp}/after/plugin/cmp_nvim_lsp.lua]]
        vim.cmd[[silent source ${myPlugins.cmp-nvim-lsp-signature-help}/after/plugin/cmp_nvim_lsp_signature_help.lua]]
        vim.cmd[[silent source ${myPlugins.cmp-skkeleton}/after/plugin/cmp_skkeleton.lua]]
      '' + (readFile ./lua/nvim-cmp_config.lua);
      events = [ "InsertEnter" ];
      delay = true;
    }
    {
      plugin = myPlugins.lspsaga-nvim;
      depends = [ nvim-lspconfig ];
      config = ''
        require 'lspsaga'.init_lsp_saga {}
      '';
      commands = [ "Lspsaga" ];
    }
    {
      plugin = nvim-lspconfig;
      depends = [{ plugin = myPlugins.nvim-lsp-installer; } nvim-cmp];
      config = readFile ./lua/nvim-lspconfig_config.lua;
      delay = true;
    }
    {
      plugin = todo-comments-nvim;
      depends = [ plenary-nvim ];
      commands = [ "TodoQuickFix" "TodoLocList" "TodoTrouble" "TodoTelescope" ];
      config = ''
        require'todo-comments'.setup {}
      '';
    }
    {
      plugin = trouble-nvim;
      depends = [ nvim-web-devicons ];
      commands = [ "TroubleToggle" ];
      config = ''
        require'trouble'.setup{
          use_diagnostic_signs = true,
          auto_fold = false,
          auto_preview = false,
        }
      '';
    }
    {
      plugin = myPlugins.spaceless-nvim;
      config = ''
        require'spaceless'.setup()
      '';
      delay = true;
    }
    {
      plugin = which-key-nvim;
      config = readFile ./lua/which-key-nvim_config.lua;
      delay = true;
    }
    {
      plugin = nvim-treesitter;
      depends = [ nvim-ts-rainbow nvim-ts-autotag ];
      delay = true;
      config = readFile ./lua/nvim-treesitter_config.lua;
      extraPackages = with pkgs; [
        tree-sitter
        # tree-sitter-grammars.tree-sitter-org-nvim
      ];
    }
    {
      plugin = nvim_context_vt;
      depends = [ nvim-treesitter ];
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
      ];
      config = readFile ./lua/telescope-nvim_config.lua;
      commands = [ "Telescope" ];
      extraPackages = with pkgs; [ fzf ripgrep ];
    }
    {
      plugin = nvim-bqf;
      fileTypes = [ "qf" ];
    }
    {
      plugin = nvim-hlslens;
      events = [ "CmdlineEnter" ];
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
      depends = [ nvim-treesitter ];
      config = readFile ./lua/nvim-autopairs_config.lua;
      events = [ "InsertEnter" ];
    }
  ];

  tool = with pkgs.vimPlugins; [
    {
      plugin = myPlugins.mdeval-nvim;
      config = readFile ./lua/mdeval_config.lua;
      extraPackages = [ pkgs.coreutils-full ];
    }
    {
      plugin = myPlugins.org-bullets-nvim;
      depends = [ nvim-treesitter ];
      config = readFile ./lua/org-bullets_config.lua;
    }
    {
      plugin = myPlugins.headlines-nvim;
      config = readFile ./lua/headlines_config.lua;
    }
    {
      plugin = myPlugins.orgmode;
      depends = [
        nvim-cmp
        nvim-treesitter
        myPlugins.org-bullets-nvim
        myPlugins.headlines-nvim
      ];
      startup = ''
        vim.opt.conceallevel = 2
        vim.opt.concealcursor = 'nc'
      '';
      config = readFile ./lua/orgmode_config.lua;
      fileTypes = [ "org" ];
    }
    {
      plugin = fidget-nvim;
      config = ''
        require'fidget'.setup{}
      '';
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
      depends = [ nvim-treesitter ];
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
in
{
  programs.rokka-nvim = {
    enable = true;
    plugins = startupPlugins ++ statusline ++ commandline ++ window ++ view
      ++ code ++ tool ++ ime;
    extraConfig = ''
      vim.o.guifont = 'JetBrainsMonoExtraBold Nerd Font Mono'
      vim.opt.termguicolors = true
    '';
  };
  home = {
    file = {
      ".skk".source = external.skk-dict;
    };
  };
  programs.neovim = {
    inherit extraConfig;
    enable = true;
    package = pkgs.neovim-nightly;
    plugins = with pkgs.vimPlugins; [ wilder-nvim ];
    withNodeJs = true;
    withPython3 = true;
  };
}
