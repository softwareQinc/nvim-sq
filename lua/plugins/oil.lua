return {
   "stevearc/oil.nvim",
   cmd = { "Oil" },
   config = function()
      require("oil").setup({
         silence_scp_warning = true, -- disable scp warnings
         default_file_explorer = false, -- do not disable Netrw
         view_options = {
            show_hidden = true,
         },
      })
   end,
   -- Optional dependencies
   dependencies = { "nvim-tree/nvim-web-devicons" },
}
