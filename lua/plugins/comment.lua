---@type LazyPluginSpec
return {
   "numToStr/Comment.nvim",
   event = { "BufReadPost", "BufNewFile" },
   opts = {}, -- lazy.nvim implicitly calls `setup({})`
}
