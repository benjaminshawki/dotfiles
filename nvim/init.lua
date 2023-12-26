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
    'moll/vim-bbye',
    'simeji/winresizer',
    -- 'junegunn/fzf.vim',
    { "junegunn/fzf", build = "./install --bin" },
    'simnalamburt/vim-mundo',
    'christoomey/vim-tmux-navigator',
    'rafamadriz/friendly-snippets', 
    
    'machakann/vim-sandwich',
    'wincent/ferret',
    -- linter
    'neomake/neomake',

    -- tmux
    'wellle/tmux-complete.vim',
   
    'dasupradyumna/midnight.nvim', 
    {'nvim-treesitter/nvim-treesitter', cmd = 'TSUpdate' },
    {
      "ibhagwan/fzf-lua",
      -- optional for icon support
      dependencies = { "nvim-tree/nvim-web-devicons" },
      config = function()
        -- calling `setup` is optional for customization
        require("fzf-lua").setup({})
      end
    },
    'jez/vim-superman'
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

-- Theme
vim.cmd.colorscheme 'midnight'

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "markdown", "markdown_inline", "typescript", "javascript", "css", "html", "dockerfile", "java", "jsdoc", "json", "llvm", "lua", "luadoc", "make", "python", "rust", "sql", "toml", "tsx", "vim", "vimdoc", "query", "xml", "yaml" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (or "all")
  -- ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    -- disable = { "c", "rust" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
