-- BUG: see https://github.com/norcalli/nvim-colorizer.lua/issues/61
return {
   "norcalli/nvim-colorizer.lua",
   event = { "BufReadPost", "BufNewFile" },
   -- Do not replace with config = true, does not work in this case!
   config = function()
      require("colorizer").setup()
   end,
}
