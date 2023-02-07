require("lspsaga").setup({
  request_timeout = 30000,
  ui = {
    expand = "",
    collapse = "",
    preview = " ",
    code_action = "",
    diagnostic = "",
    incoming = " ",
    outgoing = " ",
    hover = " ",
    kind = {
      Folder = "",
      Class = " ",
      Module = " ",
      File = " ",
      Enum = " ",
      Method = " ",
      Property = " ",
      Field = "ﰠ ",
      Constructor = " ",
      Interface = " ",
      Function = "λ ",
      Variable = "𝒙 ",
      String = " ",
      Constant = " ",
      Text = " ",
      Unit = " ",
      Value = " ",
      Snippet = "﬌ ",
      Struct = "פּ ",
      Event = " ",
      Operator = " ",
      TypeParameter = " ",
      EnumMember = " ",
    },
  },
  finder = {
    max_height = 0.5,
    keys = {
      jump_to = "p",
      edit = { "e", "<CR>" },
      vsplit = "v",
      split = "s",
      tabe = "t",
      quit = { "q", "<ESC>" },
      close_in_preview = "<ESC>",
    },
  },
  lightbulb = {
    enable = false,
    enable_in_insert = false,
    sign = true,
    sign_priority = 9,
    virtual_text = false,
  },
  diagnostic = {
    show_code_action = false,
    show_source = false,
    jump_num_shortcut = false,
    border_follow = false,
  },
  symbol_in_winbar = {
    enable = false,
    separator = "  ",
    respect_root = true,
    color_mode = false,
  },
  beacon = {
    enable = true,
  },
})
