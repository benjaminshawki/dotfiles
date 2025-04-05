-- Keymappings module

local M = {}

function M.setup()
	local wk = require("which-key")

	-- Basic keymaps
	vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
	vim.keymap.set({ 'n', 'v' }, '<Leader>h', '<Nop>', { silent = true })
	vim.keymap.set({ 'n', 'v' }, '<Leader>j', '<Nop>', { silent = true })
	vim.keymap.set({ 'n', 'v' }, '<Leader>k', '<Nop>', { silent = true })
	vim.keymap.set({ 'n', 'v' }, '<Leader>l', '<Nop>', { silent = true })

	vim.keymap.del('n', '<Leader>h')
	vim.keymap.del('n', '<Leader>j')
	vim.keymap.del('n', '<Leader>k')
	vim.keymap.del('n', '<Leader>l')

	-- Override 's' and 'S' to disable their default behavior
	vim.api.nvim_set_keymap('n', 's', '<Nop>', { noremap = true, silent = true })

	-- Word wrap navigation
	vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
	vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

	-- Diagnostic keymaps
	vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
	vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
	vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
	vim.keymap.set('n', '<leader>qq', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

	-- Buffer and window keymaps
	vim.api.nvim_set_keymap('n', '<leader>bn', ':bn<CR>', { noremap = true })
	vim.api.nvim_set_keymap('n', '<leader>tn', 'gt', { noremap = true })
	vim.api.nvim_set_keymap('n', '<C-w>h', '<C-w>s', { noremap = true })

	-- Aerial (code outline) keymaps
	vim.keymap.set("n", "<leader>ta", "<cmd>AerialToggle!<CR>")

	-- Toggle diagnostics
	vim.keymap.set('n', '<leader>td', function()
		if vim.diagnostic.is_enabled() then
			vim.diagnostic.enable(false)
		else
			vim.diagnostic.enable()
		end
	end, { desc = "Toggle Diagnostics" })

	-- Toggle spell checking
	vim.api.nvim_create_user_command("ToggleSpell", function()
		vim.wo.spell = not vim.wo.spell
	end, {})
	vim.keymap.set('n', '<leader>ts', ':ToggleSpell<CR>', { desc = "Toggle Spell Checking" })

	-- Toggle Copilot
	vim.keymap.set('n', '<leader>tc', function()
		local enabled = vim.b.copilot_enabled or vim.g.copilot_enabled or false
		if enabled then
			vim.cmd('Copilot disable')
			print('Copilot disabled')
		else
			vim.cmd('Copilot enable')
			print('Copilot enabled')
		end
	end, { desc = "Toggle Copilot" })

	-- Pasting image from clipboard in markdown
	vim.api.nvim_set_keymap('n', '<Leader>pp', ':call mdip#MarkdownClipboardImage()<CR>',
		{ noremap = false, silent = true, desc = 'Paste image from clipboard in markdown' })
	vim.api.nvim_set_keymap('n', '<Leader>put', ":pu=strftime('%c')<CR>",
		{ noremap = false, silent = true, desc = 'Insert current time' })

	-- Tab navigation with numbers
	for i = 1, 9 do
		vim.keymap.set('n', '<leader>' .. i, i .. 'gt', { desc = 'Go to tab ' .. i })
	end

	-- Git related keymaps via which-key
	wk.add({
		{ "<leader>g",  group = "git" },
		{ "<leader>gd", "<cmd>Gdiff<cr>",      desc = "Diff" },
		{ "<leader>gl", "<cmd>Git pull<cr>",   desc = "Pull" },
		{ "<leader>gp", "<cmd>Git push<cr>",   desc = "Push" },
		{ "<leader>gs", "<cmd>Git status<cr>", desc = "Status" },
	})

	-- document existing key chains
	wk.add({
		{ "<leader>c",  group = "[C]ode" },
		{ "<leader>c_", hidden = true },
		{ "<leader>d",  group = "[D]ocument" },
		{ "<leader>d_", hidden = true },
		{ "<leader>g",  group = "[G]it" },
		{ "<leader>g_", hidden = true },
		{ "<leader>h",  group = "Git [H]unk" },
		{ "<leader>h_", hidden = true },
		{ "<leader>n",  group = "[N]pm Info" },
		{ "<leader>n_", hidden = true },
		{ "<leader>r",  group = "[R]ename" },
		{ "<leader>r_", hidden = true },
		{ "<leader>s",  group = "[S]earch" },
		{ "<leader>s_", hidden = true },
		{ "<leader>t",  group = "[T]oggle" },
		{ "<leader>t_", hidden = true },
		{ "<leader>w",  group = "[W]orkspace" },
		{ "<leader>w_", hidden = true },
	})

	-- register which-key VISUAL mode
	-- required for visual <leader>hs (hunk stage) to work
	wk.add({
		{ "<leader>",  group = "VISUAL <leader>", mode = "v" },
		{ "<leader>h", desc = "Git [H]unk",       mode = "v" },
	})
end

-- Setup telescope keymaps separately as they require the builtin module
function M.setup_telescope_keymaps()
	local builtin = require('telescope.builtin')

	-- Telescope live_grep in git root
	-- Function to find the git root directory based on the current buffer's path
	local function find_git_root()
		-- Use the current buffer's path as the starting point for the git search
		local current_file = vim.api.nvim_buf_get_name(0)
		local current_dir
		local cwd = vim.fn.getcwd()
		-- If the buffer is not associated with a file, return nil
		if current_file == '' then
			current_dir = cwd
		else
			-- Extract the directory from the current file's path
			current_dir = vim.fn.fnamemodify(current_file, ':h')
		end

		-- Find the Git root directory from the current file's path
		local git_root = vim.fn.systemlist('git -C ' .. vim.fn.escape(current_dir, ' ') .. ' rev-parse --show-toplevel')[1]
		if vim.v.shell_error ~= 0 then
			print 'Not a git repository. Searching on current working directory'
			return cwd
		end
		return git_root
	end

	-- See `:help telescope.builtin`
	vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
	vim.keymap.set('n', '<leader><space>', builtin.buffers, { desc = '[ ] Find existing buffers' })
	vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
	vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
	vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = 'Search [G]it [F]iles' })
	vim.keymap.set('n', '<leader>gS', builtin.git_status, { desc = 'Git [S]tatus Files with Telescope' })
	vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
	vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
	vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
	vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
	vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
	vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
	vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })

	-- Custom command for live_grep on git root
	vim.api.nvim_create_user_command('LiveGrepGitRoot', function()
		-- Custom live_grep function to search in git root
		local git_root = find_git_root()
		if git_root then
			builtin.live_grep {
				search_dirs = { git_root },
			}
		end
	end, {})
	vim.keymap.set('n', '<leader>sG', ':LiveGrepGitRoot<cr>', { desc = '[S]earch by [G]rep on Git Root' })

	-- Open new tab and search files
	local function new_tab_and_search_files()
		vim.cmd('tabnew')
		builtin.find_files()
	end

	vim.keymap.set('n', '<leader><tab>sf', new_tab_and_search_files, { desc = 'Open new tab and search files' })

	-- Current buffer fuzzy find
	vim.keymap.set('n', '<leader>/', function()
		-- You can pass additional configuration to telescope to change theme, layout, etc.
		builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
			winblend = 14,
			previewer = true,
			layout_config = {
				width = .99,
				height = .99,
			},
		})
	end, { desc = '[/] Fuzzily search in current buffer' })

	-- Search in open files
	vim.keymap.set('n', '<leader>s/', function()
		builtin.live_grep {
			grep_open_files = true,
			prompt_title = 'Live Grep in Open Files',
		}
	end, { desc = '[S]earch [/] in Open Files' })

	-- Define a user command that opens Telescope to find directories
	local function open_telescope_find_directories(use_git_root)
		local search_root = use_git_root and find_git_root() or '.'
		require('telescope.builtin').find_files({
			find_command = { 'find', search_root, '-type', 'd' }
		})
	end

	vim.api.nvim_create_user_command('FindFilesGitRoot', function()
		open_telescope_find_directories(true)
	end, { desc = "Find directories from the Git root" })

	vim.api.nvim_create_user_command('FindFilesCurrentDir', function()
		open_telescope_find_directories(false)
	end, { desc = "Find directories from the current directory" })

	-- Key mappings
	vim.api.nvim_set_keymap('n', '<leader>sm', ':FindFilesGitRoot<CR>',
		{ noremap = true, silent = true, desc = 'FZF Git root and open NETRW' })
	vim.api.nvim_set_keymap('n', '<leader>sn', ':FindFilesCurrentDir<CR>',
		{ noremap = true, silent = true, desc = 'FZF current directory and open NETRW' })
end

-- Setup ChatGPT specific keymaps
function M.setup_chatgpt_keymaps()
	local wk = require("which-key")

	-- ChatGPT Commands group
	wk.add({
		{ "<leader><CR>", group = "ChatGPT" },
	})
	--
	-- vim.keymap.set({ "n", "v" }, "<leader><CR><CR>", "<cmd>ChatGPT<CR>", { desc = "ChatGPT" })
	-- vim.keymap.set({ "n", "v" }, "<leader><CR>c", "<cmd>ChatGPTCompleteCode<CR>", { desc = "Complete Code" })
	-- vim.keymap.set({ "n", "v" }, "<leader><CR>a", "<cmd>ChatGPTActAs<CR>", { desc = "Act As" })
	-- vim.keymap.set({ "n", "v" }, "<leader><CR>e", "<cmd>ChatGPTEditWithInstruction<CR>", { desc = "Edit with instruction" })
	-- vim.keymap.set({ "n", "v" }, "<leader><CR>g", "<cmd>ChatGPTRun grammar_correction<CR>", { desc = "Grammar Correction" })
	-- vim.keymap.set({ "n", "v" }, "<leader><CR>z", "<cmd>ChatGPTRun translate<CR>", { desc = "Translate" })
	-- vim.keymap.set({ "n", "v" }, "<leader><CR>k", "<cmd>ChatGPTRun keywords<CR>", { desc = "Keywords" })
	-- vim.keymap.set({ "n", "v" }, "<leader><CR>d", "<cmd>ChatGPTRun docstring<CR>", { desc = "Docstring" })
	-- vim.keymap.set({ "n", "v" }, "<leader><CR>t", "<cmd>ChatGPTRun add_tests<CR>", { desc = "Add Tests" })
	-- vim.keymap.set({ "n", "v" }, "<leader><CR>o", "<cmd>ChatGPTRun optimize_code<CR>", { desc = "Optimize Code" })
	-- vim.keymap.set({ "n", "v" }, "<leader><CR>s", "<cmd>ChatGPTRun summarize<CR>", { desc = "Summarize" })
	-- vim.keymap.set({ "n", "v" }, "<leader><CR>f", "<cmd>ChatGPTRun fix_bugs<CR>", { desc = "Fix Bugs" })
	-- vim.keymap.set({ "n", "v" }, "<leader><CR>x", "<cmd>ChatGPTRun explain_code<CR>", { desc = "Explain Code" })
	-- vim.keymap.set({ "n", "v" }, "<leader><CR>r", "<cmd>ChatGPTRun roxygen_edit<CR>", { desc = "Roxygen Edit" })
	-- vim.keymap.set({ "n", "v" }, "<leader><CR>l", "<cmd>ChatGPTRun code_readability_analysis<CR>",
	--   { desc = "Code Readability Analysis" })

	vim.keymap.set({ "n" }, "<leader><CR>q", "<cmd>Copilot disable<CR>", { desc = "Copilot disable" })
	vim.keymap.set({ "n" }, "<leader><CR>Q", "<cmd>Copilot enable<CR>", { desc = "Copilot enable" })
end

-- Setup NPM package info keymaps
function M.setup_package_info_keymaps()
	pcall(require("telescope").load_extension, "package_info")
	vim.keymap.set({ "n" }, "<LEADER>ns", require("package-info").show, { silent = true, noremap = true, desc = 'show' })
	vim.keymap.set({ "n" }, "<LEADER>nc", require("package-info").hide, { silent = true, noremap = true, desc = 'hide' })
	vim.keymap.set({ "n" }, "<LEADER>nt", require("package-info").toggle,
		{ silent = true, noremap = true, desc = 'toggle' })
	vim.keymap.set({ "n" }, "<LEADER>nu", require("package-info").update,
		{ silent = true, noremap = true, desc = 'update' })
	vim.keymap.set({ "n" }, "<LEADER>nd", require("package-info").delete,
		{ silent = true, noremap = true, desc = 'delete' })
	vim.keymap.set({ "n" }, "<LEADER>ni", require("package-info").install,
		{ silent = true, noremap = true, desc = 'install' })
	vim.keymap.set({ "n" }, "<LEADER>np", require("package-info").change_version,
		{ silent = true, noremap = true, desc = 'change_version' })
end

return M

