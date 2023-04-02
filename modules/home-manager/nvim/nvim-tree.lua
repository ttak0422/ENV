local circles = require("circles")
circles.setup({ icons = { empty = "", filled = "", lsp_prefix = "" } })

require("nvim-tree").setup({
  hijack_cursor = true,
  sync_root_with_cwd = true,
  view = {
    width = 35,
    side = "left",
    hide_root_folder = true,
    adaptive_size = false,
    mappings = {
      custom_only = true,
      list = {
        { key = { "<CR>", "e", "o" }, action = "edit" },
        { key = "O", action = "system_open" },
        { key = "a", action = "create" },
        { key = "d", action = "remove" },
        { key = "r", action = "rename" },
        { key = "R", action = "refresh" },
        { key = "?", action = "toggle_help" },
      },
    },
  },
  update_focused_file = {
    enable = true,
    update_root = false,
  },
  renderer = {
    group_empty = true,
    indent_width = 1,
    icons = {
      glyphs = circles.get_nvimtree_glyphs(),
    },
  },
  filters = {
    dotfiles = false,
  },
  git = {
    ignore = false,
  },
})
