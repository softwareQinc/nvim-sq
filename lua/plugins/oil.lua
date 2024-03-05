return {
   "stevearc/oil.nvim",
   enabled = false,
   cmd = "Oil",
   config = function()
      require("oil").setup({ silence_scp_warning = true })
   end,
   -- optional dependencies
   dependencies = { "nvim-tree/nvim-web-devicons" },
}
