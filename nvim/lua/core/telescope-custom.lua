local M = {}

-- Custom find_files with sortable options
M.find_files_with_sort = function()
	local builtin = require('telescope.builtin')
	local sorters = require('telescope.sorters')
	local actions = require('telescope.actions')
	local action_state = require('telescope.actions.state')

	-- Store sort state
	local current_sort = vim.g.telescope_sort_method or "name_asc"

	local sort_methods = {
		name_asc = {
			prompt_title = "Find Files (Name A-Z)",
			find_command = { "fd", "--type", "f", "--hidden", "--follow", "--exclude", ".git" },
		},
		name_desc = {
			prompt_title = "Find Files (Name Z-A)",
			find_command = { "fd", "--type", "f", "--hidden", "--follow", "--exclude", ".git", "--exec-batch", "ls", "-1r" },
		},
		modified_desc = {
			prompt_title = "Find Files (Newest First)",
			find_command = { "fd", "--type", "f", "--hidden", "--follow", "--exclude", ".git", "--exec-batch", "ls", "-1t" },
		},
		modified_asc = {
			prompt_title = "Find Files (Oldest First)",
			find_command = { "fd", "--type", "f", "--hidden", "--follow", "--exclude", ".git", "--exec-batch", "ls", "-1tr" },
		},
	}

	-- Helper function to cycle sort methods
	local function cycle_sort(prompt_bufnr)
		local sort_order = { "name_asc", "name_desc", "modified_desc", "modified_asc" }
		local current_index = 1

		for i, method in ipairs(sort_order) do
			if method == current_sort then
				current_index = i
				break
			end
		end

		-- Move to next sort method
		current_index = current_index % #sort_order + 1
		current_sort = sort_order[current_index]
		vim.g.telescope_sort_method = current_sort

		-- Close current picker and reopen with new sort
		actions.close(prompt_bufnr)
		M.find_files_with_sort()
	end

	local opts = sort_methods[current_sort]
	opts.attach_mappings = function(_, map)
		-- Add sort cycling to both insert and normal mode
		map('i', '<C-s>', cycle_sort)
		map('n', '<C-s>', cycle_sort)
		return true
	end

	builtin.find_files(opts)
end

-- Alternative implementation using ripgrep for sorting
M.find_files_rg_sort = function()
	local builtin = require('telescope.builtin')
	local actions = require('telescope.actions')

	-- Store sort state
	local current_sort = vim.g.telescope_rg_sort or "path_asc"

	local sort_methods = {
		path_asc = {
			prompt_title = "Find Files (Name A..Z - Press <C-s> to cycle)",
			find_command = { "rg", "--files", "--hidden", "--glob", "!.git", "--sort", "path" },
		},
		path_desc = {
			prompt_title = "Find Files (Name Z..A - Press <C-s> to cycle)",
			find_command = { "rg", "--files", "--hidden", "--glob", "!.git", "--sortr", "path" },
		},
		modified_desc = {
			prompt_title = "Find Files (Modified Newest - Press <C-s> to cycle)",
			find_command = { "rg", "--files", "--hidden", "--glob", "!.git", "--sortr", "modified" },
		},
		modified_asc = {
			prompt_title = "Find Files (Modified Oldest - Press <C-s> to cycle)",
			find_command = { "rg", "--files", "--hidden", "--glob", "!.git", "--sort", "modified" },
		},
		accessed_desc = {
			prompt_title = "Find Files (Accessed Recent - Press <C-s> to cycle)",
			find_command = { "rg", "--files", "--hidden", "--glob", "!.git", "--sortr", "accessed" },
		},
		accessed_asc = {
			prompt_title = "Find Files (Accessed Oldest - Press <C-s> to cycle)",
			find_command = { "rg", "--files", "--hidden", "--glob", "!.git", "--sort", "accessed" },
		},
		created_desc = {
			prompt_title = "Find Files (Created Newest - Press <C-s> to cycle)",
			find_command = { "rg", "--files", "--hidden", "--glob", "!.git", "--sortr", "created" },
		},
		created_asc = {
			prompt_title = "Find Files (Created Oldest - Press <C-s> to cycle)",
			find_command = { "rg", "--files", "--hidden", "--glob", "!.git", "--sort", "created" },
		},
	}

	local function cycle_sort(prompt_bufnr)
		local sort_order = {
			"path_asc", "path_desc",
			"modified_desc", "modified_asc",
			"accessed_desc", "accessed_asc",
			"created_desc", "created_asc"
		}
		local current_index = 1

		for i, method in ipairs(sort_order) do
			if method == current_sort then
				current_index = i
				break
			end
		end

		current_index = current_index % #sort_order + 1
		current_sort = sort_order[current_index]
		vim.g.telescope_rg_sort = current_sort

		actions.close(prompt_bufnr)
		M.find_files_rg_sort()
	end

	local method = sort_methods[current_sort]
	builtin.find_files({
		prompt_title = method.prompt_title,
		find_command = method.find_command,
		cwd = vim.loop.cwd(),
		attach_mappings = function(_, map)
			map('i', '<C-s>', cycle_sort)
			map('n', '<C-s>', cycle_sort)
			return true
		end,
	})
end

return M
