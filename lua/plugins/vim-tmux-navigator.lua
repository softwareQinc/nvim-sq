---@type LazyPluginSpec
return {
   "christoomey/vim-tmux-navigator",
   cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
   },
   init = function()
      -- Use custom keymaps instead of the plugin's defaults
      -- See `lua/core/keymaps.lua`
      vim.g.tmux_navigator_no_mappings = 1
   end,
}
