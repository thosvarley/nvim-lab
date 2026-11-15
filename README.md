# Nvim-Lab

A minimal, explicit Neovim configuration for scientific computing and computational research.

## Philosophy

**Explicit over magic.** Nvim-Lab prioritizes transparency and user control over abstraction. You choose which languages to enable, dependencies are installed via system package managers or language-specific tools (not hidden behind plugin managers), and configuration is readable Lua with minimal indirection.

**Minimal dependencies.** Every plugin serves a clear purpose. No bloat, no redundant features, no tools that solve problems you don't have.

**Built for scientists.** Supports the languages you actually use: Python, R, Julia, Rust, C/C++, and LaTeX. Designed for workflows involving data analysis, scientific computing, and technical writing.

## Features

- **Language Server Protocol (LSP)** support for all major scientific languages, via Neovim's built-in `vim.lsp.config`
- **Configurable language selection** - enable only what you need via `lua/languages.lua`
- **Formatting** with conform.nvim
- **REPL integration** with Iron.nvim for interactive development (IPython, R, Julia, Haskell, Rust, Lua, Octave)
- **LaTeX workflows** with VimTeX (latexmk + zathura) and texlab
- **Git integration** with mini.git and gitsigns
- **Fuzzy finding** with Telescope (plus file-browser and BibTeX extensions)
- **File management** with yazi.nvim, and oil.nvim for editing directories as buffers
- **Tree-sitter** syntax highlighting and indentation
- **Minimal UI** with the mini.nvim suite (completion, snippets, pairs, comments, statusline, tabline, keymap clues) and a scrollbar showing diagnostics, search hits and git changes
- **Claude Code** integration via claude-code.nvim
- **Health check** - `:checkhealth nvim_lab` reports which tools are missing for your enabled languages

## Supported Languages

- **Python**: jedi-language-server + ruff (LSP & formatting), IPython REPL
- **R**: air (LSP & formatting)
- **Julia**: LanguageServer.jl + runic (formatting)
- **Rust**: rust-analyzer + rustfmt
- **C/C++**: clangd + clang-format
- **LaTeX**: texlab + VimTeX + tex-fmt
- **Lua**: lua-language-server + stylua (for Neovim config)
- **Nix**: nixd + nixfmt

Optional: Haskell (haskell-language-server), Octave (REPL and formatting only)

## Installation

### Prerequisites

- Neovim ≥ 0.12 (required by nvim-treesitter's `main` branch)
- Git
- The `tree-sitter` CLI (for building parsers)
- A Nerd Font (for icons)
- Basic build tools (gcc, make) for some dependencies
- Recommended: ripgrep (Telescope live grep), yazi, latexmk + zathura for LaTeX

### Quick Start

```bash
# Back up any existing config, then clone
mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null
git clone https://github.com/thosvarley/nvim-lab.git ~/.config/nvim

# Choose your languages
$EDITOR ~/.config/nvim/lua/languages.lua

# Install language servers, formatters and tools for the enabled languages
~/.config/nvim/install_dependencies.sh

# Start Neovim (lazy.nvim installs plugins on first launch), then verify
nvim +"checkhealth nvim_lab"
```

`install_dependencies.sh` installs what it can (cargo, rustup, uv/pipx, Julia's Pkg) and prints instructions for anything that should come from your system package manager.

## Key Bindings

Leader is `<Space>`.

| Keys | Action |
| --- | --- |
| `<leader>-` / `<leader>cw` | Yazi at current file / working directory |
| `-` | Oil in the current directory |
| `<leader>fb` | Telescope file browser |
| `<leader>fmt` | Format buffer |
| `<leader>rr` / `<leader>rh` / `<leader>rv` | Toggle REPL (default / horizontal / vertical split) |
| `<leader>sl` / `<leader>sc` (visual) | Send line / selection to REPL |
| `<leader>xc` | Run current `# %%` cell in REPL |
| `<leader>xx` | Run file in REPL (Python) / save all (LaTeX) |
| `gd` | Go to definition in a vertical split |
| `gl` / `]d` / `[d` | Line diagnostics / next / previous diagnostic |
| `<leader>ng` | Generate docstring (Neogen) |
| `<leader>t` / `<leader>T` | Horizontal / vertical terminal |
