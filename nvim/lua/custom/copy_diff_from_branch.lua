local function copy_diff_from_branch()
	local builtin = require('telescope.builtin')
	local actions = require('telescope.actions')
	local action_state = require('telescope.actions.state')

	-- Using the built-in git_branches picker
	builtin.git_branches({
		attach_mappings = function(prompt_bufnr)
			actions.select_default:replace(function()
				-- Get the user’s selection (the branch name)
				local selection = action_state.get_selected_entry()
				actions.close(prompt_bufnr)
				if not selection or not selection.value then
					print("No branch selected!")
					return
				end
				local branch = selection.value

				local cmd = string.format(
					"git diff origin/%s -- . ':(exclude)package-lock.json' | wl-copy",
					branch
				)

				vim.fn.system(cmd)
				print("Copied diff from origin/" .. branch .. " to clipboard!")
			end)

			return true
		end
	})
end

vim.keymap.set('n', '<leader>gc', copy_diff_from_branch, { desc = "Telescope pick branch and copy diff" })
