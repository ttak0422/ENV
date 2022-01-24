local packer = nil
local function init()
    if packer == nil then
        packer = require('packer')
        packer.init({disable_commands = true})
    end

    local use = packer.use
    packer.reset()

    use{'wbthomason/packer.nvim', opt = true}

    use 'vim-jp/vimdoc-ja'

    use {
      'nvim-treesitter/nvim-treesitter',
      config = function() require'cfg.nvim-treesitter' end,
    }

    use {
      'romgrk/nvim-treesitter-context',
      config = function() require'cfg.nvim-treesitter-context' end,
    }

    use {
        'phaazon/hop.nvim',
        branch = 'v1',
        cmd = {'HopChar1', 'HopChar2', 'HopLineAC', 'HopLineBC'},
        setup = function()
            vim.api.nvim_set_keymap('n', '<Leader>s', '<cmd>HopChar1<CR>', { noremap = true, silent = true })
            vim.api.nvim_set_keymap('n', '<Leader><Leader>s', '<cmd>HopChar2<CR>', { noremap = true, silent = true })
            vim.api.nvim_set_keymap('n', '<Leader>j', '<cmd>HopLineAC<CR>', { noremap = true, silent = true })
            vim.api.nvim_set_keymap('n', '<Leader>k', '<cmd>HopLineBC<CR>', { noremap = true, silent = true })
        end,
        config = function() require'cfg.hop-nvim'.setup() end,
    }

    use {
        'danymat/neogen',
        ft = { 'lua', 'python', 'javascript', 'cpp', 'go', 'java', 'rust', 'csharp' },
        setup = function()
            vim.api.nvim_set_keymap('n', '<Leader>nc', ":lua require('neogen').generate({ type = 'class' })<CR>", { noremap = true, silent = true })
        end,
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
        setup = function()
            vim.api.nvim_set_keymap('n', '<Leader>ca', '<cmd>Lspsaga code_action<CR>', { noremap = true, silent = true })
            vim.api.nvim_set_keymap('v', '<Leader>ca', ':<C-u>Lspsaga range_code_action<CR>', { noremap = true, silent = true })
            vim.api.nvim_set_keymap('n', '<Leader>ca', '<cmd>Lspsaga rename<CR> ', { noremap = true, silent = true })
        end,
        config = function()
            require'cfg.lspsaga-nvim'
        end,
    }

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        config = function()
            require'cfg.lualine-nvim'
        end,
    }

    use {
        'windwp/nvim-autopairs',
        config = function()
            require'cfg.nvim-autopairs'
        end,
    }

    -- use {
    --     'ojroques/nvim-bufdel',
    --     config = function()
    --         require'cfg.nvim-bufdel'
    --     end,
    -- }

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

    use 'p00f/nvim-ts-rainbow'

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
        cmd = 'Telescope',
        requires = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-fzy-native.nvim',
            'romgrk/fzy-lua-native',
        },
        setup = function()
            vim.api.nvim_set_keymap('n', '<Leader>ff', '<cmd>Telescope live_grep<CR>', { noremap = true, silent = true })
            vim.api.nvim_set_keymap('n', '<Leader>fp', '<cmd>Telescope find_files<CR>', { noremap = true, silent = true })
            vim.api.nvim_set_keymap('n', '<Leader>fb', '<cmd>Telescope buffers<CR>', { noremap = true, silent = true })
        end,
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
        't9md/vim-choosewin',
        opt = true,
        cmd = { 'ChooseWin', 'ChooseWinSwap' },
        setup = function()
            vim.api.nvim_set_keymap('n', '<Leader>-', '<cmd>ChooseWin<CR> ', { noremap = true, silent = true })
            vim.api.nvim_set_keymap('n', '<Leader><Leader>-', '<cmd>ChooseWinSwap<CR> ', { noremap = true, silent = true })
        end,
    }

    use {
        'ojroques/vim-oscyank',
        opt = true,
        cmd = 'OSCYank',
        setup = function()
            vim.api.nvim_set_keymap('v', '<Leader>y', '<cmd>OSCYank<CR> ', { noremap = true, silent = true })
        end,
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

    use 'folke/twilight.nvim'

    use {
        'folke/zen-mode.nvim',
        cmd = 'ZenMode',
        setup = function()
            vim.api.nvim_set_keymap('n', '<Leader><Leader>z', '<cmd>ZenMode<CR>', { noremap = true, silent = true })
        end,
        config = function()
            require'cfg.zen-mode-nvim'
        end,
    }

end

local plugins = setmetatable({}, {
    __index = function(_, key)
        init()
        return packer[key]
    end
})

return plugins
