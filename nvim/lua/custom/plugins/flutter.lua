-- Flutter development tools
return {
	'akinsho/flutter-tools.nvim',
	lazy = false,
	dependencies = {
		'nvim-lua/plenary.nvim',
		'stevearc/dressing.nvim', -- optional for vim.ui.select
	},
	config = function()
		require("flutter-tools").setup {
			lsp = {
				cmd = { "/usr/bin/dart", "language-server", "--protocol=lsp" },
			},
		}
	end
}
