vim.cmd[[packadd packer.nvim]]

require'packer'.startup(function()
  use{'wbthomason/packer.nvim', opt = true}

  use 'vim-jp/vimdoc-ja'

  use {
    'nvim-treesitter/nvim-treesitter',
    requires = {
      { 'p00f/nvim-ts-rainbow', after = 'nvim-treesitter' },
      { 'windwp/nvim-ts-autotag', after = 'nvim-treesitter' },
    },
    config = function() require'cfg.nvim-treesitter' end,
  }

  use {
    'romgrk/nvim-treesitter-context',
    config = function() require'cfg.nvim-treesitter-context' end,
  }

  use {
    'LionC/nest.nvim',
    config = function ()
      require'cfg.nest-nvim'
    end
  }

  use {
    'phaazon/hop.nvim',
    branch = 'v1',
    cmd = {'HopChar1', 'HopChar2', 'HopLineAC', 'HopLineBC'},
    config = function() require'cfg.hop-nvim'.setup() end,
  }

  use {
    'danymat/neogen',
    ft = { 'lua', 'python', 'javascript', 'cpp', 'go', 'java', 'rust', 'csharp' },
  }

  use {
    'onsails/lspkind-nvim',
    config = function() require'cfg.lspkind' end
  }

  use {
    'goolord/alpha-nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function () require'cfg.alpha-nvim' end
  }

  use {
    'akinsho/nvim-bufferline.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require'cfg.bufferline-nvim'
    end,
  }

  use {
    'sindrets/diffview.nvim',
    requires = 'nvim-lua/plenary.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewToggleFiles' },
    opt = true,
    config = function()
      require'cfg.diffview-nvim'
    end,
  }

  use {
    'lewis6991/gitsigns.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require'cfg.gitsigns-nvim'
    end,
  }

  use {
    'lukas-reineke/indent-blankline.nvim',
    setup = function()
      vim.opt.list = true
      vim.opt.listchars:append('space:⋅')
      vim.opt.listchars:append('eol:↴')
    end,
    config = function()
      require'cfg.indent-blanklin-nvim'
    end,
  }

  use {
    'ray-x/lsp_signature.nvim',
    config = function()
      require'cfg.lsp_signature-nvim'
    end,
  }

  use {
    -- maintained fork version
    'tami5/lspsaga.nvim',
    opt = true,
    cmd = 'Lspsaga',
    config = function()
      require'cfg.lspsaga-nvim'
    end,
  }

  use {
    'windwp/windline.nvim',
    config = [[ require'wlsample.vscode' ]],
  }
  -- use {
  --   'nvim-lualine/lualine.nvim',
  --   requires = { 'kyazdani42/nvim-web-devicons', opt = true },
  --   config = function()
  --     require'cfg.lualine-nvim'
  --   end,
  -- }

  use {
    'windwp/nvim-autopairs',
    config = function()
      require'cfg.nvim-autopairs'
    end,
  }


  use {
    'hrsh7th/nvim-cmp',
    requires = {
      { 'hrsh7th/vim-vsnip' },
      { 'jiangmiao/auto-pairs' },
      { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp' , after = 'nvim-cmp' },
      { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-emoji', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-vsnip', after = { 'nvim-cmp', 'vim-vsnip' } },
    },
    event = { 'InsertEnter', 'CmdlineEnter' },
    config = function()
      require'cfg.nvim-cmp'
    end,
  }

  use {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require 'cfg.nvim-colorizer-lua'
    end,
  }

  use 'nvim-lua/plenary.nvim'

  use 'tversteeg/registers.nvim'

  use {
    'ahmedkhalf/project.nvim',
    config = function()
      require'cfg.project-nvim'
    end,
  }

  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/cmp-nvim-lsp'
  use {
    'williamboman/nvim-lsp-installer',
    requires = {
      'nvim-lspconfig',
      'hrsh7th/cmp-nvim-lsp'
    },
    config = function()
      require'cfg.nvim-lsp-installer'
    end,
  }

  use {
    'sidebar-nvim/sidebar.nvim',
    config = function()
      require'cfg.sidebar-nvim'
    end,
  }

  use {
    'edluffy/specs.nvim',
    config = function()
      require'cfg.specs-nvim'
    end,
  }

  use {
    'luukvbaal/stabilize.nvim',
    config = function()
      require'cfg.stabilize-nvim'
    end
  }

  use {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    requires = {
       { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
      'nvim-telescope/telescope-live-grep-raw.nvim',
    },
    config = function()
      require'cfg.telescope-nvim'
    end,
  }

  use {
    'folke/todo-comments.nvim',
    requires = 'nvim-lua/plenary.nvim',
    cmd = {
      'TodoQuickFix',
      'TodoLocList',
      'TodoTrouble',
      'TodoTelescope',
    },
    opt = true,
    config = function()
      require'cfg.todo-comments-nvim'
    end,
  }

  use {
    'akinsho/toggleterm.nvim',
    config = function()
      require'cfg.toggleterm-nvim'
    end,
  }

  use 'folke/tokyonight.nvim'

  use {
    'folke/trouble.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('trouble').setup()
    end
  }

  use {
    'ojroques/vim-oscyank',
    opt = true,
    cmd = 'OSCYank',
  }

  use {
    't9md/vim-quickhl',
    keys = {
      '<Plug>(quickhl-manual-this)',
      '<Plug>(quickhl-manual-reset)',
    },
    setup = function()
      vim.api.nvim_set_keymap('n', '<Leader>m', '<Plug>(quickhl-manual-this)', { silent = true })
      vim.api.nvim_set_keymap('x', '<Leader>m', '<Plug>(quickhl-manual-this)', { silent = true })
      vim.api.nvim_set_keymap('n', '<Leader>M', '<Plug>(quickhl-manual-reset)', { silent = true })
      vim.api.nvim_set_keymap('x', '<Leader>M', '<Plug>(quickhl-manual-reset)', { silent = true })
    end,
  }

  use {
    'mattn/vim-sonictemplate',
    cmd = 'Template',
    opt = true,
  }

  use {
    'hrsh7th/vim-vsnip' ,
    event = { 'InsertEnter', 'CmdlineEnter' },
  }

  use {
      'folke/twilight.nvim',
      opt = true,
      config = [[ require'cfg.twilight-nvim' ]],
  }

  use {
    'folke/zen-mode.nvim',
    wants = 'twilight.nvim',
    cmd = 'ZenMode',
    opt = true,
    config = function()
      require'cfg.zen-mode-nvim'
    end,
  }

  -- {
  --   't9md/vim-choosewin',
  --   keys = {
  --     '<Plug>(choosewin)',
  --     '<Plug>(choosewin-swap)',
  --   },
  --   setup = function()
  --     vim.api.nvim_set_keymap('n', '<Leader>-', '<Plug>(choosewin)', { silent = true })
  --     vim.api.nvim_set_keymap('n', '<Leader><Leader>-', '<Plug>(choosewin-swap)', { silent = true })
  --   end,
  -- }

end)
