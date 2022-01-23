use {
    'lukas-reineke/indent-blankline.nvim',
    setup = function()
        vim.opt.list = true
        vim.opt.listchars:append('space:⋅')
        vim.opt.listchars:append('eol:↴')
    end,
    config = function()
        require('indent_blankline').setup {
            show_end_of_line = true,
            space_char_blankline = ' ',
        }
    end,
}
