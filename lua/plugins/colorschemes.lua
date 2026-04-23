---@type LazySpec
return {
   {
      "catppuccin/nvim",
      name = "catppuccin",
      priority = 1000,
   },

   {
      "sainnhe/everforest",
      priority = 1000,
      config = function()
         -- Set contrast ("hard/medium/soft")
         vim.g.everforest_background = "hard"
      end,
   },

   {
      "sainnhe/gruvbox-material",
      priority = 1000,
      config = function()
         -- Set contrast ("hard/medium/soft")
         vim.g.gruvbox_material_background = "medium"
      end,
   },

   {
      "ellisonleao/gruvbox.nvim",
      priority = 1000,
   },

   {
      "rebelot/kanagawa.nvim",
      priority = 1000,
      opts = {
         -- Remove the background of LineNr, {Sign,Fold}Column and friends
         colors = { theme = { all = { ui = { bg_gutter = "none" } } } },
      },
   },

   {
      "rose-pine/neovim",
      name = "rose-pine",
      priority = 1000,
   },

   {
      "folke/tokyonight.nvim",
      priority = 1000,
   },

   {
      "Mofiqul/vscode.nvim",
      priority = 1000,
      opts = {
         italic_comments = true,
      },
   },
}
