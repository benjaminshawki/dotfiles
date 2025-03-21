-- Plugin entry point
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- Load and setup the nvim-remote module
    require("nvim-remote").setup()
  end,
  once = true,
})