require("neogit").setup({
  kind = "split",
  disable_commit_confirmation = true,
  integrations = {
    diffview = true,
  },
  signs = {
    section = { "", "" },
    item = { "", "" },
  },
})
