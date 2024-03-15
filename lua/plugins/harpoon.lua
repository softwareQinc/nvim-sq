return {
   "ThePrimeagen/harpoon",
   event = "VeryLazy",
   branch = "harpoon2",
   dependencies = { "nvim-lua/plenary.nvim" },
   config = function()
      local harpoon = require("harpoon")
      harpoon:setup({})
   end,
}
