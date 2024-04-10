return {
   "stevearc/oil.nvim",
   cmd = { "Oil" },
   config = function()
      require("oil").setup({
         silence_scp_warning = true, -- disable scp warnings
         default_file_explorer = false, -- do not disable Netrw
      })
   end,
   -- Optional dependencies
   dependencies = { "nvim-tree/nvim-web-devicons" },
}
