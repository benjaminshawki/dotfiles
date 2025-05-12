-- Vue TypeScript support using ts_ls with Vue plugin
return {
	-- Configure LSP with ts_ls for Vue
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			local lspconfig = require("lspconfig")
			local on_attach = function(client, bufnr)
				-- Default handlers for LSP
				local builtin = require('telescope.builtin')

				-- Key mappings
				local nmap = function(keys, func, desc)
					if desc then desc = 'LSP: ' .. desc end
					vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
				end

				nmap('gd', builtin.lsp_definitions, '[G]oto [D]efinition')
				nmap('gr', builtin.lsp_references, '[G]oto [R]eferences')
				nmap('gI', builtin.lsp_implementations, '[G]oto [I]mplementation')
				nmap('gy', builtin.lsp_type_definitions, '[G]oto [T]ypeDefinition')
				nmap('<leader>D', builtin.lsp_type_definitions, 'Type [D]efinition')
				nmap('<leader>cs', builtin.lsp_document_symbols, 'Document [S]ymbols')
				nmap('<leader>cw', builtin.lsp_dynamic_workspace_symbols, 'Workspace [S]ymbols')
				nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
				nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
			end

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

			-- Setup ts_ls with Vue TypeScript plugin
			lspconfig.ts_ls.setup {
				on_attach = on_attach,
				capabilities = capabilities,
				init_options = {
					plugins = {
						{
							name = "@vue/typescript-plugin",
							location = os.getenv("HOME") .. "/.volta/tools/image/packages/@vue/typescript-plugin/lib/node_modules/@vue/typescript-plugin",
							languages = { "vue" },
						},
					},
				},
				filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
			}

			-- Setup Volar for Vue
			lspconfig.volar.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				filetypes = { "vue" },
			})

			-- Additional servers
			local servers = { "html", "cssls", "eslint" }
			for _, lsp in ipairs(servers) do
				lspconfig[lsp].setup {
					on_attach = on_attach,
					capabilities = capabilities,
				}
			end
		end
	},

}
