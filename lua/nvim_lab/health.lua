local M = {}

local ok = vim.health.ok
local warn = vim.health.warn
local error = vim.health.error
local start = vim.health.start

local function check(executable, label, install_hint, required)
	if vim.fn.executable(executable) == 1 then
		ok(label .. ": found")
	elseif required == false then
		warn(label .. ": not found", { install_hint })
	else
		error(label .. ": not found", { install_hint })
	end
end

M.check = function()
	local languages = require("languages")

	-- ── Requirements ──────────────────────────────────────────────────────────
	start("nvim-lab: requirements")

	if vim.fn.has("nvim-0.11") == 1 then
		ok("Neovim >= 0.11")
	else
		error("Neovim >= 0.11 required", { "Update Neovim: https://github.com/neovim/neovim/releases" })
	end

	check("git", "git", "Install git via your system package manager", true)

	-- ── Python ────────────────────────────────────────────────────────────────
	if languages.python then
		start("nvim-lab: Python")
		check(
			"jedi-language-server",
			"jedi-language-server (LSP)",
			"pip install jedi-language-server — ensure your venv is active when nvim starts"
		)
		check(
			"ruff",
			"ruff (LSP + formatter)",
			"pip install ruff — ensure your venv is active when nvim starts"
		)
		check(
			"ipython",
			"ipython (iron.nvim REPL)",
			"pip install ipython — ensure your venv is active when nvim starts"
		)
	end

	-- ── Lua ───────────────────────────────────────────────────────────────────
	if languages.lua then
		start("nvim-lab: Lua")
		check(
			"lua-language-server",
			"lua-language-server (LSP)",
			"Run install_dependencies.sh, or download from https://github.com/LuaLS/lua-language-server/releases"
		)
		check(
			"stylua",
			"stylua (formatter)",
			"cargo install stylua"
		)
	end

	-- ── R ─────────────────────────────────────────────────────────────────────
	if languages.r then
		start("nvim-lab: R")
		check(
			"air",
			"air (LSP + formatter)",
			"curl -LsSf https://github.com/posit-dev/air/releases/latest/download/air-installer.sh | sh"
		)
		check(
			"R",
			"R (iron.nvim REPL)",
			"Install R via your system package manager or https://cran.r-project.org"
		)
	end

	-- ── Julia ─────────────────────────────────────────────────────────────────
	if languages.julia then
		start("nvim-lab: Julia")
		check(
			"julia",
			"julia (LSP + iron.nvim REPL)",
			"Install from https://julialang.org/downloads/"
		)
		-- LanguageServer.jl: julia must be runnable; the package check is best-effort
		if vim.fn.executable("julia") == 1 then
			local result = vim.fn.system(
				"julia --startup-file=no -e 'using Pkg; haskey(Pkg.project().dependencies, \"LanguageServer\") ? exit(0) : exit(1)'"
			)
			if vim.v.shell_error == 0 then
				ok("LanguageServer.jl: installed")
			else
				warn("LanguageServer.jl: not found in default project", {
					"julia --startup-file=no -e 'using Pkg; Pkg.add(\"LanguageServer\")'"
				})
			end
		end
		check(
			"runic",
			"runic (formatter)",
			"See https://github.com/fredrikekre/Runic.jl — or run install_dependencies.sh",
			false -- warn only; formatter is optional
		)
	end

	-- ── Rust ──────────────────────────────────────────────────────────────────
	if languages.rust then
		start("nvim-lab: Rust")
		check(
			"rust-analyzer",
			"rust-analyzer (LSP)",
			"rustup component add rust-analyzer"
		)
		check(
			"rustfmt",
			"rustfmt (formatter)",
			"rustup component add rustfmt"
		)
		check(
			"evcxr",
			"evcxr (iron.nvim REPL)",
			"cargo install evcxr_repl",
			false -- warn only; REPL is optional
		)
	end

	-- ── C/C++ ─────────────────────────────────────────────────────────────────
	if languages.c_cpp then
		start("nvim-lab: C/C++")
		check(
			"clangd",
			"clangd (LSP)",
			"Install clang/clangd via your system package manager (apt install clangd / pacman -S clang)"
		)
		check(
			"clang-format",
			"clang-format (formatter)",
			"Install clang/clangd via your system package manager (apt install clang-format / pacman -S clang)"
		)
	end

	-- ── LaTeX ─────────────────────────────────────────────────────────────────
	if languages.latex then
		start("nvim-lab: LaTeX")
		check(
			"texlab",
			"texlab (LSP)",
			"cargo install --git https://github.com/latex-lsp/texlab --locked"
		)
		check(
			"tex-fmt",
			"tex-fmt (formatter)",
			"cargo install tex-fmt"
		)
	end

	-- ── Haskell ───────────────────────────────────────────────────────────────
	if languages.haskell then
		start("nvim-lab: Haskell")
		check(
			"haskell-language-server-wrapper",
			"haskell-language-server (LSP)",
			"ghcup install hls --set recommended"
		)
		check(
			"ghci",
			"ghci (iron.nvim REPL)",
			"ghcup install ghc --set recommended"
		)
	end

	-- ── Octave ────────────────────────────────────────────────────────────────
	if languages.octave then
		start("nvim-lab: Octave")
		check(
			"octave",
			"octave (iron.nvim REPL)",
			"Install GNU Octave via your system package manager"
		)
		check(
			"mh_style",
			"mh_style (formatter)",
			"pip install miss-hit"
		)
	end
end

return M
