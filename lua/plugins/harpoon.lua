return {
   "ThePrimeagen/harpoon",
   event = "VeryLazy",
   branch = "harpoon2",
   dependencies = { "nvim-lua/plenary.nvim" },
   config = function()
      require("harpoon").setup()
   end,
}
