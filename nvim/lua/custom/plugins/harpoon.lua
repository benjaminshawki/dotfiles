return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { 
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		local harpoon = require("harpoon")
		local extensions = require("harpoon.extensions")

		-- Configure harpoon with custom settings
		harpoon:setup({
			settings = {
				save_on_toggle = true,
				sync_on_ui_close = true,
			},
			-- Create a second list for documentation files
			docs = {
				-- Mark files that should be considered documentation
				create_list_item = function(_, path)
					return {
						value = path or vim.api.nvim_buf_get_name(0),
						context = {
							is_doc = string.match(path or vim.api.nvim_buf_get_name(0), "%.md$")
								or string.match(path or vim.api.nvim_buf_get_name(0), "%.txt$")
						}
					}
				end,
			}
		})

		-- Basic keymaps
		vim.keymap.set("n", "<leader>pe", function() harpoon:list():add() end, { desc = "Harpoon add file" })
		vim.keymap.set("n", "<leader>pl", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon list files" })

		vim.keymap.set("n", "<leader>p1", function() harpoon:list():select(1) end, { desc = "Harpoon select file 1" })
		vim.keymap.set("n", "<leader>p2", function() harpoon:list():select(2) end, { desc = "Harpoon select file 2" })
		vim.keymap.set("n", "<leader>p3", function() harpoon:list():select(3) end, { desc = "Harpoon select file 3" })
		vim.keymap.set("n", "<leader>p4", function() harpoon:list():select(4) end, { desc = "Harpoon select file 4" })

		-- Toggle previous & next buffers stored within Harpoon list
		vim.keymap.set("n", "<leader>pp", function() harpoon:list():prev() end, { desc = "Harpoon previous file" })
		vim.keymap.set("n", "<leader>pn", function() harpoon:list():next() end, { desc = "Harpoon next file" })

		-- Docs list access
		vim.keymap.set("n", "<leader>pd", function() harpoon:list("docs"):add() end, { desc = "Harpoon add to docs" })
		vim.keymap.set("n", "<leader>pD", function() harpoon.ui:toggle_quick_menu(harpoon:list("docs")) end, { desc = "Harpoon docs list" })

		-- Telescope integration
		local function toggle_telescope(harpoon_files)
			local conf = require("telescope.config").values
			local file_paths = {}
			for _, item in ipairs(harpoon_files.items) do
				table.insert(file_paths, item.value)
			end

			require("telescope.pickers").new({}, {
				prompt_title = "Harpoon",
				finder = require("telescope.finders").new_table({
					results = file_paths,
				}),
				previewer = conf.file_previewer({}),
				sorter = conf.generic_sorter({}),
			}):find()
		end
		
		vim.keymap.set("n", "<leader>pt", function() toggle_telescope(harpoon:list()) end, { desc = "Harpoon telescope" })

		-- Add UI extensions for split viewing
		harpoon:extend({
			UI_CREATE = function(cx)
				vim.keymap.set("n", "<C-v>", function()
					harpoon.ui:select_menu_item({ vsplit = true })
				end, { buffer = cx.bufnr })

				vim.keymap.set("n", "<C-x>", function()
					harpoon.ui:select_menu_item({ split = true })
				end, { buffer = cx.bufnr })

				vim.keymap.set("n", "<C-t>", function()
					harpoon.ui:select_menu_item({ tabedit = true })
				end, { buffer = cx.bufnr })
			end,
		})

		-- Add useful builtin extensions
		harpoon:extend(extensions.builtins.highlight_current_file())
		harpoon:extend(extensions.builtins.navigate_with_number())
	end
}
