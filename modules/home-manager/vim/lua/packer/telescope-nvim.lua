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
        require('telescope').setup{
            defaults = {
                layout_strategy = 'flex',
                layout_config = { height = 0.95 },
            },
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = 'smart_case',
                },
            },
        }
        require('telescope').load_extension('fzy_native')
    end,
}
