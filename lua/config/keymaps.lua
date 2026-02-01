
-- FILE BROWSERS
-- Open Oil in current directory.
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open Oil in current directory" })
-- Open Mini.Files browser.
vim.keymap.set("n", "<Leader>mf", function()
	MiniFiles.open()
end, { desc = "Open Mini.Files" })
-- Open Telescope file browser
vim.keymap.set("n", "<leader>fb", "<CMD>Telescope file_browser<CR>", { desc = "Toggle Nvim Tree Sidebar" })

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


-- Tab to navigate completion menu
vim.keymap.set('i', '<Tab>', [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true })
vim.keymap.set('i', '<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { expr = true })
