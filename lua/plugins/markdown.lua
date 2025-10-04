return {
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		run = "cd app && npm install",
		ft = { "markdown" },
		build = function() vim.fn["mkdp#util#install"]() end,
	}
}
