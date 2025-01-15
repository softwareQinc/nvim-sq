return {
   {
      "tpope/vim-fugitive",
      cmd = { "Git" },
   },
   {
      "kdheepak/lazygit.nvim",
      cmd = {
         "LazyGit",
         "LazyGitConfig",
         "LazyGitCurrentFile",
         "LazyGitFilter",
         "LazyGitFilterCurrentFile",
      },
      -- Optional for floating window border decoration
      dependencies = { "nvim-lua/plenary.nvim" },
   },
   {
      "lewis6991/gitsigns.nvim",
      event = { "BufReadPost", "BufNewFile" },
      config = true,
   },
}
