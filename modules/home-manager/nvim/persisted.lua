local exclude_ft = {}
for _, ft in ipairs(dofile(args.exclude_ft_path)) do
  exclude_ft[ft] = true
end

require("persisted").setup({
  autoload = true,
  autosave = false,
  use_git_branch = true,
  should_autosave = function()
    if exclude_ft[vim.bo.filetype] then
      return false
    end
    return true
  end,
})

vim.api.nvim_create_autocmd({ "User" }, {
  pattern = "PersistedSavePre",
  callback = function()
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
      local ft = vim.bo[bufnr].filetype
      if exclude_ft[ft] or string.sub(ft or "", 1, 4) == "term" then
        vim.cmd("bw! " .. bufnr)
      end
      -- pcall(vim.cmd, "bw minimap")
      vim.cmd([[SessionSave]])
    end
  end,
})
