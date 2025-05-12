-- Plugins configuration module

local M = {}

function M.setup()
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

	-- Plugin specs
	local plugins = {
		-- Git related plugins
		'tpope/vim-fugitive',
		'tpope/vim-rhubarb',

		-- LSP Configuration & Plugins
		{
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

		-- Autocompletion is now handled by custom/plugins/nvim-cmp.lua
		-- with lazy loading on InsertEnter and CmdlineEnter

		-- Useful plugin to show you pending keybinds.
		{
			'folke/which-key.nvim',
			event = "VeryLazy",
			dependencies = {
				"echasnovski/mini.icons"
			},
		},

		-- LazyGit integration
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

		-- Git signs
		-- GitSigns moved to custom/plugins/gitsigns.lua with lazy loading

		-- Color scheme
		{
			"folke/tokyonight.nvim",
			lazy = false,
			priority = 1000,
			opts = {}
		},

		-- Status line
		-- Set lualine as statusline
		{
			'nvim-lualine/lualine.nvim',
			-- See `:help lualine.txt`
			event = "VeryLazy", -- Load after initial startup
			opts = {
				options = {
					icons_enabled = false,
					theme = 'tokyonight',
					component_separators = '|',
					section_separators = '',
				},
			},
		},

		-- Indentation guides
		{
			-- Add indentation guides even on blank lines
			'lukas-reineke/indent-blankline.nvim',
			-- Enable `lukas-reineke/indent-blankline.nvim`
			-- See `:help ibl`
			main = 'ibl',
			opts = {},
		},

		-- Commenting
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

		-- Workspace diagnostics
		{
			"artemave/workspace-diagnostics.nvim",
			event = "LspAttach", -- Only load when LSP attaches to buffer
			cmd = { "WorkspaceDiagnostics" },
		},

		-- Treesitter
		-- Treesitter is now optimized in custom/plugins/treesitter.lua

		-- Buffer and window management
		{
			'moll/vim-bbye',
			cmd = { "Bdelete", "Bwipeout" },
		},
		{
			'simeji/winresizer',
			cmd = "WinResizerStartResize",
			keys = { "<C-e>" }, -- Assuming this is the default key mapping
		},

		-- Fuzzy finding
		{
			"junegunn/fzf",
			build = "./install --bin",
			event = "VeryLazy", -- Load a bit later
		},

		-- Text manipulation
		{
			'machakann/vim-sandwich',
			event = { "BufReadPost", "BufNewFile" }, -- Load when buffer is read
		},
		{
			'wincent/ferret',
			cmd = { "Ack", "Acks", "Lack", "Lacks", "Back", "Black" }, -- All Ferret commands without invalid ones
			init = function()
				-- Disable all default Ferret mappings
				vim.g.FerretMap = 0
			end,
		},

		-- Linting
		{
			'neomake/neomake',
			event = { "BufWritePost" }, -- Only load when saving files
			cmd = { "Neomake" },
		},

		-- tmux integration
		{
			'wellle/tmux-complete.vim',
			cond = function()
				return os.getenv("TMUX") ~= nil
			end,
			event = "InsertEnter", -- Only load when entering insert mode
		},
		{
			'simnalamburt/vim-mundo',
			cmd = { "MundoShow", "MundoToggle" }, -- Only load when command is run
		},
		{
			'christoomey/vim-tmux-navigator',
			cond = function()
				return os.getenv("TMUX") ~= nil
			end,
			event = "VeryLazy", -- Can be loaded a bit later
		},

		-- Misc utilities
		{
			'jez/vim-superman', -- Man page viewer
			cmd = "SuperMan",
		},
		{
			'github/copilot.vim', -- GitHub Copilot
			event = { "InsertEnter" }, -- Only load in insert mode
		},

		-- Markdown preview
		{
			"iamcco/markdown-preview.nvim",
			cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
			ft = { "markdown" },
			build = function() vim.fn["mkdp#util#install"]() end,
		},

		-- NPM package info
		{
			"vuki656/package-info.nvim",
			ft = "json",
			dependencies = "MunifTanjim/nui.nvim",
			opts = {},
		},

		-- Prettier formatting
		{
			"prettier/vim-prettier",
			run = "yarn install",
			ft = { "javascript", "typescript", "typescriptreact", "javascriptreact", "mjs", "mts", "css", "less", "scss", "json", "graphql", "vue", "yaml", "html", "markdown" },
		},

		-- Navigation and file management
		"nanotee/zoxide.vim",
		"mbbill/undotree",
		"editorconfig/editorconfig-vim",


		-- Diagnostics, references, etc
		{
			"folke/trouble.nvim",
			opts = {
				auto_preview = true,
				auto_refresh = true,
				use_diagnostic_signs = true,
				action_keys = {
					refresh = "r", -- manually refresh
				}
			},
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
					"<leader>xw",
					function()
						for _, client in ipairs(vim.lsp.get_clients()) do
							require("workspace-diagnostics").populate_workspace_diagnostics(client, 0)
						end
						vim.cmd("Trouble diagnostics toggle")
					end,
					desc = "Workspace Diagnostics (Trouble)",
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

		-- Random ID generator
		{
			"benjaminshawki/nvim-random-id",
			config = function()
				require('nvim-random-id').setup()
			end,
		},

		-- Code outline
		{
			'stevearc/aerial.nvim',
			opts = {},
			-- Optional dependencies
			dependencies = {
				"nvim-treesitter/nvim-treesitter",
				"nvim-tree/nvim-web-devicons"
			},
		},

		-- Image pasting
		"img-paste-devs/img-paste.vim",

		-- Emmet for HTML/CSS
		{
			"olrtg/nvim-emmet",
			config = function()
				vim.keymap.set({ "n", "v" }, '<leader>xe', require('nvim-emmet').wrap_with_abbreviation)
			end,
		},

		-- LaTeX integration
		{
			"lervag/vimtex",
			ft = { "tex", "plaintex", "latex" },
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

		-- -- TypeScript tools
		-- {
		-- 	"pmizio/typescript-tools.nvim",
		-- 	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		-- 	opts = {},
		-- },

		-- Laravel support
		{
			"adalessa/laravel.nvim",
			ft = { "php", "blade" },
			dependencies = {
				"nvim-telescope/telescope.nvim",
				"MunifTanjim/nui.nvim",
				"nvim-lua/plenary.nvim",
				"kevinhwang91/promise-async",
				"hrsh7th/nvim-cmp",
			},
			config = function()
				require("laravel").setup({
					-- Only enable in Laravel projects
					active = function()
						local root = vim.fn.getcwd()
						-- Check if artisan file exists or composer.json contains laravel/framework
						return vim.fn.filereadable(root .. "/artisan") == 1 or
							(vim.fn.filereadable(root .. "/composer.json") == 1 and
								vim.fn.system("grep -q laravel/framework " .. root .. "/composer.json") == 0)
					end
				})
			end,
		},

		-- Import custom plugins
		{ import = 'custom.plugins' },
	}

	-- Configure lazy with the plugins
	require('lazy').setup(plugins, {})

	-- Configure Aerial
	require("aerial").setup({
		-- optionally use on_attach to set keymaps when aerial has attached to a buffer
		on_attach = function(bufnr)
			-- Jump forwards/backwards with '{' and '}'
			vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
			vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
		end,
	})

	-- Defer Telescope configuration for faster startup
	vim.defer_fn(function()
		require('telescope').setup {
			defaults = {
				mappings = {
					i = {
						['<C-u>'] = false,
						['<C-d>'] = false,
					},
				},
				winblend = 14,
				layout_config = {
					width = .99,
					height = .99,
				},
			},
		}

		-- Enable telescope fzf native, if installed
		pcall(require('telescope').load_extension, 'fzf')
	end, 50)

	-- Configure Comment.nvim with ts_context_commentstring
	require('Comment').setup {
		pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
	}


	-- Configure Copilot
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
	vim.keymap.del('i', '<Tab>')
	vim.g.copilot_no_tab_map = true
	vim.keymap.set('i', '<M-Y>', 'copilot#Accept("<CR>")', { expr = true, replace_keycodes = false, silent = true })
	vim.keymap.set('i', '<M-y>', '<Plug>(copilot-accept-word)')

	-- Configure Markdown Preview
	vim.g.mkdp_browser = 'google-chrome-stable'

	-- Treesitter setup moved to custom/plugins/treesitter.lua for optimized loading
end

return M

