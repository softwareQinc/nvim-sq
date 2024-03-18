return {
   "RRethy/vim-illuminate",
   event = { "BufReadPost", "BufNewFile" },
   config = function()
      -- default configuration
      require("illuminate").configure({
         under_cursor = false,
      })
      local api = vim.api
      -- vim-illuminate plugin
      -- Change the highlight style
      local function set_illumintate_hl()
         api.nvim_set_hl(0, "IlluminatedWordText", { link = "Visual" })
         api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" })
         api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Visual" })
      end
      set_illumintate_hl()
      -- Auto update the highlight style on colorscheme change
      api.nvim_create_autocmd({ "ColorScheme" }, {
         group = vim.api.nvim_create_augroup("Vim-illuminate", { clear = true }),
         pattern = { "*" },
         callback = set_illumintate_hl,
         desc = "Auto update the highlight style on coloscheme change (vim-illuminate)",
      })
   end,
}
