return {
	{
		"danymat/neogen",
		lazy = true,
		cmd = "Neogen",
		config = function()
			require("neogen").setup({
				enabled = true,
				languages = {
					python = {
						template = {
							annotation_convention = "numpydoc",
						},
					},
				},
			})
		end,
	},
}

