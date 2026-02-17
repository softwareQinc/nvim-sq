---@type LazyPluginSpec
return {
   "stevearc/oil.nvim",
   cmd = { "Oil" },
   opts = {
      silence_scp_warning = true, -- disable scp warnings
      default_file_explorer = false, -- do not disable Netrw
      view_options = {
         show_hidden = true,
      },
   },
   -- Optional dependencies
   dependencies = { "nvim-tree/nvim-web-devicons" },
}
