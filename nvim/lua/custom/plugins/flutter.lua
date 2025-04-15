-- Flutter development tools
return {
  'akinsho/flutter-tools.nvim',
  lazy = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'stevearc/dressing.nvim', -- optional for vim.ui.select
  },
  config = function()
    require("flutter-tools").setup {
      lsp = {
        color = { -- show the derived colors for dart variables
          enabled = true,
          background = false, -- highlight the background
        },
        settings = {
          showTodos = true,
          completeFunctionCalls = true,
          analysisExcludedFolders = {"<path-to-flutter-sdk-packages>"},
          renameFilesWithClasses = "prompt", -- "always"
          enableSnippets = true,
        }
      },
      widget_guides = {
        enabled = true,
      },
      dev_log = {
        enabled = true,
        open_cmd = "tabedit", -- command to use to open the log buffer
      },
      dev_tools = {
        autostart = false, -- autostart devtools server if not detected
        auto_open_browser = false, -- auto open devtools in browser
      },
      outline = {
        open_cmd = "30vnew", -- command to use to open the outline buffer
        auto_open = false, -- auto open if workspace supports it
      },
    }
    
    -- Add keymaps for flutter commands
    vim.keymap.set("n", "<leader>fr", ":FlutterRun<CR>")
    vim.keymap.set("n", "<leader>fq", ":FlutterQuit<CR>")
    vim.keymap.set("n", "<leader>fr", ":FlutterReload<CR>")
    vim.keymap.set("n", "<leader>fR", ":FlutterRestart<CR>")
    vim.keymap.set("n", "<leader>fd", ":FlutterDevices<CR>")
    vim.keymap.set("n", "<leader>fe", ":FlutterEmulators<CR>")
  end
}