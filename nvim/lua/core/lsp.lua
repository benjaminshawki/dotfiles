-- LSP Configuration module

local M = {}

function M.setup()
	-- This function gets run when an LSP connects to a particular buffer.
	local on_attach = function(client, bufnr)
		local builtin = require('telescope.builtin')

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
					-- Only format if global autoformatting is enabled
					if vim.g["autoformat_enabled"] == 1 then
						vim.lsp.buf.format({ bufnr = bufnr })
					end
				end
			})
		end

		require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)

		nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
		nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

		nmap('gd', builtin.lsp_definitions, '[G]oto [D]efinition')
		nmap('gr', builtin.lsp_references, '[G]oto [R]eferences')
		nmap('gI', builtin.lsp_implementations, '[G]oto [I]mplementation')
		nmap('gy', builtin.lsp_type_definitions, '[G]oto [T]ypeDefinition')
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

	-- Configure diagnostics
	vim.diagnostic.config {
		float = {
			winblend = 14,
		},
	}

	-- Setup neovim lua configuration
	require('neodev').setup()

	-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

	-- List of LSP servers to setup
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

	-- mason-lspconfig requires that these setup functions are called in this order
	-- before setting up the servers.
	require('mason').setup({ PATH = "prepend" })
	require('mason-lspconfig').setup()

	-- Ensure the servers above are installed
	local mason_lspconfig = require 'mason-lspconfig'

	mason_lspconfig.setup {
		ensure_installed = vim.tbl_keys(servers),
		handlers = {
			function(server_name)
				require('lspconfig')[server_name].setup {
					capabilities = capabilities,
					on_attach = on_attach,
					settings = servers[server_name],
					filetypes = (servers[server_name] or {}).filetypes,
					handlers = {
						["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { winblend = 14 }),
						["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { winblend = 14 }),
					},
				}
			end,
		}
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
	require('lspconfig').vhdl_ls.setup {
		cmd = { "vhdl_ls" }, -- Ensure vhdl_ls is installed and in PATH
		root_dir = function(_)
			return vim.loop.cwd() -- Set root directory to the current working directory
		end,
		on_attach = function(client)
			print("VHDL LS attached to " .. client.name)
		end,
	}

	-- TeXLab setup
	require('lspconfig').texlab.setup {
		filetypes = { "tex", "latex", "bib", "markdown" },
		on_attach = on_attach,
		settings = {
			texlab = {
				diagnosticsDelay = 3000,
				formatterLineLength = 120,
			},
		},
		flags = {
			debounce_text_changes = 300,
		},
	}

	-- Initialize workspace-diagnostics
	require("workspace-diagnostics").setup({
		workspace_files = function()
			return vim.fn.systemlist("git ls-files")
		end,
	})
end

-- Setup completion
function M.setup_completion()
	-- [[ Configure nvim-cmp ]]
	-- See `:help cmp`
	local cmp = require('cmp')
	require("vim-react-snippets").lazy_load()
	local luasnip = require('luasnip')
	require('luasnip.loaders.from_vscode').lazy_load()
	require("luasnip.loaders.from_lua").lazy_load({ paths = "$HOME/.config/nvim/lua/custom/snippets" })
	luasnip.config.setup {
		history = true,
		updateevents = "TextChanged,TextChangedI",
		enable_autosnippets = true
	}

	cmp.setup {
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
end

return M
