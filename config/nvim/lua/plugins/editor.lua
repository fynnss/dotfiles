return {
  -- File explorer
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup {}
    end,
  },
  -- Surround
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end
  },
  -- Substitute
  {
    "gbprod/substitute.nvim",
    opts = {},
    keys = {
      { "s", mode = { "n" }, function() require('substitute').operator() end, desc = "Substitute" },
      { "ss", mode = { "n" }, function() require('substitute').line() end, desc = "Substitute line" },
      { "S", mode = { "n" }, function() require('substitute').eol() end, desc = "Substitute to end of line" },
      { "s", mode = { "x" }, function() require('substitute').visual() end, desc = "Substitute visual" },
    },
  },
  -- Auto sessions
  {
    "rmagatti/auto-session",
    config = function()
      require("auto-session").setup {
        log_level = "error",
        auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
      }
    end
  },
}