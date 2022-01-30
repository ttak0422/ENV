local packer = nil

local function init()
  if not packer then
    vim.api.nvim_command('packadd packer.nvim')
    packer = require('packer')
    global = require('packer.cfg.global')
    packer.init({
      compile_path = global.compile_path,
      disable_commands = true,
    })
  end

  local use = packer.use
  packer.reset()

  use 'nathom/filetype.nvim'
  use {
    'lewis6991/impatient.nvim',
    config = [[require'packer.cfg.impatient-nvim']],
  }

  use {
    'goolord/alpha-nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = [[require'packer.cfg.alpha-nvim']],
  }

  use {
    'themercorp/themer.lua',
    config = [[require'packer.cfg.themer-lua']],
  }

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = [[require'packer.cfg.lualine-nvim']],
  }

  use {
    'akinsho/nvim-bufferline.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = [[require'packer.cfg.bufferline-nvim']],
  }

  use {
    'windwp/windline.nvim',
    config = [[ require'wlsample.vscode' ]],
  }

  use {
    'lewis6991/gitsigns.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = [[require'packer.cfg.gitsigns-nvim']],
  }

  use {
    'lukas-reineke/indent-blankline.nvim',
    setup = function ()
      vim.opt.list = true
      vim.opt.listchars:append('eol:↴')
    end,
    config = [[require'packer.cfg.indent-blanklin-nvim']],
  }

  use {
    'kyazdani42/nvim-tree.lua',
    cmd = 'NvimTreeToggle',
    opt = true,
    config = [[require'packer.cfg.nvim-tree']],
  }

  use {
    'ojroques/nvim-bufdel',
    opt = true,
    cmd = {'BufDel','BufDel!'},
    config = [[require'packer.cfg.nvim-bufdel']],
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    requires = {
      { 'p00f/nvim-ts-rainbow', after = 'nvim-treesitter' },
      { 'windwp/nvim-ts-autotag', after = 'nvim-treesitter' },
    },
    config = [[require'packer.cfg.nvim-treesitter']],
  }

  use {
    'romgrk/nvim-treesitter-context',
    wants = 'nvim-treesitter',
    config = [[require'packer.cfg.nvim-treesitter-context']],
  }

  use {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    requires = {
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
      { 'nvim-telescope/telescope-live-grep-raw.nvim' },
      { 'nvim-lua/plenary.nvim' },
    },
    config =[[require'packer.cfg.telescope-nvim']]
  }

  use {
    'phaazon/hop.nvim',
    branch = 'v1',
    opt = true,
    cmd = {'HopChar1', 'HopChar2', 'HopLineAC', 'HopLineBC'},
    config = [[require'packer.cfg.hop-nvim'.setup()]],
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
    config = [[require'packer.cfg.nvim-cmp']],
  }

  use {
    'windwp/nvim-autopairs',
    config = [[require'packer.cfg.nvim-autopairs']],
  }

  use {
    'danymat/neogen',
    ft = { 'lua', 'python', 'javascript', 'cpp', 'go', 'java', 'rust', 'csharp' },
  }

  use {
    'onsails/lspkind-nvim',
    config = [[require'packer.cfg.lspkind']],
  }


  use {
    'sindrets/diffview.nvim',
    requires = 'nvim-lua/plenary.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewToggleFiles' },
    opt = true,
    config = [[require'packer.cfg.diffview-nvim']],
  }

  use {
    'ray-x/lsp_signature.nvim',
    config = [[require'packer.cfg.lsp_signature-nvim']],
  }

  use {
    -- maintained fork version
    'tami5/lspsaga.nvim',
    opt = true,
    cmd = 'Lspsaga',
    config = [[require'packer.cfg.lspsaga-nvim']],
  }


  use {
    'norcalli/nvim-colorizer.lua',
    config = [[require 'packer.cfg.nvim-colorizer-lua']],
  }


  use 'tversteeg/registers.nvim'

  use {
    'ahmedkhalf/project.nvim',
    config = [[require'packer.cfg.project-nvim']],
  }

  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/cmp-nvim-lsp'
  use {
    'williamboman/nvim-lsp-installer',
    requires = {
      'nvim-lspconfig',
      'hrsh7th/cmp-nvim-lsp'
    },
    config = [[require'packer.cfg.nvim-lsp-installer']],
  }

  use {
    'sidebar-nvim/sidebar.nvim',
    config = [[require'packer.cfg.sidebar-nvim']],
  }

  use {
    'edluffy/specs.nvim',
    config = [[require'packer.cfg.specs-nvim']],
  }

  use {
    'luukvbaal/stabilize.nvim',
    config = [[require'packer.cfg.stabilize-nvim']],
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
    config = [[require'packer.cfg.todo-comments-nvim']],
  }

  use {
    'akinsho/toggleterm.nvim',
    config = [[require'packer.cfg.toggleterm-nvim']],
  }

  use {
    'folke/trouble.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = [[require('trouble').setup()]],
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
    config = [[require'packer.cfg.twilight-nvim']],
  }

  use {
    'folke/zen-mode.nvim',
    wants = 'twilight.nvim',
    cmd = 'ZenMode',
    opt = true,
    config =[[require'packer.cfg.zen-mode-nvim']],
  }

  use {
    'LionC/nest.nvim',
    wants = 'toggleterm',
    config = [[require'packer.cfg.nest-nvim']],
  }

  use 'vim-jp/vimdoc-ja'


end

-- {
--   't9md/vim-choosewin',
--   keys = {
--     '<Plug>(choosewin)',
--     '<Plug>(choosewin-swap)',
--   },
--   opt = true,
--   setup = function()
--     vim.api.nvim_set_keymap('n', '<Leader>-', '<Plug>(choosewin)', { silent = true })
--     vim.api.nvim_set_keymap('n', '<Leader><Leader>-', '<Plug>(choosewin-swap)', { silent = true })
--   end,
-- }

local plugins = setmetatable({}, {
  __index = function(_, key)
    init()
    return packer[key]
  end,
})

return plugins
