-- Simultanious absoute and relative line numbering.
vim.cmd("set number relativenumber")

vim.o.lazyredraw = true

-- Colorscheme
vim.cmd.colorscheme "kanagawa-paper"

-- Text wrapping and linebreaking
-- Enable linebreak for Markdown and LaTeX files
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown", "tex" },
	callback = function()
		vim.opt_local.linebreak = true -- only for this buffer
		vim.opt_local.spell = true -- automatic spell check.
	end,
})

-- Highlights the cursor line when entering insert mode.
vim.api.nvim_create_autocmd("InsertEnter", {
	callback = function()
		vim.cmd("set cursorline")
	end,
})
-- Removes cursor highlighting when leaving insert mode.
vim.api.nvim_create_autocmd("InsertLeave", {
	callback = function()
		vim.cmd("set nocursorline")
	end,
})

