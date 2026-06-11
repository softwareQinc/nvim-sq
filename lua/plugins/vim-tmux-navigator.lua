---@type LazyPluginSpec
return {
   "christoomey/vim-tmux-navigator",
   event = "VeryLazy",
   init = function()
      vim.g.tmux_navigator_no_mappings = 1
   end,
}
