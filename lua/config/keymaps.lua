
-- FILE BROWSERS
-- Open Oil in current directory.
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open Oil in current directory" })
-- Open Telescope file browser
vim.keymap.set("n", "<leader>fb", "<CMD>Telescope file_browser<CR>", { desc = "Open Telescope file browser" })

-- Neogen docstrings
vim.keymap.set("n", "<Leader>ng", "<CMD>Neogen<CR>", { desc = "Generate Neogen docstring" })

-- Iron-specific keybindings
vim.keymap.set('n', '<leader>xx', '<cmd>IronRunCurrent<cr>', { desc = "Run current file in REPL" })
vim.keymap.set('n', '<leader>xc', '<cmd>IronRunCell<cr>', { desc = "Run current cell in REPL" })

-- Terminal keymaps
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]]) -- Keybinding for escaping terminal mode
vim.keymap.set("n", "<leader>T", "<cmd>vsplit | terminal<cr>", { desc = "Vertical terminal" })
vim.keymap.set("n", "<leader>t", "<cmd>split | terminal<cr>", { desc = "Horizontal terminal" })

-- Documentation and hints 
-- Keybinding for going to definition
vim.keymap.set('n', 'gd', function()
	vim.cmd('vsplit') -- Opens a vertical split
	vim.lsp.buf.definition()
end, { desc = "Open definition in new pane", noremap = true, silent = true })

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


-- Keybinding for changing background color (works well with gruvbox color scheme)
vim.keymap.set('n',  '<leader>bd', ':set background=dark<enter>')
vim.keymap.set('n',  '<leader>bl', ':set background=light<enter>')


-- Tab: cycle the completion popup, else jump to the next snippet tabstop
-- (e.g. between a function call's arguments), else insert a literal tab.
vim.keymap.set('i', '<Tab>', function()
	if vim.fn.pumvisible() == 1 then
		return vim.api.nvim_replace_termcodes('<C-n>', true, true, true)
	end
	if MiniSnippets.session.get() ~= nil then
		MiniSnippets.session.jump('next')
		return ''
	end
	return vim.api.nvim_replace_termcodes('<Tab>', true, true, true)
end, { expr = true })
vim.keymap.set('i', '<S-Tab>', function()
	if vim.fn.pumvisible() == 1 then
		return vim.api.nvim_replace_termcodes('<C-p>', true, true, true)
	end
	if MiniSnippets.session.get() ~= nil then
		MiniSnippets.session.jump('prev')
		return ''
	end
	return vim.api.nvim_replace_termcodes('<S-Tab>', true, true, true)
end, { expr = true })
-- Confirm the selected completion item (mini.completion only swaps in the
-- real insert/snippet text on explicit confirm; without this, Tab-selecting
-- and continuing to type leaves the item's raw label in the buffer).
vim.keymap.set('i', '<CR>', function()
	if vim.fn.complete_info()['selected'] ~= -1 then
		return '\25' -- <C-y>, accept selected item
	end
	return '\r'
end, { expr = true })
