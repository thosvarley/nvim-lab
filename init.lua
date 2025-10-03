require("config.splash").show()
require("config.lazy")
require("config.general")
require("config.options")
require("config.keymaps")


require("telescope").load_extension("file_browser")
require("nvim-tree").setup({})

vim.g.vimtex_quickfix_mode = 2  -- use chktex for lintin
