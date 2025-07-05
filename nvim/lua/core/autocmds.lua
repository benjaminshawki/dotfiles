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

-- Setup formatting (prettier disabled on save)
function M.setup_formatting()
	-- Disable all prettier autoformat
	vim.g["prettier#autoformat"] = 0
	vim.g["prettier#Autoformat"] = 0
	vim.g["prettier#Autoformat_require_pragma"] = 0
end

return M

