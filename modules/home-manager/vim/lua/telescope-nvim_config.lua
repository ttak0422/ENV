local telescope = require("telescope")
local lga_actions = require("telescope-live-grep-args.actions")

telescope.setup({
  defaults = require("telescope.themes").get_ivy({
    path_display = { "truncate" },
    prompt_prefix = " ",
    selection_caret = " ",
  }),
  extensions = {
    file_browser = {
      theme = "ivy",
      mappings = {
        ["i"] = {},
        ["n"] = {},
      },
    },
    undo = {
      use_delta = false, -- wip
    },
    live_grep_args = {
      auto_quoting = true,
      mappings = { -- extend mappings
        i = {
          ["<C-k>"] = lga_actions.quote_prompt(),
          ["<C-t>"] = lga_actions.quote_prompt({ postfix = " -t " }),
          ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
        },
      },
    },
    ["ui-select"] = {
      require("telescope.themes").get_ivy({}),
    },
  },
})

telescope.load_extension("live_grep_args")
telescope.load_extension("projects")
telescope.load_extension("file_browser")
telescope.load_extension("sonictemplate")
telescope.load_extension("ui-select")
telescope.load_extension("undo")
