vim.api.nvim_create_autocmd({ "QuickFixCmdPre" }, {
  callback = function()
    vim.cmd([[MinimapClose]])
  end,
})
