-- Main initialization module that loads all other modules

local M = {}

function M.setup()
	-- Load core options first (includes leader key setup which must happen before plugins)
	require('core.options').setup()

	-- Load plugins
	require('core.plugins').setup()

	-- Load theme
	require('core.theme').setup()
	require('core.theme').setup_tab_autocmds()

	-- Load LSP configuration
	require('core.lsp').setup()
	-- setup_completion is now handled by the custom nvim-cmp plugin

	-- Load keymaps (after plugins and LSP since some depend on them)
	require('core.keymaps').setup()
	require('core.keymaps').setup_telescope_keymaps()
	require('core.keymaps').setup_chatgpt_keymaps()
	require('core.keymaps').setup_package_info_keymaps()

	-- Load autocommands
	require('core.autocmds').setup()
	require('core.autocmds').setup_markdown()
	require('core.autocmds').setup_latex()
	require('core.autocmds').setup_formatting()

	-- Load custom modules
	require('custom.unsaved_buffers')
	require('custom.copy_diff_from_branch')
end

return M

