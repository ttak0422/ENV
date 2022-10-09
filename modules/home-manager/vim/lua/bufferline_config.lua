require("bufferline").setup({
  options = {
    show_buffer_icons = false,
    show_buffer_close_icons = false,
    show_close_icon = false,
    separator_style = "thick",
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        highlight = "Directory",
        text_align = "center",
      },
    },
    highlights = require("catppuccin.groups.integrations.bufferline").get(),
  },
})
