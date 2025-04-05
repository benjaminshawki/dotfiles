-- Theme management module

local M = {}

function M.setup()
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
    M.update_lualine_tabline()
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

  -- Set up ThemeManager in the module for access
  M.ThemeManager = ThemeManager
end

-- Function to update lualine's tabline based on the number of tabs
function M.update_lualine_tabline()
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

function M.setup_tab_autocmds()
  -- Autocommand to update the tabline when tabs are opened or closed
  vim.api.nvim_create_autocmd({ 'TabNew', 'TabClosed' }, {
    callback = function()
      -- Defer the update to ensure the tab count is accurate
      vim.defer_fn(M.update_lualine_tabline, 0)
    end,
  })
end

return M