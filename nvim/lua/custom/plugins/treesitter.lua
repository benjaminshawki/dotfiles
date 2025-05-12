-- Optimized TreeSitter configuration
return {
  -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  build = ':TSUpdate',
  config = function()
    -- Use a staged loading approach for Treesitter
    -- First stage: Setup minimal functionality with essential languages
    require('nvim-treesitter.configs').setup {
      -- Start with only essential languages for faster startup
      ensure_installed = {
        'lua', 'vim', 'vimdoc', 'query',  -- nvim related
        'bash', 'markdown', 'markdown_inline' -- commonly used
      },
      auto_install = true,
      highlight = {
        enable = true,
        disable = { "latex" },
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
    }

    -- Second stage: Load advanced features after a short delay
    vim.defer_fn(function()
      require('nvim-treesitter.configs').setup {
        incremental_selection = {
          enable = true,
          keymaps = {
            node_incremental = '<c-space>',
            init_selection = '<c-space>',
            scope_incremental = '<c-s>',
            node_decremental = '<Esc>[32;2u',
          },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ['aa'] = '@parameter.outer',
              ['ia'] = '@parameter.inner',
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              ['ic'] = '@class.inner',
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              [']m'] = '@function.outer',
              [']]'] = '@class.outer',
            },
            goto_next_end = {
              [']M'] = '@function.outer',
              [']['] = '@class.outer',
            },
            goto_previous_start = {
              ['[m'] = '@function.outer',
              ['[['] = '@class.outer',
            },
            goto_previous_end = {
              ['[M'] = '@function.outer',
              ['[]'] = '@class.outer',
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ['<leader>j'] = '@parameter.inner',
            },
            swap_previous = {
              ['<leader>k'] = '@parameter.inner',
            },
          },
        },
      }
    end, 100)

    -- Third stage: Install all remaining languages in the background
    vim.defer_fn(function()
      require('nvim-treesitter.install').ensure_installed({
        'c', 'cpp', 'go', 'python', 'rust', 'tsx',
        'javascript', 'typescript', 'css', 'html', 'dockerfile', 'java', 'jsdoc',
        'llvm', 'make', 'sql', 'toml', 'xml', 'yaml', 'dockerfile',
        'c_sharp', 'bibtex', 'latex', 'asm', 'cmake', 'comment', 'csv', 'cuda',
        'dot', 'git_config', 'git_rebase', 'gitignore', 'graphql', 'haskell',
        'helm', 'http', 'jq', 'json', 'nix', 'ocaml', 'ocaml_interface', 'php',
        'regex', 'scala', 'sql', 'ssh_config', 'tmux', 'tsx', 'vue', 'zig', 'dart',
      })
    end, 200) -- Longer delay for background installation
  end
}