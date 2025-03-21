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

  -- Function to load theme from global theme file
  function ThemeManager.loadGlobalThemeFile()
    local globalFilePath = vim.fn.stdpath('config') .. '/.nvim_theme'
    local file = io.open(globalFilePath, 'r')
    if not file then
      -- Try the home directory location
      globalFilePath = vim.fn.expand('~/.theme_state')
      file = io.open(globalFilePath, 'r')
      if not file then
        return nil -- Global theme file not found
      end
      
      -- Read theme state (light/dark) instead of theme name
      local state = file:read("*a"):gsub("%s+", "")
      file:close()
      
      -- Convert state to theme name
      if state == "light" then
        return "github_light"
      else
        return "tokyonight-night"
      end
    end
    
    local theme = file:read("*a"):gsub("%s+", "") -- Remove whitespace
    file:close()
    return theme
  end
  
  -- Function to detect system theme preference
  function ThemeManager.detectSystemPreference()
    -- Try to use the theme state file
    local state_file = io.open(vim.fn.expand('~/.theme_state'), 'r')
    if state_file then
      local state = state_file:read("*a"):gsub("%s+", "")
      state_file:close()
      
      if state == "light" then
        return "github_light"
      else
        return "tokyonight-night"
      end
    end
    
    -- Default to dark theme
    return "tokyonight-night"
  end
  
  -- On Neovim startup, load the theme (prioritize global theme file)
  local global_theme = ThemeManager.loadGlobalThemeFile()
  local local_theme = ThemeManager.loadThemeFromFile()
  local system_theme = ThemeManager.detectSystemPreference()
  
  if global_theme then
    -- Global theme file has priority
    ThemeManager.applyTheme(global_theme)
  elseif local_theme then
    -- Fall back to local theme file
    ThemeManager.applyTheme(local_theme)
  elseif system_theme then
    -- Fall back to system preference
    ThemeManager.applyTheme(system_theme)
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
  
  -- Catppuccin theme mappings
  vim.keymap.set('n', '<leader>ttcl', function() ThemeManager.switchTheme('catppuccin-latte') end,
    { desc = 'Switch to Catppuccin Latte (Light) Theme' })
  vim.keymap.set('n', '<leader>ttcf', function() ThemeManager.switchTheme('catppuccin-frappe') end,
    { desc = 'Switch to Catppuccin Frappe Theme' })
  vim.keymap.set('n', '<leader>ttcm', function() ThemeManager.switchTheme('catppuccin-macchiato') end,
    { desc = 'Switch to Catppuccin Macchiato Theme' })
  vim.keymap.set('n', '<leader>ttco', function() ThemeManager.switchTheme('catppuccin-mocha') end,
    { desc = 'Switch to Catppuccin Mocha Theme' })
  
  -- GitHub theme mappings
  vim.keymap.set('n', '<leader>ttgd', function() ThemeManager.switchTheme('github_dark') end,
    { desc = 'Switch to GitHub Dark Theme' })
  vim.keymap.set('n', '<leader>ttgl', function() ThemeManager.switchTheme('github_light') end,
    { desc = 'Switch to GitHub Light Theme' })
  vim.keymap.set('n', '<leader>ttgdh', function() ThemeManager.switchTheme('github_dark_high_contrast') end,
    { desc = 'Switch to GitHub Dark High Contrast Theme' })
  vim.keymap.set('n', '<leader>ttgdd', function() ThemeManager.switchTheme('github_dark_dimmed') end,
    { desc = 'Switch to GitHub Dark Dimmed Theme' })
    
  -- System theme mappings
  vim.keymap.set('n', '<leader>tts1', function()
    -- Switch to system light theme 
    vim.fn.system("$HOME/dotfiles/scripts/theme-switcher.sh light")
    ThemeManager.switchTheme('github_light')
  end, { desc = 'Switch to System Light Theme' })
  
  vim.keymap.set('n', '<leader>tts0', function()
    -- Switch to system dark theme
    vim.fn.system("$HOME/dotfiles/scripts/theme-switcher.sh dark")
    ThemeManager.switchTheme('tokyonight-night')
  end, { desc = 'Switch to System Dark Theme' })
  
  -- Setup autocommand to detect theme changes
  vim.api.nvim_create_autocmd({"FocusGained", "BufEnter"}, {
    callback = function()
      -- Only check occasionally to avoid excessive disk reads
      local now = os.time()
      if not ThemeManager.last_check or now - ThemeManager.last_check > 5 then
        ThemeManager.last_check = now
        
        -- Check for system theme state
        local state_file = io.open(vim.fn.expand('~/.theme_state'), 'r')
        if state_file then
          local state = state_file:read("*a"):gsub("%s+", "")
          state_file:close()
          
          -- Get current colorscheme
          local current = vim.g.colors_name or ""
          
          -- Apply theme if it doesn't match system preference
          if state == "light" and not current:match("light") and not current:match("latte") then
            ThemeManager.switchTheme('github_light')
          elseif state == "dark" and (current:match("light") or current:match("latte")) then
            ThemeManager.switchTheme('tokyonight-night')
          end
        end
      end
    end,
    desc = "Check for system theme changes"
  })

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