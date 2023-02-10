return function(opt)
  require("noice").setup({
    cmdline = {
      enabled = true,
      view = "cmdline_popup",
      opts = {},
      format = {
        cmdline = { pattern = "^:", icon = "", lang = "vim" },
        search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
        search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
        filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
        lua = { pattern = "^:%s*lua%s+", icon = "", lang = "lua" },
        help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
        input = {},
      },
    },
    popupmenu = {
      enabled = true,
      backend = "nui",
      kind_icons = {},
    },
    redirect = {
      view = "popup",
      filter = { event = "msg_show" },
    },
    commands = {
      history = {
        view = "split",
        opts = { enter = true, format = "details" },
        filter = {
          any = {
            { event = "notify" },
            { error = true },
            { warning = true },
            { event = "msg_show", kind = { "" } },
            { event = "lsp", kind = "message" },
          },
        },
      },
      last = {
        view = "popup",
        opts = { enter = true, format = "details" },
        filter = {
          any = {
            { event = "notify" },
            { error = true },
            { warning = true },
            { event = "msg_show", kind = { "" } },
            { event = "lsp", kind = "message" },
          },
        },
        filter_opts = { count = 1 },
      },
      errors = {
        view = "popup",
        opts = { enter = true, format = "details" },
        filter = { error = true },
        filter_opts = { reverse = true },
      },
    },
    notify = {
      enabled = true,
      view = "notify",
    },
    lsp = {
      progress = {
        enabled = false,
      },
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = false,
        ["vim.lsp.util.stylize_markdown"] = false,
      },
      hover = {
        enabled = false,
      },
      signature = {
        enabled = false,
      },
    },
    messages = {
      -- enabled = false,
    },
    markdown = {
      hover = {
        ["|(%S-)|"] = vim.cmd.help,
        ["%[.-%]%((%S-)%)"] = require("noice.util").open,
      },
      highlights = {
        ["|%S-|"] = "@text.reference",
        ["@%S+"] = "@parameter",
        ["^%s*(Parameters:)"] = "@text.title",
        ["^%s*(Return:)"] = "@text.title",
        ["^%s*(See also:)"] = "@text.title",
        ["{%S-}"] = "@parameter",
      },
    },
    smart_move = {
      excluded_filetypes = opt.exclude_ft,
    },
    throttle = 1000 / 30,
  })
end
