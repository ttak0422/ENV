local telescope = require("telescope")
local lga_actions = require("telescope-live-grep-args.actions")

telescope.setup({
  defaults = require("telescope.themes").get_ivy({
    path_display = { "truncate" },
    prompt_prefix = " ",
    selection_caret = " ",
  }),
  extensions = {
    live_grep_args = {
      auto_quoting = true,
      mappings = {
        i = {
          ["<C-t>"] = lga_actions.quote_prompt({ postfix = " -t " }),
          ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
        },
      },
    },
  },
})

telescope.load_extension("live_grep_args")
telescope.load_extension("sonictemplate")
telescope.load_extension("projects")
telescope.load_extension("ui-select")
