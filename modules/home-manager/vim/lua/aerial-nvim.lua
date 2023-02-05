require("aerial").setup({
  backends = { "treesitter" },
  treesitter = {
    update_delay = 1000,
  },
  layout = {
    placement = "edge",
  },
  float = {
    relative = "win",
    override = function(conf, source_winid)
      conf.anchor = "NE"
      conf.col = vim.fn.winwidth(source_winid)
      conf.row = 0
      return conf
    end,
  },
})

vim.api.nvim_create_user_command("ToggleOutline", function()
  require("aerial").toggle({ focus = false, direction = "float" })
end, {})
