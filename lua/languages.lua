-- ~/.config/nvim/lua/languages.lua
-- Language selection for Nvim-Lab
-- Set languages to true to enable LSP, formatting, and installation
-- Set to false to disable

return {
	-- Core scientific computing languages
	python = true,
	r = true,
	julia = true,

	-- Systems programming
	rust = true,
	c_cpp = true,

	-- Document preparation
	latex = true,

	-- Neovim configuration
	lua = true,

	-- Optional languages (disabled by default)
	haskell = true,
	octave = false,
}
