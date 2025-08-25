-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  -- add onedark with custom configuration
  {
    "navarasu/onedark.nvim",
    opts = {
      style = 'dark', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
      transparent = false,
      term_colors = true,
      ending_tildes = false,
      cmp_itemkind_reverse = false,
      toggle_style_key = nil,
      toggle_style_list = {'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light'},
      code_style = {
        comments = 'italic',
        keywords = 'none',
        functions = 'none',
        strings = 'none',
        variables = 'none'
      },
      lualine = {
        transparent = false,
      },
      colors = {},
      highlights = {
        ["Comment"] = {fg = '#7c7c7c', bg = '#2a2a2a', fmt = 'italic'},
        ["@comment"] = {fg = '#7c7c7c', bg = '#2a2a2a', fmt = 'italic'},
        ["@lsp.type.comment"] = {fg = '#7c7c7c', bg = '#2a2a2a', fmt = 'italic'},
      },
    },
    config = function(_, opts)
      require('onedark').setup(opts)
      require('onedark').load()
    end,
  },

  -- Configure LazyVim to load onedark
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "onedark",
    },
  },
}