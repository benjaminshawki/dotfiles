return {
	"gruvw/strudel.nvim",
	build = "npm install",
	config = function()
		require("strudel").setup({
			-- Strudel web user interface related options
			ui = {
				maximise_menu_panel = true,
				hide_menu_panel = false,
				hide_top_bar = false,
				hide_code_editor = true,
				hide_error_display = false,
			},
			update_on_save = true,
			sync_cursor = true,
			report_eval_errors = true,
			headless = false,
		})
	end,
}
