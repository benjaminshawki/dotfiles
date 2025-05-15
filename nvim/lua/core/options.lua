-- Core Neovim options and settings
local WINBLEND = 14

local M = {}

function M.setup()
  -- Leader key setup
  vim.g.mapleader = ' '
  vim.g.maplocalleader = ' '
  vim.o.showbreak = '↪ ' -- Sets a string to be shown before lines that have been soft-wrapped

  -- UI settings
  vim.o.pumblend = WINBLEND
  vim.o.winblend = WINBLEND
  vim.o.termguicolors = true

  -- Search settings
  vim.o.hlsearch = false
  vim.o.ignorecase = true
  vim.o.smartcase = true

  -- Line numbers
  vim.wo.number = true
  vim.wo.relativenumber = true

  -- Mouse and clipboard
  vim.o.mouse = 'a'
  vim.o.clipboard = 'unnamedplus'

  -- Indentation
  vim.o.breakindent = true
  vim.opt.shiftwidth = 2
  vim.opt.tabstop = 2

  -- Undo settings
  vim.o.undofile = true
  vim.o.swapfile = false
  vim.o.undodir = vim.fn.expand('$HOME/.config/nvim/undo')
  vim.o.undolevels = 10000
  vim.o.undoreload = 10000

  -- Editor experience
  vim.wo.signcolumn = 'yes'
  vim.o.updatetime = 250
  vim.o.timeoutlen = 300
  vim.o.completeopt = 'menuone,noinsert,noselect'

  -- Spell checking
  vim.opt.spell = true
  vim.opt.spelllang = { 'en', 'nl' }

  -- Disable perl provider
  vim.g.loaded_perl_provider = 0
end

return M
