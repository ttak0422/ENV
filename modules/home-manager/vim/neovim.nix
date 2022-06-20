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
  packerPackage = pkgs.callPackage ./lua/packer { };
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
    config = readFile ./lua/lualine_config.lua;
    delay = true;
  }];

  commandline = with pkgs.vimPlugins; [{
    plugin = wilder-nvim;
    depends = [ myPlugins.fzy-lua-native ];
    events = [ "CmdlineEnter" ];
    config = readFile ./lua/wilder-nvim_config.lua;
  }];

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
      plugin = nvim-cmp;
      depends = [
        nvim-treesitter
        cmp-path
        cmp-buffer
        cmp-calc
        cmp-treesitter
        cmp-nvim-lsp
        myPlugins.cmp-nvim-lsp-signature-help
      ];
      config = ''
        vim.cmd[[silent source ${cmp-path}/after/plugin/cmp_path.lua]]
        vim.cmd[[silent source ${cmp-buffer}/after/plugin/cmp_buffer.lua]]
        vim.cmd[[silent source ${cmp-calc}/after/plugin/cmp_calc.lua]]
        vim.cmd[[silent source ${cmp-treesitter}/after/plugin/cmp_treesitter.lua]]
        vim.cmd[[silent source ${cmp-nvim-lsp}/after/plugin/cmp_nvim_lsp.lua]]
        vim.cmd[[silent source ${myPlugins.cmp-nvim-lsp-signature-help}/after/plugin/cmp_nvim_lsp_signature_help.lua]]

        vim.opt.completeopt = "menu,menuone,noselect"
        local cmp = require'cmp'
        cmp.setup {
          sources = {
            { name = 'path' }
          }
        }
      '';
      events = [ "InsertEnter" ];
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
      depends = [ myPlugins.nvim-lsp-installer nvim-cmp ];
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
      extraPackages = [ pkgs.tree-sitter ];
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
      depends = [ plenary-nvim ];
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
  ];
in {
  programs.rokka-nvim = {
    enable = true;
    plugins = startupPlugins ++ statusline ++ commandline ++ window ++ view
      ++ code ++ tool;
    extraConfig = ''
      vim.opt.termguicolors = true
      vim.opt.laststatus = 3
    '';
  };
  home = {
    packages = with pkgs;
      [ gcc python39Packages.pynvim lombok llvm ]
      ++ [ tree-sitter templates neovim-remote ];
    file = {
      ".config/nvim/lua/packer".source = packerPackage;
      ".skk".source = external.skk-dict;
    };
  };
  programs.neovim = {
    inherit extraConfig;
    plugins = [ pkgs.vimPlugins.nvim-treesitter ];
    enable = true;
    package = pkgs.neovim-nightly;
    extraPackages = [ pkgs.shfmt ];
    withNodeJs = true;
  };
}
