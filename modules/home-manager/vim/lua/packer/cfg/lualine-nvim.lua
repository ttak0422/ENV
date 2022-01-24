local lualine = require('lualine')

local colors = {
    bg       = '#202328',
    fg       = '#bbc2cf',
    yellow   = '#ECBE7B',
    cyan     = '#008080',
    darkblue = '#081633',
    green    = '#98be65',
    orange   = '#FF8800',
    violet   = '#a9a1e1',
    magenta  = '#c678dd',
    blue     = '#51afef',
    red      = '#ec5f67',
    white    = '#ffffff',
}
local mode_color_fg = {
    n      = colors.darkblue,
    i      = colors.darkblue,
    v      = colors.darkblue,
    [''] = colors.darkblue,
    V      = colors.darkblue,
    c      = colors.darkblue,
    no     = colors.darkblue,
    s      = colors.darkblue,
    S      = colors.darkblue,
    [''] = colors.darkblue,
    ic     = colors.darkblue,
    R      = colors.darkblue,
    Rv     = colors.darkblue,
    cv     = colors.darkblue,
    ce     = colors.darkblue,
    r      = colors.darkblue,
    rm     = colors.darkblue,
    ['r?'] = colors.darkblue,
    ['!']  = colors.darkblue,
    t      = colors.darkblue,
}
local mode_color_bg = {
    n      = colors.red,
    i      = colors.green,
    v      = colors.blue,
    [''] = colors.blue,
    V      = colors.blue,
    c      = colors.magenta,
    no     = colors.red,
    s      = colors.orange,
    S      = colors.orange,
    [''] = colors.orange,
    ic     = colors.yellow,
    R      = colors.violet,
    Rv     = colors.violet,
    cv     = colors.red,
    ce     = colors.red,
    r      = colors.cyan,
    rm     = colors.cyan,
    ['r?'] = colors.cyan,
    ['!']  = colors.red,
    t      = colors.red,
}

local conditions = {
    buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
    end,
    hide_in_width = function()
        return vim.fn.winwidth(0) > 80
    end,
}

local config = {
    options = {
        component_separators = '',
        section_separators = '',
        theme = 'OceanicNext',
    },
    sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {},
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {},
    },
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
    table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component)
    table.insert(config.sections.lualine_x, component)
end


ins_left({
    'mode',
    fmt = function(str)
        vim.api.nvim_command('hi! LualineMode guifg=' .. mode_color_fg[vim.fn.mode()] .. ' guibg=' .. mode_color_bg[vim.fn.mode()])
        return " " .. str:sub(1,3)
    end,
    padding = { left = 1, right = 1 }, -- We don't need space before this
    color = 'LualineMode',
})

ins_left({
    'branch',
    icon = '',
    color = {
        fg = colors.fg,
    },
})

ins_left({
    'diff',
    diff_color = {
        added = { fg = colors.fg },
        modified = { fg = colors.fg },
        removed = { fg = colors.fg},
    },
    symbols = { added = ' ', modified = ' ', removed = ' ' },
    cond = conditions.hide_in_width,
    padding = { left = 0, right = 1 },
})

ins_left({
    function()
        return '%='
    end,
})

ins_left({
    'diagnostics',
    always_visible = true,
    sources = { 'nvim_diagnostic' },
    symbols = { error = ' ', warn = ' ', info = ' ' },
    diagnostics_color = {
        error = {
            fg = colors.fg,
        },
        warn = {
            fg = colors.fg,
        },
        info = {
            fg = colors.fg,
        },
        hint = {
            fg = colors.fg,
        },
    },
})

ins_right({
    'location',
    padding = { left = 0, right = 1 },
    color = {
        fg = colors.fg,
    },
})

ins_right({
    'o:encoding',
    fmt = string.upper,
    padding = { left = 0, right = 1 },
    cond = conditions.hide_in_width,
    color = {
        fg = colors.fg,
    },
})

ins_right({
    'fileformat',
    symbols = { unix = "LF", dos = "CRLF", mac = "CR"},
    fmt = string.upper,
    padding = { left = 0, right = 1 },
    cond = conditions.hide_in_width,
    color = {
        fg = colors.fg,
    },
})

-- lsp status
ins_right({
    function()
        local msg = '⭘'
        local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then
            return msg
        end
        for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                return ''
            end
        end
        return msg
    end,
    icon_enabled = false,
    color = {
        fg = colors.darkblue,
        bg = colors.orange,
        gui = 'bold',
    },
})

lualine.setup(config)
