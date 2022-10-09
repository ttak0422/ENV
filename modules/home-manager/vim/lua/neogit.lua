require("neogit").setup({
	signs = {
		section = { "", "" },
		item = { "", "" },
		hunk = { "", "" },
	},
	kind = "split",
	integrations = {
		diffview = true,
	},
	sections = {
		unpulled = false,
		unmerged = false,
	},
	mappings = {
		["<enter>"] = "",
	},
})
