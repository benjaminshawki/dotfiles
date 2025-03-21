-- nvim-remote plugin - enables server capabilities for theme switching
local M = {}

function M.setup()
  -- Ensure neovim starts in server mode
  if vim.fn.has('nvim') == 1 then
    -- Set a unique server name if not already set
    if vim.v.servername == "" or vim.v.servername == nil then
      local random_id = tostring(math.random(1000000))
      local server_name = os.getenv("NVIM_LISTEN_ADDRESS") or 
                         ("/tmp/nvim_" .. os.getenv("USER") .. "_" .. random_id)
      
      -- Try to update the server name
      pcall(function() vim.fn.serverstart(server_name) end)
    end
    
    -- Export the server name to environment
    vim.env.NVIM_LISTEN_ADDRESS = vim.v.servername
  end
  
  -- Check for theme state file on startup
  vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
      local theme_file = vim.fn.expand("~/.theme_state")
      if vim.fn.filereadable(theme_file) == 1 then
        local theme = vim.fn.readfile(theme_file)[1]
        if theme == "light" then
          -- Check if we have GitHub theme
          pcall(function()
            vim.cmd("colorscheme github_light")
          end)
        elseif theme == "dark" then
          -- Check if we have Tokyo Night theme
          pcall(function()
            vim.cmd("colorscheme tokyonight-night")
          end)
        end
      end
    end
  })
end

return M