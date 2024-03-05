return {
   "folke/todo-comments.nvim",
   event = { "BufReadPost", "BufNewFile" },
   dependencies = { "nvim-lua/plenary.nvim" },
   config = function()
      require("todo-comments").setup({})
   end,
}
