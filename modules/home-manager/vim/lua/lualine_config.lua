local lualine = require 'lualine'

local colors = {
  fg       = '#dcd7ba',
  bg       = '#1f1f28',
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
  gray     = '#969696',
  subFg    = '#111a1F',
  subBg    = '#6998B3',
}

local mode_color_fg = {
  n      = colors.bg,
  i      = colors.bg,
  v      = colors.bg,
  ['']  = colors.bg,
  V      = colors.bg,
  c      = colors.bg,
  no     = colors.bg,
  s      = colors.bg,
  S      = colors.bg,
  ['']  = colors.bg,
  ic     = colors.bg,
  R      = colors.bg,
  Rv     = colors.bg,
  cv     = colors.bg,
  ce     = colors.bg,
  r      = colors.bg,
  rm     = colors.bg,
  ['r?'] = colors.bg,
  ['!']  = colors.bg,
  t      = colors.bg,
}
local mode_color_bg = {
  n      = colors.red,
  i      = colors.green,
  v      = colors.blue,
  ['']  = colors.blue,
  V      = colors.blue,
  c      = colors.magenta,
  no     = colors.red,
  s      = colors.orange,
  S      = colors.orange,
  ['']  = colors.orange,
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
    thene = 'auto',
    component_separators = '',
    section_separators = '',
    globalstatus = true,
  },
  sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  inactive_sections = {
    lualine_a = {
      'filename',
    },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
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

local default_color = { fg = colors.fg, bg = colors.bg, }

ins_left({
  'mode',
  fmt = function(str)
    vim.api.nvim_command('hi! LualineMode guifg=' ..
      mode_color_fg[vim.fn.mode()] .. ' guibg=' .. mode_color_bg[vim.fn.mode()])
    vim.api.nvim_command('hi! LualineModeRev guifg=' .. mode_color_bg[vim.fn.mode()])
    return "??? " .. str:sub(1, 3)
  end,
  padding = { left = 1, right = 1 },
  color = 'LualineMode',
})

ins_left({
  'branch',
  icon = '???',
  cond = conditions.hide_in_width,
  padding = { left = 1, right = 0 },
})

ins_left({
  function() return '%=' end,
})

ins_left {
  function() return ' ??? ' end,
  padding = { left = 0, right = 0 },
  cond = conditions.hide_in_width,
}

ins_left({
  'filename',
  file_status = false,
  show_filename_only = true,
  hide_filename_extension = true,
  show_modified_status = false,
  padding = { left = 0, right = 0 },
  cond = conditions.hide_in_width,
})

ins_right({
  'diff',
  colored = false,
  symbols = { added = '??? ', modified = '??? ', removed = '??? ' },
  cond = conditions.hide_in_width,
  padding = { left = 0, right = 1 },
  always_visible = true,
})

ins_right({
  function() return '|' end,
  padding = { left = 0, right = 1 },
  cond = conditions.hide_in_width,
})

ins_right({
  'location',
  padding = { left = 0, right = 1 },
})

ins_right({
  function() return '|' end,
  padding = { left = 0, right = 1 },
  cond = conditions.hide_in_width,
})

ins_right({
  'diagnostics',
  always_visible = true,
  sources = { 'nvim_diagnostic' },
  sections = { 'error', 'warn' },
  symbols = { error = '??? ', warn = '??? ' },
  colored = false,
  padding = { left = 0, right = 1 },
})

ins_right({
  function() return '|' end,
  padding = { left = 0, right = 1 },
  cond = conditions.hide_in_width,
})

ins_right({
  'o:encoding',
  fmt = string.upper,
  cond = conditions.hide_in_width,
  padding = { left = 0, right = 1 },
})

ins_right({
  function() return '|' end,
  padding = { left = 0, right = 1 },
  cond = conditions.hide_in_width,
})

ins_right({
  'fileformat',
  symbols = { unix = "LF", dos = "CRLF", mac = "CR" },
  fmt = string.upper,
  cond = conditions.hide_in_width,
  padding = { left = 0, right = 1 },
})

ins_right({
  function() return '|' end,
  padding = { left = 0, right = 1 },
  cond = conditions.hide_in_width,
})

ins_right({
  'filetype',
  colored = false,
  icons_enabled = false,
  padding = { left = 0, right = 1 },
  cond = conditions.hide_in_width,
})

ins_right({
  function() return '???' end,
  padding = { left = 0, right = 0 },
  cond = conditions.hide_in_width,
})

lualine.setup(config)
