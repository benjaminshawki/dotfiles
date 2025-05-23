-- Autocommands module

local M = {}

function M.setup()
	-- [[ Highlight on yank ]]
	-- See `:help vim.hl.on_yank()`
	local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
	vim.api.nvim_create_autocmd('TextYankPost', {
		callback = function()
			vim.hl.on_yank()
		end,
		group = highlight_group,
		pattern = '*',
	})

	-- Auto-equalize windows when terminal is resized
	vim.api.nvim_create_autocmd('VimResized', {
		callback = function()
			vim.cmd('wincmd =')
		end,
		pattern = '*',
		desc = 'Auto-equalize windows when terminal is resized',
	})

	-- Set Jenkinsfile to use groovy syntax highlighting
	vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
		pattern = { "Jenkinsfile", "Jenkinsfile*", "*.Jenkinsfile", "Jenkinsfile.*" },
		callback = function()
			vim.cmd("set filetype=groovy")
		end,
		desc = 'Set Jenkinsfile to use groovy syntax highlighting',
	})

	-- Lua files are now handled by the global formatter

	-- Set indentation for specific file types
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
end

-- Setup markdown-specific autocommands
function M.setup_markdown()
	-- Function to set bibliography path if ref.bib exists
	local function set_bibliography_path()
		local file_path = vim.fn.expand('%:p')             -- Get the full path of the current file
		local file_dir = vim.fn.fnamemodify(file_path, ':h') -- Get the directory of the current file
		local bib_file = file_dir .. '/ref.bib'            -- Path to the bibliography file

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
end

-- Setup LaTeX-specific autocommands
function M.setup_latex()
	local latex_preview_running = false
	local pdf_viewer = "zathura"

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
end

-- Setup global autoformatting toggle and Prettier toggle
function M.setup_formatting()
	-- Initialize the global toggle (default to enabled)
	vim.g["autoformat_enabled"] = 1

	local config_path = vim.fn.stdpath('config') .. '/.autoformat_enabled'
	local prettier_config_path = vim.fn.stdpath('config') .. '/.prettier_autoformat'

	-- Function to save the global autoformat value to a file
	local function save_autoformat_enabled()
		local file = io.open(config_path, 'w')
		if file then
			file:write(vim.g["autoformat_enabled"])
			file:close()
		else
			print("Error: Unable to save autoformat setting!")
		end
	end

	-- Function to save the Prettier-specific value to a file
	local function save_prettier_autoformat()
		local file = io.open(prettier_config_path, 'w')
		if file then
			file:write(vim.g["prettier#Autoformat"])
			file:close()
		else
			print("Error: Unable to save Prettier autoformat setting!")
		end
	end

	-- Function to load the global autoformat value from a file
	local function load_autoformat_enabled()
		local file = io.open(config_path, 'r')
		if file then
			local value = file:read('*a')
			file:close()
			vim.g["autoformat_enabled"] = tonumber(value) or 1
		else
			vim.g["autoformat_enabled"] = 1 -- Default to enabled if file doesn't exist
		end
	end

	-- Function to load the Prettier-specific value from a file
	local function load_prettier_autoformat()
		local file = io.open(prettier_config_path, 'r')
		if file then
			local value = file:read('*a')
			file:close()
			vim.g["prettier#Autoformat"] = tonumber(value) or 0
		else
			vim.g["prettier#Autoformat"] = 0 -- Default to disabled if file doesn't exist
		end
	end

	-- Toggle function for the global autoformat setting
	function _G.ToggleAutoformat()
		vim.g["autoformat_enabled"] = vim.g["autoformat_enabled"] == 0 and 1 or 0
		local status = vim.g["autoformat_enabled"] == 1 and "enabled" or "disabled"
		print("Autoformatting: " .. status)
		save_autoformat_enabled() -- Save after toggling
	end

	-- Toggle function for Prettier-specific autoformat
	function _G.TogglePrettierAutoformat()
		vim.g["prettier#Autoformat"] = vim.g["prettier#Autoformat"] == 0 and 1 or 0
		local status = vim.g["prettier#Autoformat"] == 1 and "enabled" or "disabled"
		print("Prettier Autoformat: " .. status)
		save_prettier_autoformat() -- Save after toggling
	end

	-- Load both settings when Neovim starts
	load_autoformat_enabled()
	load_prettier_autoformat()

	-- Prettier specific settings
	vim.g["prettier#Autoformat_require_pragma"] = 0

	-- Fix the errors in the original autoformat mechanism
	vim.cmd [[
		" Define a fixed version of Prettier's autoformat function to prevent errors
		function! PrettierFix()
			return 0
		endfunction

		" Store the original value for use in our custom function
		let g:prettier#Autoformat_orig = g:prettier#Autoformat
	]]

	-- Schedule our formatting setup to run after the plugin has loaded
	vim.defer_fn(function()
		vim.cmd [[
			" Create our custom formatting functions
			function! ShouldFormat()
				return g:autoformat_enabled
			endfunction

			function! ShouldPrettierFormat()
				return g:autoformat_enabled && g:prettier#Autoformat_orig
			endfunction

			function! FormatBuffer()
				if ShouldPrettierFormat() && (index(['javascript', 'typescript', 'vue', 'json', 'css', 'scss', 'html', 'markdown', 'yaml', 'typescriptreact', 'javascriptreact'], &filetype) >= 0)
					silent! Prettier
					return 1
				elseif ShouldFormat()
					" Only use LSP formatting if Prettier wasn't used
					silent! lua vim.lsp.buf.format({ timeout_ms = 1000 })
					return 1
				endif
				return 0
			endfunction

			" Replace the problematic function
			let g:prettier#Autoformat = function('PrettierFix')

			" Set up autoformat autocmd for every buffer write
			augroup AutoFormatGroup
				autocmd!
				autocmd BufWritePre * call FormatBuffer()
			augroup END
		]]
	end, 100) -- Small delay to ensure settings are loaded first

	-- Keybinding to toggle global formatting
	vim.api.nvim_set_keymap('n', '<leader>tf', ':lua ToggleAutoformat()<CR>',
		{ noremap = true, silent = true, desc = 'Toggle Autoformatting (all formatters)' })

	-- Keybinding to toggle Prettier formatting
	vim.api.nvim_set_keymap('n', '<leader>tp', ':lua TogglePrettierAutoformat()<CR>',
		{ noremap = true, silent = true, desc = 'Toggle Prettier Autoformatting' })
end

return M

