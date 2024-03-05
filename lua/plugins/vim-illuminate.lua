return {
   "RRethy/vim-illuminate",
   event = { "BufReadPost", "BufNewFile" },
   config = function()
      -- default configuration
      require("illuminate").configure({
         under_cursor = true,
      })
      local api = vim.api
      -- vim-illuminate plugin
      -- change the highlight style
      api.nvim_set_hl(0, "IlluminatedWordText", { link = "Visual" })
      api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" })
      api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Visual" })
      --- auto update the highlight style on colorscheme change
      api.nvim_create_autocmd({ "ColorScheme" }, {
         pattern = { "*" },
         callback = function()
            api.nvim_set_hl(0, "IlluminatedWordText", { link = "Visual" })
            api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" })
            api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Visual" })
         end,
      })
   end,
}
