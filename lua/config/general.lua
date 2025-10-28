---@diagnostic disable: undefined-global
---
-- Simultanious absoute and relative line numbering.
vim.cmd("set number relativenumber")

-- Text wrapping and linebreaking
-- Enable linebreak for Markdown and LaTeX files
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown", "tex" },
	callback = function()
		vim.opt_local.linebreak = true -- only for this buffer
		vim.opt_local.wrap = true -- you might want wrap too
	end,
})

-- Disable linebreak for everything else (optional)
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "*" },
	callback = function()
		if not vim.tbl_contains({ "markdown", "tex" }, vim.bo.filetype) then
			vim.opt_local.linebreak = false
			vim.opt_local.wrap = false
		end
	end,
})

-- Colorscheme
vim.cmd.colorscheme "kanagawa-paper"

vim.cmd("highlight LineNr guifg=#a0a0a0")

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

vim.api.nvim_set_hl(0, "VertSplit", { fg = "#66BB6A" })    -- soft vivid green
vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#66BB6A" }) -- same color for consistency
vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#66BB6A" })
vim.cmd("set laststatus=3")                                -- Makes horizontal split visible. No idea why it works.
vim.o.splitright = true                                    -- Puts new vertical splits on the right side.
vim.o.splitbelow = true                                    -- Puts new horizontal splits on the bottom.

-- Code folding
vim.cmd("set foldmethod=indent")
vim.cmd("set foldcolumn=1")
vim.cmd("au BufRead * normal zR") -- Start file with all folds open.

-- Iron keymaps
vim.keymap.set('n', '<leader>xx', '<cmd>IronRunCurrent<cr>')
vim.keymap.set('n', '<leader>xc', '<cmd>IronRunCell<cr>')
