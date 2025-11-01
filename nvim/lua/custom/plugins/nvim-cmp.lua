-- Optimized nvim-cmp configuration
return {
  -- Autocompletion
  'hrsh7th/nvim-cmp',
  event = { 'InsertEnter', 'CmdlineEnter' }, -- Load only when entering insert mode or command line
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
      'mlaursen/vim-react-snippets',
      ft = { 'javascriptreact', 'typescriptreact' }, -- Only load for React files
    },
  },
  config = function()
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'

    -- Defer loading snippets for better performance
    vim.defer_fn(function()
      require('luasnip.loaders.from_vscode').lazy_load()
      require('luasnip.loaders.from_lua').lazy_load { paths = '$HOME/.config/nvim/lua/custom/snippets' }
    end, 100)

    -- Simpler configuration
    luasnip.config.setup {
      history = true,
      enable_autosnippets = true,
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
        ['<C-e>'] = cmp.mapping(function()
          if cmp.visible() and cmp.get_selected_entry() then
            local entry = cmp.get_selected_entry()

            -- Store the text after cursor that we want to preserve
            local cursor = vim.api.nvim_win_get_cursor(0)
            local line = vim.api.nvim_get_current_line()
            local row, col = cursor[1], cursor[2]

            -- Find what would be replaced
            local replace_range = entry:get_replace_range()
            local replace_end_col = replace_range['end'].character

            -- Get text after cursor that would be replaced
            local text_to_preserve = ''
            if replace_end_col > col then
              text_to_preserve = line:sub(col + 1, replace_end_col)
            end

            -- Confirm with Insert behavior
            cmp.confirm {
              behavior = cmp.ConfirmBehavior.Insert,
              select = true,
            }

            -- If we need to preserve text, add it back
            if text_to_preserve ~= '' then
              vim.schedule(function()
                local new_cursor = vim.api.nvim_win_get_cursor(0)
                vim.api.nvim_buf_set_text(0, new_cursor[1] - 1, new_cursor[2], new_cursor[1] - 1, new_cursor[2], { text_to_preserve })
              end)
            end
          else
            cmp.close()
          end
        end, { 'i', 's' }),
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
        { name = 'dap' },
      },
    }
  end,
}
