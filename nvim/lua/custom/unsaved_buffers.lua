-- Lazy load telescope modules only when function is called
local function open_unsaved_buffers_picker()
	-- Get unsaved buffers first
	local results = {}
	for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(bufnr)
				and vim.api.nvim_buf_get_option(bufnr, 'modified')
				and vim.api.nvim_buf_get_option(bufnr, 'buftype') == '' then
			local name = vim.api.nvim_buf_get_name(bufnr)
			if name == '' or name == nil then
				name = '[No Name]'
			end
			table.insert(results, {
				bufnr = bufnr,
				name = name,
			})
		end
	end

	if #results == 0 then
		vim.notify("No unsaved buffers found", vim.log.levels.INFO)
		return
	end

	-- Load telescope modules only when needed
	local pickers = require('telescope.pickers')
	local finders = require('telescope.finders')
	local conf = require('telescope.config').values
	local actions = require('telescope.actions')
	local action_state = require('telescope.actions.state')

	pickers.new({}, {
		prompt_title = "Unsaved Buffers",
		finder = finders.new_table {
			results = results,
			entry_maker = function(entry)
				return {
					value = entry.bufnr,
					display = entry.name,
					ordinal = entry.name,
				}
			end
		},
		sorter = conf.generic_sorter({}),
		attach_mappings = function(prompt_bufnr, _)
			local function open_buf()
				local selection = action_state.get_selected_entry()
				if selection then
					actions.close(prompt_bufnr)
					-- Switch to that buffer
					vim.api.nvim_set_current_buf(selection.value)
				end
			end

			actions.select_default:replace(open_buf)
			return true
		end,
	}):find()
end

vim.keymap.set('n', '<leader>u', open_unsaved_buffers_picker, { desc = 'Open Unsaved Buffers' })
