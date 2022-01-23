use {
    'lewis6991/gitsigns.nvim',
    requires = {
        'nvim-lua/plenary.nvim'
    },
    config = function()
        require('gitsigns').setup {
            status_formatter = function(status)
                local added, changed, removed = status.added, status.changed, status.removed
                local status_txt = {}
                if added   and added   > 0 then table.insert(status_txt, ' '..added  ) end
                if changed and changed > 0 then table.insert(status_txt, ' '..changed) end
                if removed and removed > 0 then table.insert(status_txt, ' '..removed) end
                return table.concat(status_txt, ' ')
            end
        }

    end,
}
