local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ' '

require("lazy").setup({
     'chrisbra/csv.vim',
     'moll/vim-bbye',
     'simeji/winresizer',
     'junegunn/fzf.vim',
     'simnalamburt/vim-mundo',
     'christoomey/vim-tmux-navigator',
     'github/copilot.vim',
})

-- Basic Settings
vim.o.clipboard = 'unnamedplus'
vim.o.swapfile = false
vim.o.undofile = true
vim.o.undodir = vim.fn.expand('$HOME/.config/nvim/undo')
vim.o.undolevels = 10000
vim.o.undoreload = 10000
vim.wo.number = true
vim.wo.relativenumber = true

-- Indentation Settings
vim.o.autoindent = true
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

-- Key Mappings
vim.api.nvim_set_keymap('n', '<space>', '<nop>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>bn', ':bn<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>tn', 'gt', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-w>h', '<C-w>s', {noremap = true})

-- Plugin Settings
vim.g.copilot_filetypes = {markdown = true}
