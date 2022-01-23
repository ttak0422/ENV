use {
    'romgrk/nvim-treesitter-context',
    requires = 'nvim-treesitter',
    config = function()
        require'treesitter-context'.setup{
            enable = true,
            throttle = true,
            max_lines = 0,
            patterns = {
                default = {
                    'class',
                    'function',
                    'method',
                    -- 'for',
                    -- 'while',
                    -- 'if',
                    -- 'switch',
                    -- 'case',
                },
            },
        }

    end,
}
