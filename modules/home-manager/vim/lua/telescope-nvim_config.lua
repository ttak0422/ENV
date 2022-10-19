local telescope = require("telescope")
local lga_actions = require("telescope-live-grep-args.actions")

telescope.setup({
	defaults = {
		layout_strategy = "vertical",
		layout_config = { height = 0.95 },
		path_display = { "truncate" },
	},
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
		live_grep_args = {
			auto_quoting = true,
			mappings = { -- extend mappings
				i = {
					["<C-k>"] = lga_actions.quote_prompt(),
				},
			},
		},
	},
})

telescope.load_extension("live_grep_args")
telescope.load_extension("fzf")
telescope.load_extension("projects")
telescope.load_extensions("sonictemplate")
