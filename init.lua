require("config.lazy")
require("config.general")  -- General settings and keybindings
require("config.lsp")      -- LSP and Pyright setup
require("config.ironrepl") -- IronREPL setup
require("config.snippets") -- Multicursor setup
require("config.lualine")
require("config.mason")
require("config.multicursor")
require("config.telescope")
require("config.treesitter")
require("config.oil")

-- Language
local langs = require("langs")

for _, lang in ipairs(langs) do
	local ok, _ = pcall(require, "config.langs." .. lang)
	if not ok then
		vim.notify("Failed to load LSP for " .. lang, vim.log.levels.WARN)
	end
end

require("config.splash").show()
