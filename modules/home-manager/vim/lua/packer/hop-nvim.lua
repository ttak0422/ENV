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
    config = function()
        require'hop'.setup()
    end,
}
