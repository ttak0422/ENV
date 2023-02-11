require("hologram").setup({
  auto_display = true,
})

-- fake command
vim.api.nvim_create_user_command("EnableHologram", "", {})
