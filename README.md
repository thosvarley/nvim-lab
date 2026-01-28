# Nvim-Lab

A minimal, explicit Neovim configuration for scientific computing and computational research.

## Philosophy

**Explicit over magic.** Nvim-Lab prioritizes transparency and user control over abstraction. You choose which languages to enable, dependencies are installed via system package managers or language-specific tools (not hidden behind plugin managers), and configuration is readable Lua with minimal indirection.

**Minimal dependencies.** Every plugin serves a clear purpose. No bloat, no redundant features, no tools that solve problems you don't have.

**Built for scientists.** Supports the languages you actually use: Python, R, Julia, Rust, C/C++, and LaTeX. Designed for workflows involving data analysis, scientific computing, and technical writing.

## Features

- **Language Server Protocol (LSP)** support for all major scientific languages
- **Configurable language selection** - enable only what you need via `lua/languages.lua`
- **Formatting** with conform.nvim
- **REPL integration** with Iron.nvim for interactive development
- **LaTeX workflows** with VimTeX and texlab
- **Git integration** with mini.git
- **Fuzzy finding** with Telescope
- **Tree-sitter** syntax highlighting
- **Minimal UI** with mini.nvim suite (completion, comments, statusline, tabline)

## Supported Languages

- **Python**: jedi-language-server + ruff (LSP & formatting)
- **R**: air (LSP & formatting)
- **Julia**: LanguageServer.jl + runic (formatting)
- **Rust**: rust-analyzer + rustfmt
- **C/C++**: clangd + clang-format
- **LaTeX**: texlab + VimTeX + tex-fmt
- **Lua**: lua-language-server + stylua (for Neovim config)

Optional: Haskell (haskell-language-server), Octave (formatting only)

## Installation

### Prerequisites

- Neovim ≥ 0.10
- Git
- A Nerd Font (for icons)
- Basic build tools (gcc, make) for some dependencies

### Quick Start
```bash
