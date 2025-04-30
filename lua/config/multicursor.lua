local mc = require("multicursor-nvim")
mc.setup()

vim.keymap.set({"n", "v"}, "<leader><up>", function() mc.lineAddCursor(-1) end)
vim.keymap.set({"n", "v"}, "<leader><down>", function() mc.lineAddCursor(1) end)

-- Add or skip adding a new cursor by matching word/selection
vim.keymap.set({"n", "v"}, "<leader>mn", function() mc.matchAddCursor(1) end)
vim.keymap.set({"n", "v"}, "<leader>ms", function() mc.matchSkipCursor(1) end)
vim.keymap.set({"n", "v"}, "<leader>mN", function() mc.matchAddCursor(-1) end)
vim.keymap.set({"n", "v"}, "<leader>mS", function() mc.matchSkipCursor(-1) end)

-- Add all matches in the document
vim.keymap.set({"n", "v"}, "<leader>mA", mc.matchAllAddCursors)

-- Rotate the main cursor
vim.keymap.set({"n", "v"}, "<leader><left>", mc.prevCursor)
vim.keymap.set({"n", "v"}, "<leader><right>", mc.nextCursor)

-- Delete the main cursor
vim.keymap.set({"n", "v"}, "<leader>x", mc.deleteCursor)

-- Exit multicursor mode with <esc>
vim.keymap.set("n", "<esc>", function()
  if not mc.cursorsEnabled() then
    mc.enableCursors()
  elseif mc.hasCursors() then
    mc.clearCursors()
  else
    -- Default <esc> handler
  end
end)

-- Append/insert for each line of visual selections
vim.keymap.set("v", "I", mc.insertVisual)
vim.keymap.set("v", "A", mc.appendVisual)


-- Rotate visual selection contents
vim.keymap.set("v", "<leader>t", function() mc.transposeCursors(1) end)
vim.keymap.set("v", "<leader>T", function() mc.transposeCursors(-1) end)

-- Jumplist support
vim.keymap.set({"v", "n"}, "<c-i>", mc.jumpForward)
vim.keymap.set({"v", "n"}, "<c-o>", mc.jumpBackward)

-- Customize cursor appearance
local hl = vim.api.nvim_set_hl
hl(0, "MultiCursorCursor", { link = "Cursor" })
hl(0, "MultiCursorVisual", { link = "Visual" })
hl(0, "MultiCursorSign", { link = "SignColumn" })
hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
