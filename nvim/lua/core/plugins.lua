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

		-- Color schemes
		{
			"folke/tokyonight.nvim",
			lazy = false,
			priority = 1000,
			opts = {}
		},
		{
			"catppuccin/nvim",
			name = "catppuccin",
			lazy = false,
			priority = 1000,
			opts = {}
		},
		{
			"projekt0n/github-nvim-theme",
			lazy = false,
			priority = 1000,
			config = function()
				require("github-theme").setup({})
			end
		},

		-- Status line
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
		{ "artemave/workspace-diagnostics.nvim" },

		-- Treesitter
		{
			-- Highlight, edit, and navigate code
			'nvim-treesitter/nvim-treesitter',
			dependencies = {
				'nvim-treesitter/nvim-treesitter-textobjects',
			},
			build = ':TSUpdate',
		},

		-- Buffer and window management
		'moll/vim-bbye',
		'simeji/winresizer',

		-- Fuzzy finding
		{
			"junegunn/fzf",
			build = "./install --bin"
		},

		-- Text manipulation
		'machakann/vim-sandwich',
		'wincent/ferret',

		-- Linting
		'neomake/neomake',

		-- tmux integration
		'wellle/tmux-complete.vim',
		'simnalamburt/vim-mundo',
		'christoomey/vim-tmux-navigator',

		-- Misc utilities
		'jez/vim-superman', -- Man page viewer
		'github/copilot.vim', -- GitHub Copilot

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

		-- ChatGPT integration
		-- {
		-- 	"benjaminshawki/ChatGPT.nvim",
		-- 	event = "VeryLazy",
		-- 	dependencies = {
		-- 		"MunifTanjim/nui.nvim",
		-- 		"nvim-lua/plenary.nvim",
		-- 		"folke/trouble.nvim",
		-- 		"nvim-telescope/telescope.nvim"
		-- 	},
		-- },

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
			dependencies = {
				"nvim-telescope/telescope.nvim",
				"MunifTanjim/nui.nvim",
				"nvim-lua/plenary.nvim",
				"kevinhwang91/promise-async",
				"hrsh7th/nvim-cmp",
			},
			config = function()
				require("laravel").setup()
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

	-- Configure Telescope
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

	-- Configure Comment.nvim with ts_context_commentstring
	require('Comment').setup {
		pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
	}

	-- -- Configure ChatGPT.nvim
	-- local home = vim.fn.expand("$HOME")
	-- require("chatgpt").setup({
	-- 	api_key_cmd = "gpg --decrypt " .. home .. "/secret.txt.gpg",
	-- 	open_ai_params = {
	-- 		model = "gpt-4-turbo-preview",
	-- 	},
	-- 	openai_edit_params = {
	-- 		model = "gpt-4-turbo-preview",
	-- 	},
	-- })

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
		vue = true,
	}
	vim.g.copilot_debug = true
	vim.keymap.del('i', '<Tab>')
	vim.g.copilot_no_tab_map = true
	vim.keymap.set('i', '<M-Y>', 'copilot#Accept("<CR>")', { expr = true, replace_keycodes = false, silent = true })
	vim.keymap.set('i', '<M-y>', '<Plug>(copilot-accept-word)')

	-- Configure Markdown Preview
	vim.g.mkdp_browser = 'google-chrome-stable'

	-- Set up Treesitter
	-- Defer Treesitter setup after first render to improve startup time
	vim.defer_fn(function()
		require('nvim-treesitter.configs').setup {
			-- Add languages to be installed here that you want installed for treesitter
			ensure_installed = {
				'c', 'cpp', 'go', 'lua', 'luadoc', 'python', 'rust', 'tsx',
				'javascript', 'typescript', 'vimdoc', 'vim', 'bash', 'markdown',
				'markdown_inline', 'css', 'html', 'dockerfile', 'java', 'jsdoc',
				'llvm', 'make', 'sql', 'toml', 'query', 'xml', 'yaml', 'dockerfile',
				'c_sharp', 'bibtex', 'latex', 'asm', 'cmake', 'comment', 'csv', 'cuda',
				'dot', 'git_config', 'git_rebase', 'gitignore', 'graphql', 'haskell',
				'helm', 'http', 'jq', 'json', 'nix', 'ocaml', 'ocaml_interface', 'php',
				'regex', 'scala', 'sql', 'ssh_config', 'tmux', 'tsx', 'vue', 'zig',
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
end

return M