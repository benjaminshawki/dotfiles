-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.o.showbreak = '↪ ' -- Sets a string to be shown before lines that have been soft-wrapped

-- [[ Install `lazy.nvim` plugin manager ]]
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system {
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable', -- latest stable release
		lazypath,
	}
end
vim.opt.runtimepath:prepend(lazypath)

local WINBLEND = 14
vim.o.pumblend = WINBLEND
vim.o.winblend = WINBLEND

-- [[ Configure plugins ]]
require('lazy').setup({

	-- Git related plugins
	'tpope/vim-fugitive',
	'tpope/vim-rhubarb',

	-- Detect tabstop and shiftwidth automatically
	-- 'tpope/vim-sleuth',

	{
		-- LSP Configuration & Plugins
		'neovim/nvim-lspconfig',
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			{ 'williamboman/mason.nvim', config = true },
			'williamboman/mason-lspconfig.nvim',

			-- Useful status updates for LSP
			{ 'j-hui/fidget.nvim',       opts = {} },

			-- Additional lua configuration, makes nvim stuff amazing!
			'folke/neodev.nvim',
		},
	},

	{
		-- Autocompletion
		'hrsh7th/nvim-cmp',
		dependencies = {
			-- Snippet Engine & its associated nvim-cmp source
			'L3MON4D3/LuaSnip',
			'saadparwaiz1/cmp_luasnip',

			-- Adds LSP completion capabilities
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-path',

			-- Adds a number of user-friendly snippets
			'rafamadriz/friendly-snippets',
			"mlaursen/vim-react-snippets",
		},
	},
	-- TODO: Check the benifits of this plugin
	-- {
	-- 	'mrcjkb/rustaceanvim',
	-- 	version = '^5', -- Recommended
	-- 	lazy = false, -- This plugin is already lazy
	-- },

	-- Useful plugin to show you pending keybinds.
	{
		'folke/which-key.nvim',
		event = "VeryLazy",
		dependencies = {
			"echasnovski/mini.icons"
		},
	},
	{
		"kdheepak/lazygit.nvim",
		lazy = true,
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		-- setting the keybinding for LazyGit with 'keys' is recommended in
		-- order to load the plugin when the command is run for the first time
		keys = {
			{ "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
		}
	},
	{
		-- Adds git related signs to the gutter, as well as utilities for managing changes
		'lewis6991/gitsigns.nvim',
		opts = {
			-- See `:help gitsigns.txt`
			signs = {
				change = { text = '~' },
				topdelete = { text = '‾' },
				delete = { text = '_' },
				add = { text = '+' },
				changedelete = { text = '~' },
			},
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map({ 'n', 'v' }, ']c', function()
					if vim.wo.diff then
						return ']c'
					end
					vim.schedule(function()
						gs.next_hunk()
					end)
					return '<Ignore>'
				end, { expr = true, desc = 'Jump to next hunk' })

				map({ 'n', 'v' }, '[c', function()
					if vim.wo.diff then
						return '[c'
					end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return '<Ignore>'
				end, { expr = true, desc = 'Jump to previous hunk' })

				-- Actions
				-- visual mode
				map('v', '<leader>hs', function()
					gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
				end, { desc = 'stage git hunk' })
				map('v', '<leader>hr', function()
					gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
				end, { desc = 'reset git hunk' })
				-- normal mode
				map('n', '<leader>hs', gs.stage_hunk, { desc = 'git stage hunk' })
				map('n', '<leader>hr', gs.reset_hunk, { desc = 'git reset hunk' })
				map('n', '<leader>hS', gs.stage_buffer, { desc = 'git Stage buffer' })
				map('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'undo stage hunk' })
				map('n', '<leader>hR', gs.reset_buffer, { desc = 'git Reset buffer' })
				map('n', '<leader>hp', gs.preview_hunk, { desc = 'preview git hunk' })
				map('n', '<leader>hb', function()
					gs.blame_line { full = false }
				end, { desc = 'git blame line' })
				map('n', '<leader>hd', gs.diffthis, { desc = 'git diff against index' })
				map('n', '<leader>hD', function()
					gs.diffthis '~'
				end, { desc = 'git diff against last commit' })

				-- Toggles
				map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = 'toggle git blame line' })
				map('n', '<leader>t<Del>', gs.toggle_deleted, { desc = 'toggle git show deleted' })

				-- Text object
				map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'select git hunk' })
			end,
		},
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {}
	},
	{
		-- Set lualine as statusline
		'nvim-lualine/lualine.nvim',
		-- See `:help lualine.txt`
		opts = {
			options = {
				icons_enabled = false,
				theme = 'tokyonight',
				component_separators = '|',
				section_separators = '',
			},
		},
	},
	{
		-- Add indentation guides even on blank lines
		'lukas-reineke/indent-blankline.nvim',
		-- Enable `lukas-reineke/indent-blankline.nvim`
		-- See `:help ibl`
		main = 'ibl',
		opts = {},
	},

	-- "gc" to comment visual regions/lines
	{ 'numToStr/Comment.nvim',                      opts = {} },

	-- Jsx / tsx commentstring
	{ "JoosepAlviste/nvim-ts-context-commentstring" },
	-- Fuzzy Finder (files, lsp, etc)
	{
		'nvim-telescope/telescope.nvim',
		branch = '0.1.x',
		dependencies = {
			'nvim-lua/plenary.nvim',
			-- Fuzzy Finder Algorithm which requires local dependencies to be built.
			-- Only load if `make` is available. Make sure you have the system
			-- requirements installed.
			{
				'nvim-telescope/telescope-fzf-native.nvim',
				build = 'make',
				cond = function()
					return vim.fn.executable 'make' == 1
				end,
			},
		},
	},
	{
		"artemave/workspace-diagnostics.nvim",
	},
	{
		-- Highlight, edit, and navigate code
		'nvim-treesitter/nvim-treesitter',
		--tag = 'v0.9.2',
		dependencies = {
			'nvim-treesitter/nvim-treesitter-textobjects',
		},
		build = ':TSUpdate',
	},
	'moll/vim-bbye',
	'simeji/winresizer',

	{ "junegunn/fzf",          build = "./install --bin" },
	'machakann/vim-sandwich',
	'wincent/ferret',

	-- linter
	'neomake/neomake',

	-- tmux
	'wellle/tmux-complete.vim',
	'simnalamburt/vim-mundo',
	'christoomey/vim-tmux-navigator',

	'jez/vim-superman',
	'github/copilot.vim',
	-- install without yarn or npm
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function() vim.fn["mkdp#util#install"]() end,
	},
	{
		"vuki656/package-info.nvim",
		ft = "json",
		dependencies = "MunifTanjim/nui.nvim",
		opts = {},
	},
	{
		"prettier/vim-prettier",
		run = "yarn install",
		ft = { "javascript", "typescript", "typescriptreact", "javascriptreact", "mjs", "mts", "css", "less", "scss", "json", "graphql", "vue", "yaml", "html", "markdown" },
	},
	"nanotee/zoxide.vim",
	"mbbill/undotree",
	"editorconfig/editorconfig-vim",
	{
		"benjaminshawki/ChatGPT.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"folke/trouble.nvim",
			"nvim-telescope/telescope.nvim"
		},
	},
	{
		"folke/trouble.nvim",
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>ty",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>tl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},
	{
		"benjaminshawki/nvim-random-id",
		config = function()
			require('nvim-random-id').setup()
		end,
	},
	-- {
	--   dir = vim.fn.expand("$HOME/workspace/nvim-random-id"),
	--   config = function()
	--     require('nvim-random-id').setup()
	--   end,
	-- },
	{
		-- "benjaminshawki/nvim-random-id",
		-- config = function()
		--   vim.keymap.set({ "n" }, '<leader>cg', ':lua add_key_value_pair()<CR>')
		-- end
	},
	{
		'stevearc/aerial.nvim',
		opts = {},
		-- Optional dependencies
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons"
		},
	},
	"img-paste-devs/img-paste.vim",
	{
		"olrtg/nvim-emmet",
		config = function()
			vim.keymap.set({ "n", "v" }, '<leader>xe', require('nvim-emmet').wrap_with_abbreviation)
		end,
	},
	{
		"lervag/vimtex",
		-- lazy = false, -- we don't want to lazy load VimTeX
		ft = { "tex", "plaintex", "latex" },
		-- tag = "v2.15", -- uncomment to pin to a specific release
		init = function()
			-- VimTeX configuration goes here
			vim.g.vimtex_view_method = "zathura"
			vim.g.vimtex_compiler_latexmk = {
				build_dir = 'build',
				options = {
					'-pdf', '-interaction=nonstopmode', '-synctex=1', '-shell-escape',
				},
			}
		end
	},
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {},
	},
	{ "adalessa/laravel.nvim", },

	--   NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`

	--    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
	--    up-to-date with whatever is in the kickstart repo.
	--    Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
	--
	--    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
	-- { import = 'custom.plugins' },
}, {})

local wk = require("which-key")

-- Function to update lualine's tabline based on the number of tabs
local function update_lualine_tabline()
	local lualine_ok, lualine = pcall(require, 'lualine')
	if not lualine_ok then
		return
	end

	local config = lualine.get_config()

	if vim.fn.tabpagenr('$') > 1 then
		config.tabline = {
			lualine_a = {
				{
					'tabs',
					mode = 2, -- 0: tabnr, 1: tabname, 2: both
					tabs_color = {
						active = 'lualine_a_normal',
						inactive = 'lualine_a_inactive',
					},
				},
			},
		}
	else
		config.tabline = nil -- Remove the tabline when only one tab is open
	end

	lualine.setup(config)
end

-- Call the function to set the initial tabline state
update_lualine_tabline()


-- Autocommand to update the tabline when tabs are opened or closed
vim.api.nvim_create_autocmd({ 'TabNew', 'TabClosed' }, {
	callback = function()
		-- Defer the update to ensure the tab count is accurate
		vim.defer_fn(update_lualine_tabline, 0)
	end,
})

-- Theme
-- Tokyo Night theme setup with safe check
-- ThemeManager definition and functions
local ThemeManager = {}

function ThemeManager.saveThemeToFile(theme)
	local filePath = vim.fn.stdpath('config') .. '/.nvim_theme'
	local file = io.open(filePath, 'w')
	if not file then
		print("Failed to open file for writing.")
		return
	end
	file:write(theme)
	file:close()
end

function ThemeManager.loadThemeFromFile()
	local filePath = vim.fn.stdpath('config') .. '/.nvim_theme'
	local file = io.open(filePath, 'r')
	if not file then
		return nil -- Default theme if file not found
	end
	local theme = file:read("*a")
	file:close()
	return theme
end

function ThemeManager.applyTheme(theme)
	vim.cmd("colorscheme " .. theme)
	local lualine_ok, lualine = pcall(require, 'lualine')
	if lualine_ok then
		local config = lualine.get_config()
		config.options.theme = theme
		lualine.setup(config)
	end
	-- Update the tabline after changing the theme
	update_lualine_tabline()
end

function ThemeManager.switchTheme(theme)
	ThemeManager.applyTheme(theme)
	ThemeManager.saveThemeToFile(theme)
end

-- Tokyo Night theme setup with safe check
local tokyonight_ok, tokyonight = pcall(require, "tokyonight")
if tokyonight_ok then
	tokyonight.setup({
		styles = {
			sidebars = "transparent",
			floats = "transparent",
		},
		on_colors = function(colors)
			colors.fg = "#CFCFCF"
			colors.bg = "#000000"
			colors.bg_dark = "#100000"
			colors.bg_statusline = "#100000"
			colors.bg_float = "#100000"
			colors.bg_popup = "#100000"
			colors.bg_sidebar = "#100000"
			colors.git = { add = "#36e32b", change = "#f3b994", delete = "#c4342d" }
			colors.gitSigns = { add = "#36e32b", change = "#f3b994", delete = "#c4342d" }
		end
	})
else
	print("Tokyo Night theme not found. Please install it to use this configuration.")
end

-- On Neovim startup, load the theme
local theme = ThemeManager.loadThemeFromFile()
if theme then
	ThemeManager.applyTheme(theme)
end

-- Key mappings for theme switching
vim.keymap.set('n', '<leader>ttn', function() ThemeManager.switchTheme('tokyonight-night') end,
	{ desc = 'Switch to Tokyo Night Night Theme' })
vim.keymap.set('n', '<leader>tts', function() ThemeManager.switchTheme('tokyonight-storm') end,
	{ desc = 'Switch to Tokyo Night Storm Theme' })
vim.keymap.set('n', '<leader>ttd', function() ThemeManager.switchTheme('tokyonight-day') end,
	{ desc = 'Switch to Tokyo Night Day Theme' })
vim.keymap.set('n', '<leader>ttm', function() ThemeManager.switchTheme('tokyonight-moon') end,
	{ desc = 'Switch to Tokyo Night Moon Theme' })

-- [[ Setting options ]]
-- See `:help vim.o`

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true
vim.o.swapfile = false
vim.o.undodir = vim.fn.expand('$HOME/.config/nvim/undo')
vim.o.undolevels = 10000
vim.o.undoreload = 10000

-- shiftwidth and tabstop
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

wk.add({
	{ "<leader>g",  group = "git" },
	{ "<leader>gd", "<cmd>Gdiff<cr>",      desc = "Diff" },
	{ "<leader>gl", "<cmd>Git pull<cr>",   desc = "Pull" },
	{ "<leader>gp", "<cmd>Git push<cr>",   desc = "Push" },
	{ "<leader>gs", "<cmd>Git status<cr>", desc = "Status" },
})


-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noinsert,noselect'

vim.o.termguicolors = true

-- Override 's' and 'S' to disable their default behavior
vim.api.nvim_set_keymap('n', 's', '<Nop>', { noremap = true, silent = true })

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<Leader>h', '<Nop>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<Leader>j', '<Nop>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<Nop>', '<Leader>k', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<Leader>l', '<Nop>', { silent = true })

vim.keymap.del('n', '<Leader>h')
vim.keymap.del('n', '<Leader>j')
vim.keymap.del('n', '<Leader>k')
vim.keymap.del('n', '<Leader>l')

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>qq', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

vim.api.nvim_set_keymap('n', '<leader>bn', ':bn<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>tn', 'gt', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-w>h', '<C-w>s', { noremap = true })

-- Compile and open output
-- vim.keymap.set('n', '<leader>G', ':w! | !"$DOTFILES"/nvim/scripts/comp <c-r>%<CR><CR>')
-- vim.keymap.set('n', '<leader>o', ':!"DOTFILES"/nvim/scripts/opout <c-r>%<CR><CR>')

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = '*',
})

require("aerial").setup({
	-- optionally use on_attach to set keymaps when aerial has attached to a buffer
	on_attach = function(bufnr)
		-- Jump forwards/backwards with '{' and '}'
		vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
		vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
	end,
})
-- You probably also want to set a keymap to toggle aerial
vim.keymap.set("n", "<leader>ta", "<cmd>AerialToggle!<CR>")

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
	defaults = {
		mappings = {
			i = {
				['<C-u>'] = false,
				['<C-d>'] = false,
			},
		},
		winblend = WINBLEND,
		layout_config = {
			width = .99,
			height = .99,
		},
	},
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

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
local builtin = require('telescope.builtin')
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


vim.keymap.set('n', '<leader>/', function()
	-- You can pass additional configuration to telescope to change theme, layout, etc.
	builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
		winblend = WINBLEND,
		previewer = false,
		layout_config = {
			width = .99,
			height = .99,
		},
	})
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>s/', function()
	builtin.live_grep {
		grep_open_files = true,
		prompt_title = 'Live Grep in Open Files',
	}
end, { desc = '[S]earch [/] in Open Files' })

-- Define a user command that opens Telescope to find directories based on the location (git root or current)
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

-- CUSTOM CONFIGURATION
require("custom.unsaved_buffers")
require("custom.copy_diff_from_branch")

-- Key mappings
vim.api.nvim_set_keymap('n', '<leader>sm', ':FindFilesGitRoot<CR>',
	{ noremap = true, silent = true, desc = 'FZF Git root and open NETRW' })
vim.api.nvim_set_keymap('n', '<leader>sn', ':FindFilesCurrentDir<CR>',
	{ noremap = true, silent = true, desc = 'FZF current directory and open NETRW' })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
-- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
vim.defer_fn(function()
	require('nvim-treesitter.configs').setup {
		-- Add languages to be installed here that you want installed for treesitter
		ensure_installed = {
			'c',
			'cpp',
			'go',
			'lua',
			'luadoc',
			'python',
			'rust',
			'tsx',
			'javascript',
			'typescript',
			'vimdoc',
			'vim',
			'bash',
			'markdown',
			'markdown_inline',
			'css',
			'html',
			'dockerfile',
			'java',
			'jsdoc',
			'llvm',
			'make',
			'sql',
			'toml',
			'query',
			'xml',
			'yaml',
			'dockerfile',
			'c_sharp',
			'bibtex',
			'latex',
			'asm',
			'cmake',
			'comment',
			'csv',
			'cuda',
			'dot',
			'git_config',
			'git_rebase',
			'gitignore',
			'graphql',
			'haskell',
			'helm',
			'http',
			'jq',
			'json',
			'nix',
			'ocaml',
			'ocaml_interface',
			'php',
			'regex',
			'scala',
			'sql',
			'ssh_config',
			'tmux',
			'tsx',
			'vue',
			'zig',
		},
		auto_install = true,
		highlight = {
			enable = true,
			disable = { "latex" },
			additional_vim_regex_highlighting = false,
		},
		indent = { enable = true },
		incremental_selection = {
			enable = true,
			keymaps = {
				node_incremental = '<c-space>',
				init_selection = '<c-space>',
				scope_incremental = '<c-s>',
				node_decremental = '<Esc>[32;2u',
			},
		},
		textobjects = {
			select = {
				enable = true,
				lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
				keymaps = {
					-- You can use the capture groups defined in textobjects.scm
					['aa'] = '@parameter.outer',
					['ia'] = '@parameter.inner',
					['af'] = '@function.outer',
					['if'] = '@function.inner',
					['ac'] = '@class.outer',
					['ic'] = '@class.inner',
				},
			},
			move = {
				enable = true,
				set_jumps = true, -- whether to set jumps in the jumplist
				goto_next_start = {
					[']m'] = '@function.outer',
					[']]'] = '@class.outer',
				},
				goto_next_end = {
					[']M'] = '@function.outer',
					[']['] = '@class.outer',
				},
				goto_previous_start = {
					['[m'] = '@function.outer',
					['[['] = '@class.outer',
				},
				goto_previous_end = {
					['[M'] = '@function.outer',
					['[]'] = '@class.outer',
				},
			},
			swap = {
				enable = true,
				swap_next = {
					['<leader>j'] = '@parameter.inner',
				},
				swap_previous = {
					['<leader>k'] = '@parameter.inner',
				},
			},
		},
	}
end, 0)

require('Comment').setup {
	pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
}

-- spell
vim.api.nvim_create_user_command("ToggleSpell", function()
	vim.wo.spell = not vim.wo.spell
end, {})

vim.keymap.set('n', '<leader>ts', ':ToggleSpell<CR>', { desc = "Toggle Spell Checking" })

vim.keymap.set('n', '<leader>td', function()
	if vim.diagnostic.is_enabled() then
		vim.diagnostic.enable(false)
	else
		vim.diagnostic.enable()
	end
end, { desc = "Toggle Diagnostics" })

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(client, bufnr)
	-- In this case, we create a function that lets us more easily define mappings specific
	-- for LSP related items. It sets the mode, buffer and description for us each time.
	local nmap = function(keys, func, desc)
		if desc then
			desc = 'LSP: ' .. desc
		end

		vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
	end

	if client.server_capabilities.documentFormattingProvider then
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = vim.api.nvim_create_augroup("Format", { clear = true }),
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({ bufnr = bufnr })
			end
		})
	end

	require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)

	nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
	nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

	nmap('gd', builtin.lsp_definitions, '[G]oto [D]efinition')
	nmap('gr', builtin.lsp_references, '[G]oto [R]eferences')
	nmap('gI', builtin.lsp_implementations, '[G]oto [I]mplementation')
	nmap('<leader>D', builtin.lsp_type_definitions, 'Type [D]efinition')
	nmap('<leader>cs', builtin.lsp_document_symbols, 'Document [S]ymbols')
	nmap('<leader>cw', builtin.lsp_dynamic_workspace_symbols, 'Workspace [S]ymbols')

	-- See `:help K` for why this keymap
	nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
	nmap('<leader>K', vim.lsp.buf.signature_help, 'Signature Documentation')

	-- Lesser used LSP functionality
	nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
	nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
	nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
	nmap('<leader>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, '[W]orkspace [L]ist Folders')

	vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, { buffer = bufnr, desc = 'Format code' })

	-- Create a command `:Format` local to the LSP buffer
	vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
		vim.lsp.buf.format()
	end, { desc = 'Format current buffer with LSP' })
end

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

-- Key map for TSTools
vim.api.nvim_set_keymap('n', '<leader>rf', ':TSToolsRenameFile<CR>', { noremap = true, silent = true })

require("workspace-diagnostics").setup({
	workspace_files = function()
		return vim.fn.systemlist("git ls-files")
	end,
})


-- TeXLab setup
require('lspconfig').texlab.setup {
	filetypes = { "tex", "latex", "bib", "markdown" },
	on_attach = on_attach, -- Assuming you defined 'on_attach' in your LSP setup
}

vim.g.tex_flavor = 'latex'
vim.g.vimtex_format_enabled = 1

-- require('lspconfig').eslint.setup {
-- 	cmd = { "node_modules/.bin/eslint", "--stdin" },
-- 	filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
-- 	root_dir = require('lspconfig').util.root_pattern(".eslintrc", ".eslintrc.json", "package.json"),
-- }


-- mason-lspconfig requires that these setup functions are called in this order
-- before setting up the servers.
require('mason').setup({ PATH = "prepend" })
require('mason-lspconfig').setup()

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
local servers = {
	asm_lsp = {},
	clangd = {},
	gopls = {},
	pyright = {},
	rust_analyzer = {},
	bashls = {},
	-- ts_ls = {},
	html = { filetypes = { 'html', 'twig', 'hbs' } },
	jdtls = {},
	yamlls = {},
	jsonls = {},
	marksman = {},
	graphql = {},
	eslint = {},
	tailwindcss = {},
	sqlls = {},
	-- hdl_checker = {},
	vhdl_ls = {},
	texlab = { filetypes = { 'latex', 'tex', 'bib', 'markdown' } },
	emmet_language_server = { filetypes = { 'css', 'eruby', 'html', 'javascript', 'javascriptreact', 'less', 'sass', 'scss', 'pug', 'typescriptreact', 'vue' } },
	csharp_ls = {},
	dockerls = {},
	docker_compose_language_service = {},
	awk_ls = {},
	phpactor = {},
	-- omnisharp = {},

	-- grammarly = {
	--   enable = true,
	--   filetypes = { 'markdown', 'text', 'gitcommit', 'gitrebase' },
	-- },

	lua_ls = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
			-- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
			-- diagnostics = { disable = { 'missing-fields' } },
		},
	},
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
	ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
	function(server_name)
		require('lspconfig')[server_name].setup {
			capabilities = capabilities,
			on_attach = on_attach,
			settings = servers[server_name],
			filetypes = (servers[server_name] or {}).filetypes,
			handlers = {
				["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { winblend = WINBLEND }),
				["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { winblend = WINBLEND }),
			},
		}
	end,

}

-- Define capabilities for clangd separately
local clangd_capabilities = vim.lsp.protocol.make_client_capabilities()
clangd_capabilities = require('cmp_nvim_lsp').default_capabilities(clangd_capabilities)
clangd_capabilities.offsetEncoding = { "utf-8" }

-- Setup clangd with specific capabilities and initializationOptions
require('lspconfig').clangd.setup {
	on_attach = on_attach,
	capabilities = clangd_capabilities,
	cmd = { "clangd" },
	root_dir = require('lspconfig').util.root_pattern('compile_commands.json', '.clangd', '.git') or vim.loop.cwd(),
	init_options = {
		fallbackFlags = {
			"--target=arm-none-eabi",
			"--sysroot=/usr/arm-none-eabi",
			"--query-driver=/usr/bin/arm-none-eabi-*",
		},
	},
}

-- Setup VHDL LS
require 'lspconfig'.vhdl_ls.setup {
	cmd = { "vhdl_ls" },  -- Ensure vhdl_ls is installed and in PATH
	root_dir = function(_)
		return vim.loop.cwd() -- Set root directory to the current working directory
	end,
	on_attach = function(client)
		print("VHDL LS attached to " .. client.name)
	end,
}

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require 'cmp'
require("vim-react-snippets").lazy_load()
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
require("luasnip.loaders.from_lua").lazy_load({ paths = "$HOME/.config/nvim/lua/custom/snippets" })
luasnip.config.setup {}

cmp.setup {
	-- enabled = function()
	--   return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
	--       or require("cmp_dap").is_dap_buffer()
	-- end,
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	completion = {
		completeopt = 'menu,menuone,noinsert',
	},
	mapping = cmp.mapping.preset.insert {
		['<C-n>'] = cmp.mapping.select_next_item(),
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete {},
		['<CR>'] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		},
		['<Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_locally_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { 'i', 's' }),
		['<S-Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.locally_jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { 'i', 's' }),
	},
	sources = {
		{ name = 'copilot' },
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
		{ name = 'path' },
		{ name = "dap" },
	},
}

-- Diagnostis config
vim.diagnostic.config {
	float = {
		winblend = WINBLEND,
	},
}

-- disable perl
vim.g.loaded_perl_provider = 0

-- Prettier
-- vim.g["prettier#autoformat"] = 0
vim.g["prettier#autoformat_require_pragma"] = 0

local prettier_config_path = vim.fn.stdpath('config') .. '/.prettier_autoformat'

-- Function to save the value to a file
local function save_prettier_autoformat()
	local file = io.open(prettier_config_path, 'w')
	if file then
		file:write(vim.g["prettier#autoformat"])
		file:close()
	else
		print("Error: Unable to save Prettier autoformat setting!")
	end
end

-- Function to load the value from a file
local function load_prettier_autoformat()
	local file = io.open(prettier_config_path, 'r')
	if file then
		local value = file:read('*a')
		file:close()
		vim.g["prettier#autoformat"] = tonumber(value) or 0
	else
		vim.g["prettier#autoformat"] = 0 -- Default to 0 if file doesn't exist
	end
end

-- Toggle function
function TogglePrettierAutoformat()
	vim.g["prettier#autoformat"] = vim.g["prettier#autoformat"] == 0 and 1 or 0
	print("Prettier Autoformat: " .. vim.g["prettier#autoformat"])
	save_prettier_autoformat() -- Save after toggling
end

-- Load the setting when Neovim starts
load_prettier_autoformat()

-- Keybinding to toggle
vim.api.nvim_set_keymap('n', '<leader>tp', ':lua TogglePrettierAutoformat()<CR>', { noremap = true, silent = true })


-- copilot
vim.g.copilot_filetypes = {
	assembly = true,
	markdown = true,
	typescript = true,
	javascript = true,
	css = true,
	html = true,
	dockerfile = true,
	java = true,
	jsdoc = true,
	json = true,
	llvm = true,
	lua = true,
	luadoc = true,
	make = true,
	tex = true,
	plaintex = true,
	latex = true,
	python = true,
	rust = true,
	sql = true,
	toml = true,
	tsx = true,
	vim = true,
	vimdoc = true,
	query = true,
	xml = true,
	yaml = true,
	nix = true,
}

vim.g.copilot_debug = true

-- Copilot keymaps
vim.keymap.del('i', '<Tab>')
vim.g.copilot_no_tab_map = true
vim.keymap.set('i', '<M-Y>', 'copilot#Accept("<CR>")', { expr = true, replace_keycodes = false, silent = true })
vim.keymap.set('i', '<M-y>', '<Plug>(copilot-accept-word)')

-- OpenAI ChatGPT
local home = vim.fn.expand("$HOME")
require("chatgpt").setup({
	api_key_cmd = "gpg --decrypt " .. home .. "/secret.txt.gpg",
	open_ai_params = {
		model = "gpt-4-turbo-preview",
	},
	openai_edit_params = {
		model = "gpt-4-turbo-preview",
	},
})
-- ChatGPT Commands
wk.add({
	{ "<leader><CR>", group = "ChatGPT" },
})
vim.keymap.set({ "n", "v" }, "<leader><CR><CR>", "<cmd>ChatGPT<CR>", { desc = "ChatGPT" })
vim.keymap.set({ "n", "v" }, "<leader><CR>c", "<cmd>ChatGPTCompleteCode<CR>", { desc = "Complete Code" })
vim.keymap.set({ "n", "v" }, "<leader><CR>a", "<cmd>ChatGPTActAs<CR>", { desc = "Act As" })
vim.keymap.set({ "n", "v" }, "<leader><CR>e", "<cmd>ChatGPTEditWithInstruction<CR>", { desc = "Edit with instruction" })
vim.keymap.set({ "n", "v" }, "<leader><CR>g", "<cmd>ChatGPTRun grammar_correction<CR>", { desc = "Grammar Correction" })
vim.keymap.set({ "n", "v" }, "<leader><CR>z", "<cmd>ChatGPTRun translate<CR>", { desc = "Translate" })
vim.keymap.set({ "n", "v" }, "<leader><CR>k", "<cmd>ChatGPTRun keywords<CR>", { desc = "Keywords" })
vim.keymap.set({ "n", "v" }, "<leader><CR>d", "<cmd>ChatGPTRun docstring<CR>", { desc = "Docstring" })
vim.keymap.set({ "n", "v" }, "<leader><CR>t", "<cmd>ChatGPTRun add_tests<CR>", { desc = "Add Tests" })
vim.keymap.set({ "n", "v" }, "<leader><CR>o", "<cmd>ChatGPTRun optimize_code<CR>", { desc = "Optimize Code" })
vim.keymap.set({ "n", "v" }, "<leader><CR>s", "<cmd>ChatGPTRun summarize<CR>", { desc = "Summarize" })
vim.keymap.set({ "n", "v" }, "<leader><CR>f", "<cmd>ChatGPTRun fix_bugs<CR>", { desc = "Fix Bugs" })
vim.keymap.set({ "n", "v" }, "<leader><CR>x", "<cmd>ChatGPTRun explain_code<CR>", { desc = "Explain Code" })
vim.keymap.set({ "n", "v" }, "<leader><CR>r", "<cmd>ChatGPTRun roxygen_edit<CR>", { desc = "Roxygen Edit" })
vim.keymap.set({ "n", "v" }, "<leader><CR>l", "<cmd>ChatGPTRun code_readability_analysis<CR>",
	{ desc = "Code Readability Analysis" })

vim.keymap.set({ "n" }, "<leader><CR>q", "<cmd>Copilot disable<CR>", { desc = "Copilot disable" })
vim.keymap.set({ "n" }, "<leader><CR>Q", "<cmd>Copilot enable<CR>", { desc = "Copilot enable" })

-- spell
vim.opt.spell = true
vim.opt.spelllang = { 'en', 'nl' }

-- NPM Package Info
pcall(require("telescope").load_extension, "package_info")
vim.keymap.set({ "n" }, "<LEADER>ns", require("package-info").show, { silent = true, noremap = true, desc = 'show' })
vim.keymap.set({ "n" }, "<LEADER>nc", require("package-info").hide, { silent = true, noremap = true, desc = 'hide' })
vim.keymap.set({ "n" }, "<LEADER>nt", require("package-info").toggle, { silent = true, noremap = true, desc = 'toggle' })
vim.keymap.set({ "n" }, "<LEADER>nu", require("package-info").update, { silent = true, noremap = true, desc = 'update' })
vim.keymap.set({ "n" }, "<LEADER>nd", require("package-info").delete, { silent = true, noremap = true, desc = 'delete' })
vim.keymap.set({ "n" }, "<LEADER>ni", require("package-info").install,
	{ silent = true, noremap = true, desc = 'install' })
vim.keymap.set({ "n" }, "<LEADER>np", require("package-info").change_version,
	{ silent = true, noremap = true, desc = 'change_version' })

-- Lua
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.lua",
	callback = function()
		vim.lsp.buf.format({ timeout_ms = 1000 })
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "c", "h" },
	callback = function()
		vim.opt_local.shiftwidth = 4
		vim.opt_local.tabstop = 4
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "vhdl" },
	callback = function()
		vim.opt_local.shiftwidth = 4
		vim.opt_local.tabstop = 4
	end,
})

--  MarkdownPreview
vim.g.mkdp_browser = 'google-chrome-stable'

-- Md Preview
-- Function to set bibliography path if ref.bib exists
local function set_bibliography_path()
	local file_path = vim.fn.expand('%:p')              -- Get the full path of the current file
	local file_dir = vim.fn.fnamemodify(file_path, ':h') -- Get the directory of the current file
	local bib_file = file_dir .. '/ref.bib'             -- Path to the bibliography file

	-- Check if the bibliography file exists and is readable
	if vim.fn.filereadable(bib_file) == 1 then
		-- Set the bibliography path and other arguments if ref.bib exists
		vim.g.md_args = '--bibliography=' .. bib_file .. ' --citeproc --csl=' .. file_dir .. '/apa.csl'
	else
		-- Optionally clear the variable or set it to a default value if ref.bib does not exist
		vim.g.md_args = ''
	end
end

-- Autocommand to set the bibliography path for markdown files
vim.api.nvim_create_autocmd('FileType', {
	pattern = 'markdown',
	callback = set_bibliography_path
})

local preview_running = false
local presentation_running = false
local pdf_viewer = "zathura"
local presentation_viewer = "zathura --mode=presentation"

local function CompileSynchronous()
	local md_args = vim.g.md_args or ""
	local file_path = vim.fn.expand("%:p")
	local pdf_path = vim.fn.expand("%:p:r") .. ".pdf"
	local hyperref_options = "-V colorlinks -V linkcolor=blue -V urlcolor=red"
	local command = "pandoc -F pandoc-crossref " ..
			hyperref_options ..
			" " .. md_args .. " " .. vim.fn.shellescape(file_path) .. " -o " .. vim.fn.shellescape(pdf_path)

	os.execute(command)
end

local function CompilePresentation()
	local md_args = vim.g.md_args or ""
	local file_path = vim.fn.expand("%:p")
	local pdf_path = vim.fn.expand("%:p:r") .. ".pdf"
	local hyperref_options = "-V colorlinks -V linkcolor=blue -V urlcolor=red"
	local command = "pandoc -F pandoc-crossref -t beamer " ..
			hyperref_options ..
			" " .. md_args .. " " .. vim.fn.shellescape(file_path) .. " -o " .. vim.fn.shellescape(pdf_path)

	os.execute(command)
end

local function OpenPdf()
	if not preview_running then
		return
	end

	local pdf_path = vim.fn.expand("%:p:r") .. ".pdf"

	-- Compile the PDF
	CompileSynchronous()

	-- Open Zathura with the PDF
	os.execute(pdf_viewer .. " " .. vim.fn.shellescape(pdf_path) .. " &")
end

local function OpenPresentation()
	if not presentation_running then
		return
	end

	local pdf_path = vim.fn.expand("%:p:r") .. ".pdf"

	CompilePresentation()

	os.execute(presentation_viewer .. " " .. vim.fn.shellescape(pdf_path) .. " &")
end

local function StartPreview()
	preview_running = true
	OpenPdf()
end

local function StartPresentation()
	presentation_running = true
	OpenPresentation()
end

local function StopPreview()
	preview_running = false
end

local function StopPresentation()
	presentation_running = false
end

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = { "*.md", "*.markdown", "*.pandoc" },
	callback = function()
		if preview_running then
			CompileSynchronous()
		end
		if presentation_running then
			CompilePresentation()
		end
	end,
})

vim.api.nvim_create_user_command("StartMdPreview", StartPreview, {})
vim.api.nvim_create_user_command("StopMdPreview", StopPreview, {})
vim.api.nvim_create_user_command("StartMdPresentation", StartPresentation, {})
vim.api.nvim_create_user_command("StopMdPresentation", StopPresentation, {})

-- Latex preview
local latex_preview_running = false

local function CompileLatex()
	local file_path = vim.fn.expand("%:p") -- Full path of the LaTeX file
	local command = "latexmk -pdf -interaction=nonstopmode -synctex=1 " ..
			vim.fn.shellescape(file_path) .. " > /dev/null 2>&1"

	os.execute(command) -- Execute LaTeX compilation and suppress output
end


local function OpenLatexPdf()
	if not latex_preview_running then
		return
	end

	local pdf_path = vim.fn.expand("%:p:r") .. ".pdf"

	-- Compile the LaTeX file to PDF
	CompileLatex()

	-- Open the PDF with zathura or your preferred viewer
	os.execute(pdf_viewer .. " " .. vim.fn.shellescape(pdf_path) .. " &")
end

local function StartLatexPreview()
	latex_preview_running = true
	OpenLatexPdf()
end

local function StopLatexPreview()
	latex_preview_running = false
end

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = { "*.tex" }, -- Trigger on LaTeX files
	callback = function()
		if latex_preview_running then
			CompileLatex()
		end
	end,
})

-- Create commands for starting and stopping LaTeX preview
vim.api.nvim_create_user_command("StartLatexPreview", StartLatexPreview, {})
vim.api.nvim_create_user_command("StopLatexPreview", StopLatexPreview, {})


-- Screenshots from clipboard to markdown
vim.api.nvim_set_keymap('n', '<Leader>pp', ':call mdip#MarkdownClipboardImage()<CR>',
	{ noremap = false, silent = true, desc = 'Paste image from clipboard in markdown' })
vim.api.nvim_set_keymap('n', '<Leader>put', ":pu=strftime('%c')<CR>",
	{ noremap = false, silent = true, desc = 'Insert current time' })



-- Map <leader> followed by a number to switch to that tab
for i = 1, 9 do
	vim.keymap.set('n', '<leader>' .. i, i .. 'gt', { desc = 'Go to tab ' .. i })
end
