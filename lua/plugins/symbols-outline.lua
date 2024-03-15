return {
   "simrat39/symbols-outline.nvim",
   enabled = false, -- archived
   event = "LspAttach",
   config = function()
      require("symbols-outline").setup()
   end,
}
