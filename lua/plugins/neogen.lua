return {
	{
		"danymat/neogen",
		config = function()
			require('neogen').setup {
				enabled = true,
				languages = {
					python = {
						template = {
							annotation_convention = "numpydoc"
						}
					},
				}
			}
		end

		-- Uncomment next line if you want to follow only stable versions
		-- version = "*"

	}
}
