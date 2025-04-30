# NVim-Lab: Neovim for Scientists

[Splash](images/splash.png)

*Hint: You can read this as a markdown by running ``:MarkdownPreview`` in NVim-Lab.*

NVim-Lab is a [Neovim](https://github.com/neovim/neovim) configuration and curated plugin selection designed to make Neovim an effective and efficient environment for scientists inside and outside of Academia. NVim-Lab has utilities for coding, data analysis, and manuscript preparation, as well as supporting the three major scientific programming languages: Python, Julia, and R (it also supports Rust and Haskell, for the real nerds).

### Features

[Iron repl in action](images/ironrepl.png) 

#### Support for multiple languages 
Using Neovim's native support for [LSP](https://github.com/neovim/nvim-lspconfig) (language-server protocol), NVim-Lab has been configured to support: Python, Julia, R, Rust, and Haskell, as well as Lua to help with further customization and personalization. Language support includes: syntax highlighting, formatting, and (light) linting. The [cmp.nvim](https://github.com/hrsh7th/nvim-cmp) plugin provides code-completion and suggestion support for all of the included languages. 

While I have tried to make Nvim-Lab as functional "out of the box" as possible, for the LSPs, you need to have the language servers for the respective languages already installed: 

**Python**: Install the Python language server using pip with:

``pip install python-lsp-server``

**Julia**: The Julia language server should run "out of the box."

**R**: The R language server must be installed with (if you installed R via a distro repository, you will have to``sudo`` this command):

``R -e "install.packages('languageserver', repos='https://cran.rstudio.com/')"`` 

I assume that the kind of people planning to use Rust and/or Haskell can probably get their respective LSPs installed and configured on their own. 

#### Jupyter Notebooks
Working with Jupyter Notebooks in a text editor is tricky, and this is an area of active development still. Nvim-Lab supports the [Molten.nvim](https://github.com/benlubas/molten-nvim) plugin, which connects the Nvim buffer to a Jupyter kernel, allowing for inline-plotting and read-outs. This requires you to be using a Terminal that has image support: I use [Wezterm](https://wezterm.org/), and NVim-Lab has been configured for that terminal, although alternatives like [Kitty](https://sw.kovidgoyal.net/kitty/) should work effectively out-of-the-box as well, with minimal configuration. In addition to Molten, Nvim-Lab also support [Jupytext](https://github.com/GCBallesteros/jupytext.nvim), which allows you to open .ipynb files as elegantly formatted plaintext documents. Combine with Molten for a near-perfect within-neovim notebook experience. (Requires the [Jupytext](https://github.com/mwouts/jupytext) source package). 

#### Integrated REPLs
As an alternative to Notebooks, NVim-Lab supports integrated, within-buffer REPLs via the [iron.nvim](https://github.com/Vigemus/iron.nvim) plugin. This re-creates the experience of using an IDE like Spyder or R-studio: one can have a script open in one Neovim pane, and a REPL open in another, and easily send code back and forth between them. 

#### LaTeX and Markdown Support 
Using the [VimTex](https://github.com/lervag/vimtex) plugin, as well as the [cmp-vimtex](https://github.com/micangl/cmp-vimtex) extension, NVim-Lab has first-class support for LaTex, including syntax highlighting, code completion, and a compiler. One of the best features of VimTex is an attached PDF-viewer, the recreate the experience provided by Overleaf or TexStudio. Every time you save a .tex source file with ``:wa``, the linked Zathura PDF viewer will update the compiled document, giving real-time feedback on how the formatted manuscript looks. 

NVim-Lab also includes a variety of pre-defined LaTeX [snips](https://github.com/L3MON4D3/LuaSnip) (automatically inserting typsetting boilerplate for things like equations. You can also add your own snips.

For those that prefer Markdown, the [Markdown Preview](https://github.com/iamcco/markdown-preview.nvim) plugin allows real-time previewing of a Markdown file as you write it in a browser. To use the Markdown visualization features, you will need ``node.js`` and ``npm``, and it builds itself locally using ``cd app && npm install``.

Finally, bibtex integration (which comes native with VimTex) is augmented by the [telescope-bibtex](telescope-bibtex) plugin, which makes locally-saved .bib files searchable with the [Telescope](https://github.com/nvim-telescope/telescope.nvim) plugin.

#### Git integration 
Git integration is provided by [vim-fugitive](https://github.com/tpope/vim-fugitive).


### Utilities

Utilities are plugins that make NVim-Lab more like a fully-featured IDE.

#### File Browsers
Nvim-Lab comes with two installed file browsers: 
* The [Telescope file browser](https://github.com/nvim-telescope/telescope-file-browser.nvim); a flat file browser (i.e. no tree-like structure) that opens in a floating window and provides a preview of the files as you navigate the directory. You can start it with the command ``:Telescope file browser`` or the keybinding ``<leader>fb`` in Normal mode. You can create new directories, files, etc, all from within Neovim. When in insert mode within the browser, the ``<leader>c`` command will prompt the creation of a new file or directory. 
* The [Oil](https://github.com/stevearc/oil.nvim) file browser is a more lightweight option that treats directories as if they were text files within the buffer. You can create, delete, rename, etc. files and directories al from within the Neovim setup. You can open it in Normal mode with the command ``:Oil .``, or with the keybinding ``-``. 

#### Tmux Integration
Nvim-Lab comes with the [Tmux Navigator](https://github.com/alexghergh/nvim-tmux-navigation) plugin, which allows for seamless integration of Neovim splits with Tmux windows. For heavy users of SSH (e.g. using remote HPC clusters), this can drastically improve the workflow. 

#### Look and feel 
NVim-Lab uses the [Catppuccin-mocha](https://catppuccin.com/) theme, although it has several others. By default, a feature is enabled that changes the background color in response to the mode Nvim is in (dark blue in normal mode, dark grey in insert mode). This is designed to give additional sensory feedback about what mode Nvim is in. 

The [Lualine](https://github.com/nvim-lualine/lualine.nvim) is also included, for additional information. 


