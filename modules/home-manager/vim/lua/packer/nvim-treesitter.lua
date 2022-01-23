use 'p00f/nvim-ts-rainbow'
use {
    'nvim-treesitter/nvim-treesitter',
    requires = 'p00f/nvim-ts-rainbow',
    config = function()
        require'nvim-treesitter.configs'.setup {
            ensure_installed = 'maintained',
            sync_install = false,
            ignore_install = {},
            highlight = {
                enable = true,
                disable = { 'c' },
                additional_vim_regex_highlighting = false,
            },
            rainbow = {
                enable = true,
                extended_mode = true,
                max_file_lines = nil,
            }
        }

    end,
}
