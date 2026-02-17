---@type LazySpec
return {
   -- Full-featured Git integration and :Git command inside Neovim
   {
      "tpope/vim-fugitive",
      cmd = { "Git" },
   },

   -- Open Lazygit TUI from Neovim
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

   -- Git change signs, blame, and hunk actions in the gutter
   {
      "lewis6991/gitsigns.nvim",
      event = { "BufReadPost", "BufNewFile" },
      config = true,
   },
}
