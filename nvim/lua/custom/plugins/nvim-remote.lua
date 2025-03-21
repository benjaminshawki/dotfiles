-- Local plugin to enable Neovim server mode for remote control
return {
  dir = vim.fn.stdpath('config') .. '/lua/custom/local-plugins/nvim-remote',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    -- Enable neovim server mode for remote control
    vim.g.autostart_server = true
    
    -- This ensures neovim listens for remote commands when started
    vim.cmd([[
      if executable('nvr')
        let $NVIM_LISTEN_ADDRESS = v:servername
      endif
    ]])
  end,
}