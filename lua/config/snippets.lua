local cmp = require('cmp')
local luasnip = require('luasnip')

-- Load friendly-snippets
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
  }
})

-- Configure LaTeX-specific settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = "tex",
  callback = function()
    -- Add vimtex as a source for LaTeX files
    cmp.setup.buffer({
      sources = {
        { name = 'vimtex' },
        { name = 'luasnip' },
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' },
      }
    })
  end
})

-- Configure Python-specific settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    -- Python-specific completions
    cmp.setup.buffer({
      sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'path' },
      }
    })
  end
})

-- DEFINING SNIPPETS
-- Define a custom  snippet for LaTeX
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

-- Add the custom align snippet to the 'tex' filetype
ls.add_snippets("tex", {
  s("align", {
    t("\\begin{align}"),
    t({"", "\t"}), i(1), t(" = "), i(2),
    t({"", "\\end{align}"}),
    i(0)
  })
})

-- Add the custom sum snippet to the 'tex' filetype
ls.add_snippets("tex", {
	s("nsum", {
		t("\\sum_{i=1}^{N}"),
	})
})


-- Create a namespace for our snippet highlights
local snippet_highlight_ns = vim.api.nvim_create_namespace("snippet_highlight")
local highlight_timer = nil

-- Function to check and highlight valid snippet triggers
local function check_snippet_trigger()
  -- Clear any existing highlight first
  vim.api.nvim_buf_clear_namespace(0, snippet_highlight_ns, 0, -1)
  
  -- Get cursor position and line text
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  local line = vim.api.nvim_get_current_line()
  local col = cursor_pos[2]
  
  -- Extract word before cursor that could be a trigger
  local word_before_cursor = line:sub(1, col):match("%S+$") or ""
  
  if word_before_cursor == "" then return end
  
  -- Check if this word is a valid snippet trigger
  local ft = vim.bo.filetype
  local snippets = require("luasnip").get_snippets(ft)
  
  if not snippets then return end
  
  for _, snippet in ipairs(snippets) do
    if snippet.trigger == word_before_cursor then
      -- Word is a valid trigger, highlight it
      local word_start = col - #word_before_cursor + 1
      local row = cursor_pos[1] - 1  -- API uses 0-indexed rows
      
      vim.api.nvim_buf_add_highlight(
        0, 
        snippet_highlight_ns, 
        "DiagnosticInfo", -- A soft blue highlight that's visible but not distracting
        row, 
        word_start - 1, 
        col
      )
      
      -- Clear the highlight after a short delay
      if highlight_timer then
        vim.fn.timer_stop(highlight_timer)
      end
      
      highlight_timer = vim.fn.timer_start(800, function()
        vim.api.nvim_buf_clear_namespace(0, snippet_highlight_ns, 0, -1)
      end)
      
      break
    end
  end
end

-- Create autocommands to trigger the check
vim.api.nvim_create_autocmd({"TextChangedI", "CursorMovedI"}, {
  callback = function()
    -- Debounce to avoid excessive checks
    if highlight_timer then
      vim.fn.timer_stop(highlight_timer)
    end
    
    highlight_timer = vim.fn.timer_start(100, function()
      check_snippet_trigger()
    end)
  end
})

-- Clear highlights when leaving insert mode
vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    vim.api.nvim_buf_clear_namespace(0, snippet_highlight_ns, 0, -1)
    if highlight_timer then
      vim.fn.timer_stop(highlight_timer)
      highlight_timer = nil
    end
  end
})

-- Add this before the autocommands
vim.api.nvim_set_hl(0, "SnippetTrigger", { bg = "#3a5472", fg = "#ffffff", bold = true })

-- Then use "SnippetTrigger" instead of "DiagnosticInfo" in the highlight function

