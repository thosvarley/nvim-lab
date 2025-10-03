-- Various navigation utilities
-- Open Oil in current directory.
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open Oil in current directory" })

-- Toggle NvimTree 
vim.keymap.set("n", "<leader>e", "<CMD>NvimTreeToggle<CR>", { desc = "Toggle File Explorer (nvim-tree)" })

-- Open Telescope file browser
vim.keymap.set("n", "<leader>fb", "<CMD>Telescope file_browser<CR>", { desc = "Toggle Nvim Tree Sidebar" })

-- Keybinding to format the file.
vim.keymap.set('n', '<leader>fmt',
	'<cmd>lua vim.lsp.buf.format()<CR>:lua vim.notify("File formatted successfully!")<CR>',
	{ noremap = true, silent = true }
)

-- Iron-specific keybindings
vim.keymap.set('n', '<leader>xx', '<cmd>IronRunCurrent<cr>')
vim.keymap.set('n', '<leader>xc', '<cmd>IronRunCell<cr>')

vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]]) -- Keybinding for escaping terminal mode

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

-- Molten Keymaps
vim.keymap.set("n", "<localleader>mi", ":MoltenInit<CR>", { silent = true, desc = "Initialize Molten" })
vim.keymap.set("n", "<localleader>e", ":MoltenEvaluateOperator<CR>", { silent = true, desc = "Evaluate operator" })
vim.keymap.set("n", "<localleader>rl", ":MoltenEvaluateLine<CR>", { silent = true, desc = "Evaluate line" })
vim.keymap.set("v", "<localleader>r", ":<C-u>MoltenEvaluateVisual<CR>gv", { silent = true, desc = "Evaluate visual" })
vim.keymap.set("n", "<localleader>r", "vip:MoltenEvaluateVisual<CR>", { silent = true, desc = "Evaluate cell" })
