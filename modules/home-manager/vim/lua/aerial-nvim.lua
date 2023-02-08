require("aerial").setup({
  backends = { "treesitter" },
  treesitter = {
    update_delay = 1000,
  },
  layout = {
    min_width = 20,
    placement = "edge",
    default_direction = "float",
  },
  float = {
    relative = "win",
    override = function(conf, source_winid)
      conf.anchor = "SE"
      conf.col = vim.fn.winwidth(source_winid) - 3
      conf.row = vim.fn.winheight(source_winid) - 0
      return conf
    end,
  },
})

vim.api.nvim_create_user_command("ToggleOutline", function()
  require("aerial").toggle({ focus = false, direction = "float" })
end, {})
