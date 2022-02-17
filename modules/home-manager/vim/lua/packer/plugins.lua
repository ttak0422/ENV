local packer = nil

local function init()
  if not packer then
    vim.api.nvim_command('packadd packer.nvim')
    packer = require('packer')
    packer.init({
      disable_commands = true,
      auto_clean = true,
      compile_on_sync = true,
    })
  end

  local use = packer.use
  packer.reset()

  use 'nathom/filetype.nvim'
  use 'tpope/vim-sensible'

  use {
    'LnL7/vim-nix',
    ft = 'nix',
  }

  use 'editorconfig/editorconfig-vim'

  use {
    'kevinhwang91/nvim-hlslens',
    opt = true,
    event = 'CmdlineEnter',
  }

  use {
    'kevinhwang91/nvim-bqf',
    ft = 'qf',
  }

  use {
    'beauwilliams/focus.nvim',
    opt = true,
    event = { 'InsertEnter', 'CmdlineEnter' },
    config = [[require'packer.cfg.focus-nvim']],
  }

  use {
    'troydm/zoomwintab.vim',
    opt = true,
    cmd = 'ZoomWinTabToggle',
    setup = function ()
      vim.g.zoomwintab_remap = 0
    end,
  }

  use 'simeji/winresizer'

  use {
    'unblevable/quick-scope',
    opt = true,
    event = 'CursorMoved',
    setup = function ()
      vim.g.qs_highlight_on_keys = {'f', 'F', 't', 'T'}
    end,
  }

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
    'ulwlu/elly.vim',
  }

  use {
    'akinsho/nvim-bufferline.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = [[require'packer.cfg.bufferline-nvim']],
  }

  use {
    'windwp/windline.nvim',
    opt = true,
    config = [[ require'wlsample.vscode' ]],
  }

  use {
    'nvim-lualine/lualine.nvim',
    config = [[require'packer.cfg.lualine-nvim']],
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
    opt = true,
    cmd = {

      'HopChar1', 'HopChar2', 'HopLineAC', 'HopLineBC'},
      config = [[require'packer.cfg.hop-nvim']],
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
    'abecodes/tabout.nvim',
    config = [[require'packer.cfg.tabout-nvim']],
    opt = true,
    event = 'InsertEnter',
    wants = 'nvim-treesitter',
    after = 'nvim-cmp',
  }

  use {
    'windwp/nvim-autopairs',
    opt = true,
    event = { 'CursorMoved', 'InsertEnter' },
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
    'stevearc/aerial.nvim',
    opt = true,
    cmd = { 'AerialToggle' },
  }

  use {
    'edluffy/specs.nvim',
    opt = true,
    event = 'CursorMoved',
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
    opt = true,
    cmd = 'TroubleToggle',
    requires = 'kyazdani42/nvim-web-devicons',
    config = [[require'packer.cfg.trouble-nvim']],
  }

  use {
    'gelguy/wilder.nvim',
    opt = true,
    event = 'CmdlineEnter',
    requires =  { 'romgrk/fzy-lua-native', after = 'wilder.nvim' },
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
    opt = true,
    event = 'InsertEnter',
  }

  use {
    'lewis6991/spaceless.nvim',
    opt = true,
    event = 'InsertEnter',
    config = [[require'spaceless'.setup()]],
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
    config = [[require'packer.cfg.zen-mode-nvim']],
  }

  use {
    'ellisonleao/glow.nvim',
    opt = true,
    cmd = 'Glow',
    setup = function ()
      vim.g.glow_border = 'rounded'
    end,
  }

  use {
    'rmagatti/goto-preview',
    config = [[require'packer.cfg.goto-preview']],
  }

  use {
    'max397574/better-escape.nvim',
    config = [[require'packer.cfg.better-escape-nvim']],
  }

  use {
    'folke/which-key.nvim',
    wants = 'toggleterm',
    config = [[require'packer.cfg.which-key-nvim']],
  }

  use 'vim-jp/vimdoc-ja'

  use {
    'jghauser/mkdir.nvim',
    opt = true,
    event = 'CmdlineEnter',
    config = [[require'mkdir']],
  }

  use {
    'CRAG666/code_runner.nvim',
    opt = true,
    cmd = {
      'RunFile',
      'RunProject',
    },
    requires = 'nvim-lua/plenary.nvim',
    config = [[require'packer.cfg.code_runner-nvim']],
  }

  use {
    'karb94/neoscroll.nvim',
    opt = true,
    event = 'WinScrolled',
    config = [[require'packer.cfg.neoscroll-nvim']],
  }

end

local plugins = setmetatable({}, {
  __index = function(_, key)
    init()
    return packer[key]
  end,
})

function plugins.load()
  local present, _ = pcall(require, 'packer_compiled')
  if not present then
    assert('Run PackerCompile')
  end
  vim.cmd([[command! PackerInstall lua require('packer.plugins').install()]])
  vim.cmd([[command! PackerUpdate lua require('packer.plugins').update()]])
  vim.cmd([[command! PackerSync lua require('packer.plugins').sync()]])
  vim.cmd([[command! PackerClean lua require('packer.plugins').clean()]])
  vim.cmd([[command! PackerCompile lua require('packer.plugins').compile()]])
end

return plugins
