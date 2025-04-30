vim.g.have_nerd_font = true
vim.g.noswapfile = true

-- Simultanious absoute and relative line numbering.
vim.cmd("set number relativenumber")

-- LOOK AND FEEL
vim.cmd("colorscheme catppuccin-mocha")

-- Change the line number color to better match
-- the default and insert mode.
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

-- Change background color depending on mode
-- This was optimized for catppuccin-mocha, if you are using a different background
-- you will need to change #e1e2e to whatever the new background color is.
vim.api.nvim_create_autocmd("ModeChanged", {
	callback = function()
		local mode = vim.fn.mode()
		if mode == "i" then
			vim.cmd("highlight Normal guibg=#262626") -- Insert mode background
		else
			vim.cmd("highlight Normal guibg=#1e1e2e") -- Normal mode background
		end
	end,
})

-- Split behavior
vim.api.nvim_set_hl(0, "VertSplit", { fg = "#66BB6A" })    -- soft purple
vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#66BB6A" }) -- same color for consistency
vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#66BB6A" })
vim.cmd("set laststatus=3")                                -- Makes horizontal split visible. No idea why it works.
vim.o.splitright = true                                    -- Puts new vertical splits on the right side.
vim.o.splitbelow = true                                    -- Puts new horizontal splits on the bottom.

-- Code folding
vim.cmd("set foldmethod=indent")
vim.cmd("set foldcolumn=1")
vim.cmd("au BufRead * normal zR") -- Start file with all folds open.

-- Keybinding to format the file.
vim.keymap.set('n', '<leader>fmt',
	'<cmd>lua vim.lsp.buf.format()<CR>:lua vim.notify("File formatted successfully!")<CR>',
	{ noremap = true, silent = true }
)
-- Keybinding for going to definition
--vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'gd', function()
	vim.cmd('vsplit') -- Opens a vertical split
	vim.lsp.buf.definition()
end, { noremap = true, silent = true })

-- Keybinding for showing hover documentation
vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true })

-- Go to the next diagnostic (error, warning, etc.)
vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', { noremap = true, silent = true })
-- Go to the previous diagnostic (error, warning, etc.)
vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { noremap = true, silent = true })
-- Show diagnostics for the current line (popup window)
vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true })
-- Show all diagnostics in the current buffer
vim.keymap.set('n', '<leader>dl', '<cmd>lua vim.diagnostic.setloclist()<CR>', { noremap = true, silent = true })

-- Keybinding for escaping terminal mode
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]])

-- Keybinding for opening Telescope file_browser
vim.keymap.set('n', '<leader>fb', ':Telescope file_browser<enter>')

-- IronREPL-specific keymaps
vim.keymap.set('n', '<leader>rf', '<cmd>IronFocus<cr>')
vim.keymap.set('n', '<leader>rh', '<cmd>IronHide<cr>')

-- Oil-specific keybindings
vim.keymap.set('n', '-', '<cmd>Oil .<CR>', { silent = true })
