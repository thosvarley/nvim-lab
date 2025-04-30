local actions = require("telescope.actions")
local fb_actions = require("telescope").extensions.file_browser.actions 

require("telescope").setup({
	extensions = {
		file_browser = {
			hidden = true,
			hijack_netrw = false,
			mappings = {
				["i"] = {
				["<leader>c"] = fb_actions.create,
				}
			}
		}
	}
})

require("telescope").load_extension("file_browser")
