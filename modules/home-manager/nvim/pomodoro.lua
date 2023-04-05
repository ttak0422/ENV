require("pommodoro-clock").setup({
  modes = {
    ["focus"] = { "POMMODORO", 25 },
    ["break"] = { "BREAK", 5 },
    ["long_break"] = { "LONG BREAK", 30 },
  },
  animation_duration = 300,
  animation_fps = 24,
  sound = "none",
  say_command = "none",
})
vim.api.nvim_create_user_command("Pomodoro", "lua require('pommodoro-clock').start('focus')", {})
vim.api.nvim_create_user_command("PomodoroBreak", "lua require('pommodoro-clock').start('break')", {})
vim.api.nvim_create_user_command("PomodoroClose", "lua require('pommodoro-clock').close()", {})
