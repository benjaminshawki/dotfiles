-- Enhanced snippets configuration with jsregexp support
return {
  {
    "L3MON4D3/LuaSnip",
    -- Override the version from core to add build command
    version = "v2.*",
    build = "make install_jsregexp",  -- This will install the jsregexp dependency
    config = function()
      -- Additional LuaSnip configuration if needed
      require('luasnip').setup({
        history = true,
        updateevents = "TextChanged,TextChangedI",
        enable_autosnippets = true,
        -- Enable the use of jsregexp in snippets
        ext_opts = {
          [require('luasnip.util.types').choiceNode] = {
            active = {
              virt_text = { { "●", "GruvboxOrange" } }
            }
          }
        }
      })
    end
  }
}