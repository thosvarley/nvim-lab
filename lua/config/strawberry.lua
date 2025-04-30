local strawberry = require("modules.strawberry")

vim.keymap.set("n", "<leader>mp", strawberry.play_pause)
vim.keymap.set("n", "<leader>mn", strawberry.next)
vim.keymap.set("n", "<leader>mr", strawberry.prev)
vim.keymap.set("n", "<leader>ms", strawberry.show_status, { desc = "Show Strawberry status" })
