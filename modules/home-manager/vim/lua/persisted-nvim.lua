require("persisted").setup({
  use_git_branch = true,
  should_autosave = function()
    if vim.bo.filetype == "alpha" then
      return false
    end
    return true
  end,
  telescope = {
    before_source = function()
      vim.api.nvim_input("<ESC>:%bd<CR>")
    end,
    after_source = function(session)
      print("Loaded session " .. session.name)
    end,
  },
})
require("telescope").load_extension("persisted")
