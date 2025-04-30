
-- First, set global variables if needed
vim.g.molten_image_provider = "kitty" -- Match this with your image.nvim backend
vim.g.molten_output_win_max_height = 20
vim.g.molten_auto_open_output = true -- Set to false if you don't want output to auto-open

-- Then setup Molten with persistence options
require("molten").setup({
  -- Core persistence settings
  use_border_highlighting = true,
  wrap_output = true,
  
  -- Output window options to ensure visibility
  output_win_options = {
    number = false,
    relativenumber = false,
    signcolumn = "no",
  },
  
  -- Virtual text settings for better visibility
  virtual_text = {
    enabled = true,
  },
  
  -- Cell markers
  cell_markers = {"# %%", "#%%", "# <cell>", "# In\\[\\d*\\]:"},
})
