-- Optimized nvim-cmp configuration
return {
  -- Autocompletion
  'hrsh7th/nvim-cmp',
  event = { "InsertEnter", "CmdlineEnter" }, -- Load only when entering insert mode or command line
  dependencies = {
    -- Snippet Engine & its associated nvim-cmp source
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',

    -- Adds LSP completion capabilities
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',

    -- Adds a number of user-friendly snippets
    'rafamadriz/friendly-snippets',
    {
      "mlaursen/vim-react-snippets",
      ft = { "javascriptreact", "typescriptreact" }, -- Only load for React files
    },
  },
  config = function()
    local cmp = require('cmp')
    local luasnip = require('luasnip')

    -- Defer loading snippets for better performance
    vim.defer_fn(function()
      require('luasnip.loaders.from_vscode').lazy_load()
      require("luasnip.loaders.from_lua").lazy_load({ paths = "$HOME/.config/nvim/lua/custom/snippets" })
    end, 100)

    -- Simpler configuration
    luasnip.config.setup {
      history = true,
      enable_autosnippets = true
    }

    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      completion = {
        completeopt = 'menu,menuone,noinsert',
      },
      mapping = cmp.mapping.preset.insert {
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete {},
        ['<CR>'] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      },
      sources = {
        { name = 'copilot' },
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
        { name = "dap" },
      },
    }
  end
}