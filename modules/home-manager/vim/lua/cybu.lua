return function(opt)
  require("cybu").setup({
    position = {
      max_win_height = 30,
      max_win_width = 0.75,
    },
    exclude = opt.exclude_ft,
  })
end
