-- Plugin for measuring and analyzing Neovim startup time
return {
  "dstein64/vim-startuptime",
  cmd = "StartupTime",
  config = function()
    vim.g.startuptime_tries = 10 -- Run multiple times for better averages
    vim.g.startuptime_exe_args = { "+let g:auto_session_enabled = 0" } -- Disable auto-session if you use it
  end,
}