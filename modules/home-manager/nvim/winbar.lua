return function(opt)
  require("winbar").setup({
    enabled = true,
    show_file_path = true,
    show_symbols = false,
    icons = {
      file_icon_default = " ",
      seperator = ">",
      editor_state = "● ",
      lock_icon = " ",
    },

    exclude_filetype = opt.exclude_ft,
  })
end
