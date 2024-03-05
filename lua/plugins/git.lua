return {
   {
      "tpope/vim-fugitive",
      event = { "BufReadPost", "BufNewFile" },
   },
   {
      "kdheepak/lazygit.nvim",
      event = { "BufReadPost", "BufNewFile" },
      -- optional for floating window border decoration
      dependencies = {
         "nvim-lua/plenary.nvim",
      },
   },
   {
      "lewis6991/gitsigns.nvim",
      event = { "BufReadPost", "BufNewFile" },
   },
}
