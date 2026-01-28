#!/bin/bash

# Helper function for consistent checking
check_installed() {
    command -v "$1" &>/dev/null
}

# Read language configuration
# Simple approach: just check all and let user decide what to install
echo "Nvim-Lab Dependency Installer"
echo "=============================="
echo ""
echo "Edit ~/.config/nvim/lua/languages.lua to enable/disable languages"
echo ""

# Or for a more sophisticated approach, parse the Lua file
# (but that's complex - simpler to just install what's missing)

# Formatters
echo "Installing formatters..."

# Lua
check_installed stylua || cargo install stylua

# R
check_installed air || curl -LsSf https://github.com/posit-dev/air/releases/latest/download/air-installer.sh | sh

# LaTeX
check_installed tex-fmt || cargo install tex-fmt

# Julia
check_installed runic || {
    julia --project=@runic --startup-file=no -e 'using Pkg; Pkg.add("Runic")' &&
    curl -fsSL -o ~/.local/bin/runic https://raw.githubusercontent.com/fredrikekre/Runic.jl/refs/heads/master/bin/runic &&
    chmod +x ~/.local/bin/runic &&
    curl -fsSL -o ~/.local/bin/git-runic https://raw.githubusercontent.com/fredrikekre/Runic.jl/refs/heads/master/bin/git-runic &&
    chmod +x ~/.local/bin/git-runic
}

# MATLAB/Octave
check_installed mh_style || pip install miss-hit

# C/C++
if ! check_installed clang-format; then
    echo "clang-format not found. Install with your system package manager:"
    echo "  Arch:   sudo pacman -S clang"
    echo "  Ubuntu: sudo apt install clang-format"
fi

# Tree-sitter CLI
check_installed tree-sitter || cargo install --lock tree-sitter-cli

echo ""
echo "Installing language servers..."

# Python
check_installed jedi-language-server || pip install jedi-language-server
check_installed ruff || pip install ruff

# Lua language server
if ! check_installed lua-language-server; then
    echo "Installing lua-language-server..."
    LUA_LS_VERSION="3.7.4"
    curl -L "https://github.com/LuaLS/lua-language-server/releases/download/${LUA_LS_VERSION}/lua-language-server-${LUA_LS_VERSION}-linux-x64.tar.gz" -o /tmp/lua-ls.tar.gz
    mkdir -p ~/.local/lua-language-server
    tar -xzf /tmp/lua-ls.tar.gz -C ~/.local/lua-language-server
    ln -sf ~/.local/lua-language-server/bin/lua-language-server ~/.local/bin/lua-language-server
    rm /tmp/lua-ls.tar.gz
fi

# Rust
if ! check_installed rust-analyzer; then
	echo "rust-analyzer not found. Installing..."
    echo "Installing rust-analyzer..."
    rustup component add rust-analyzer
fi

# LaTeX
if ! check_installed texlab; then
    echo "texlab not found. Installing..."
    cargo install --git https://github.com/latex-lsp/texlab --locked
fi

# R language server (air handles both LSP and formatting)
# Already installed above

# C/C++
if ! check_installed clangd; then
    echo "clangd not found. Install with your system package manager:"
    echo "  Arch:   sudo pacman -S clang"
    echo "  Ubuntu: sudo apt install clangd"
fi

# Julia LanguageServer
julia --startup-file=no -e 'using Pkg; "LanguageServer" in keys(Pkg.project().dependencies) || Pkg.add("LanguageServer")'

# Haskell (optional - only if enabled)
if ! check_installed haskell-language-server-wrapper; then
    echo ""
    echo "Haskell language server not found (optional)."
    echo "If you want Haskell support, install with:"
    echo "  ghcup install ghc --set recommended"
    echo "  ghcup install hls --set recommended"
fi

echo ""
echo "Installation complete!"
echo "Edit ~/.config/nvim/lua/languages.lua to enable/disable languages"
