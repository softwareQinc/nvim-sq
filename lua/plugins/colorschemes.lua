return {
   {
      "catppuccin/nvim",
      lazy = true,
      name = "catppuccin",
      priority = 1000,
   },
   {
      "sainnhe/everforest",
      lazy = true,
      priority = 1000,
      config = function()
         -- Set contrast ("hard/medium/soft")
         vim.g.everforest_background = "hard"
      end,
   },
   {
      "sainnhe/gruvbox-material",
      lazy = true,
      priority = 1000,
      config = function()
         -- Set contrast ("hard/medium/soft")
         vim.g.gruvbox_material_background = "medium"
      end,
   },
   {
      "ellisonleao/gruvbox.nvim",
      lazy = true,
      priority = 1000,
      --- Fixes https://github.com/nvim-lualine/lualine.nvim/issues/1312
      opts = {
         inverse = false,
      },
   },
   {
      "rebelot/kanagawa.nvim",
      lazy = true,
      priority = 1000,
      opts = {
         -- Remove the background of LineNr, {Sign,Fold}Column and friends
         colors = {
            theme = {
               all = {
                  ui = {
                     bg_gutter = "none",
                  },
               },
            },
         },
      },
   },
   {
      "rose-pine/neovim",
      name = "rose-pine",
      lazy = true,
      priority = 1000,
   },
   {
      "folke/tokyonight.nvim",
      lazy = true,
      priority = 1000,
   },
   {
      "Mofiqul/vscode.nvim",
      lazy = true,
      priority = 1000,
      opts = {
         -- Enable italic comment
         italic_comments = true,
      },
   },
}
