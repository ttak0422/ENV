require("windows").setup({
  autowidth = {
    enable = true,
  },
  ignore = {
    buftype = { "quickfix" },
    filetype = dofile(args.exclude_ft_path),
  },
  animation = {
    enable = true,
    duration = 300,
    fps = 24,
    easing = "in_out_sine",
  },
})
