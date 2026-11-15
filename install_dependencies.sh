#!/usr/bin/env bash
# Nvim-Lab dependency installer.
#
# Installs (or tells you how to install) the external tools for every
# language enabled in lua/languages.lua. Safe to re-run: anything already on
# PATH is skipped. Run `:checkhealth nvim_lab` afterwards to verify.

set -u

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LANG_FILE="$SCRIPT_DIR/lua/languages.lua"
BIN_DIR="$HOME/.local/bin"
mkdir -p "$BIN_DIR"

have() { command -v "$1" &>/dev/null; }

# True if `<name> = true` in languages.lua.
enabled() { grep -Eq "^[[:space:]]*$1[[:space:]]*=[[:space:]]*true" "$LANG_FILE"; }

note() { echo "  -> $*"; }

# Install a Python CLI tool in its own isolated environment. A bare
# `pip install` fails on distros that mark the system Python as
# externally managed (PEP 668).
py_tool() {
	local exe="$1" pkg="$2"
	have "$exe" && return
	if have uv; then
		uv tool install "$pkg"
	elif have pipx; then
		pipx install "$pkg"
	else
		note "$exe not found. Install uv or pipx, then: uv tool install $pkg"
	fi
}

cargo_tool() {
	local exe="$1"
	shift
	have "$exe" && return
	if have cargo; then
		cargo install --locked "$@"
	else
		note "$exe not found and cargo is unavailable. Install Rust (https://rustup.rs), then: cargo install --locked $*"
	fi
}

sys_pkg() {
	local exe="$1" what="$2"
	have "$exe" || note "$exe not found. Install $what with your system package manager."
}

echo "Nvim-Lab Dependency Installer"
echo "=============================="
echo "Languages are read from $LANG_FILE"
echo ""

# ── Core tools ───────────────────────────────────────────────────────────────
echo "Core tools..."
sys_pkg git "git"
cargo_tool tree-sitter tree-sitter-cli # required by nvim-treesitter (main)
sys_pkg rg "ripgrep (used by Telescope live_grep)"
have yazi || note "yazi not found. See https://yazi-rs.github.io/docs/installation"

# ── Python ───────────────────────────────────────────────────────────────────
if enabled python; then
	echo "Python..."
	py_tool jedi-language-server jedi-language-server
	py_tool ruff ruff
	# The iron REPL runs `ipython --profile=iron` and imports matplotlib, so
	# ipython belongs in your project venv alongside your libraries.
	have ipython || note "ipython not found. Install it in your project venv: pip install ipython matplotlib"
fi

# ── Lua ──────────────────────────────────────────────────────────────────────
if enabled lua; then
	echo "Lua..."
	cargo_tool stylua stylua
	if ! have lua-language-server; then
		case "$(uname -m)" in
			x86_64) LUA_LS_ARCH="x64" ;;
			aarch64 | arm64) LUA_LS_ARCH="arm64" ;;
			*) LUA_LS_ARCH="" ;;
		esac
		LUA_LS_VERSION="$(curl -fsSL https://api.github.com/repos/LuaLS/lua-language-server/releases/latest |
			grep -m1 '"tag_name"' | sed -E 's/.*"tag_name": *"([^"]+)".*/\1/')"
		if [ -n "$LUA_LS_ARCH" ] && [ -n "$LUA_LS_VERSION" ]; then
			echo "Installing lua-language-server $LUA_LS_VERSION..."
			TMP="$(mktemp -d)"
			curl -fsSL "https://github.com/LuaLS/lua-language-server/releases/download/${LUA_LS_VERSION}/lua-language-server-${LUA_LS_VERSION}-linux-${LUA_LS_ARCH}.tar.gz" -o "$TMP/lua-ls.tar.gz" &&
				rm -rf "$HOME/.local/lua-language-server" &&
				mkdir -p "$HOME/.local/lua-language-server" &&
				tar -xzf "$TMP/lua-ls.tar.gz" -C "$HOME/.local/lua-language-server" &&
				ln -sf "$HOME/.local/lua-language-server/bin/lua-language-server" "$BIN_DIR/lua-language-server"
			rm -rf "$TMP"
		else
			note "Could not determine lua-language-server release/arch. Download from https://github.com/LuaLS/lua-language-server/releases"
		fi
	fi
fi

# ── R ────────────────────────────────────────────────────────────────────────
if enabled r; then
	echo "R..."
	# air is both the language server and the formatter.
	have air || curl -LsSf https://github.com/posit-dev/air/releases/latest/download/air-installer.sh | sh
	sys_pkg R "R (https://cran.r-project.org)"
fi

# ── Julia ────────────────────────────────────────────────────────────────────
if enabled julia; then
	echo "Julia..."
	if have julia; then
		julia --startup-file=no -e 'using Pkg; haskey(Pkg.project().dependencies, "LanguageServer") || Pkg.add("LanguageServer")'
		have runic || {
			julia --project=@runic --startup-file=no -e 'using Pkg; Pkg.add("Runic")' &&
				curl -fsSL -o "$BIN_DIR/runic" https://raw.githubusercontent.com/fredrikekre/Runic.jl/refs/heads/master/bin/runic &&
				chmod +x "$BIN_DIR/runic" &&
				curl -fsSL -o "$BIN_DIR/git-runic" https://raw.githubusercontent.com/fredrikekre/Runic.jl/refs/heads/master/bin/git-runic &&
				chmod +x "$BIN_DIR/git-runic"
		}
	else
		note "julia not found. Install from https://julialang.org/downloads/, then re-run this script."
	fi
fi

# ── Rust ─────────────────────────────────────────────────────────────────────
if enabled rust; then
	echo "Rust..."
	if have rustup; then
		have rust-analyzer || rustup component add rust-analyzer
		have rustfmt || rustup component add rustfmt
	else
		note "rustup not found. Install Rust from https://rustup.rs"
	fi
	cargo_tool evcxr evcxr_repl # optional REPL for iron.nvim
fi

# ── C/C++ ────────────────────────────────────────────────────────────────────
if enabled c_cpp; then
	echo "C/C++..."
	sys_pkg clangd "clangd (Arch: clang, Ubuntu: clangd)"
	sys_pkg clang-format "clang-format (Arch: clang, Ubuntu: clang-format)"
fi

# ── LaTeX ────────────────────────────────────────────────────────────────────
if enabled latex; then
	echo "LaTeX..."
	have texlab || {
		if have cargo; then
			cargo install --locked --git https://github.com/latex-lsp/texlab
		else
			note "texlab not found. Install Rust, then: cargo install --locked --git https://github.com/latex-lsp/texlab"
		fi
	}
	cargo_tool tex-fmt tex-fmt
	sys_pkg latexmk "latexmk (part of TeX Live)"
	sys_pkg zathura "zathura (PDF viewer used by VimTeX)"
fi

# ── Haskell ──────────────────────────────────────────────────────────────────
if enabled haskell; then
	echo "Haskell..."
	if ! have haskell-language-server-wrapper || ! have ghci; then
		note "Install GHC and HLS with ghcup (https://www.haskell.org/ghcup/):"
		note "  ghcup install ghc --set recommended"
		note "  ghcup install hls --set recommended"
	fi
fi

# ── Octave ───────────────────────────────────────────────────────────────────
if enabled octave; then
	echo "Octave..."
	sys_pkg octave "GNU Octave"
	py_tool mh_style miss-hit
fi

# ── Nix ──────────────────────────────────────────────────────────────────────
if enabled nix; then
	echo "Nix..."
	for exe in nixd nixfmt; do
		have "$exe" || note "$exe not found. Add it to environment.systemPackages, or: nix profile install nixpkgs#$exe"
	done
fi

echo ""
echo "Done. Run :checkhealth nvim_lab inside Neovim to verify."
case ":$PATH:" in
	*":$BIN_DIR:"*) ;;
	*) echo "Note: $BIN_DIR is not on your PATH; add it so installed tools are found." ;;
esac
