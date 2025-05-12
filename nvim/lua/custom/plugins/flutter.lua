-- Flutter development tools
return {
	'akinsho/flutter-tools.nvim',
	ft = { "dart" },  -- Only load when editing dart files
	cmd = {  -- Load when these commands are called
		"FlutterRun",
		"FlutterDevices",
		"FlutterEmulators",
		"FlutterHotReload",
		"FlutterHotRestart",
		"FlutterQuit",
		"FlutterDetach"
	},
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
