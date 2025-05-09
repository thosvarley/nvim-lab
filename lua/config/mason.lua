require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

require("mason-lspconfig").setup({
	ensure_installed = { 
    		'lua_ls',
    		'r_language_server', 
	}
})
--[[
require("mason-lspconfig").setup_handlers {
  function(server_name)
    require("lspconfig")[server_name].setup {
      capabilities = require("cmp_nvim_lsp").default_capabilities()
    }
  end,
}]]--
