return {
   {
      "catppuccin/nvim",
      lazy = true,
      name = "catppuccin",
      priority = 1000,
   },
   {
      "ellisonleao/gruvbox.nvim",
      lazy = true,
      priority = 1000,
   },
   {
      "rebelot/kanagawa.nvim",
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
      config = function()
         require("vscode").setup({
            -- Enable italic comment
            italic_comments = true,
         })
      end,
   },
}
