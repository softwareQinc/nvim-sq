---@type LazyPluginSpec
return {
   "lervag/vimtex",
   -- DO NOT lazy load, reverse search won't work
   -- Use init for configuration, don't use the more common "config", see
   -- https://github.com/lervag/vimtex?tab=readme-ov-file#installation
   init = function()
      vim.g.vimtex_view_method = "sioyek"
   end,
}
