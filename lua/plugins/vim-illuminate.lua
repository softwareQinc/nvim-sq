---@type LazyPluginSpec
return {
   "RRethy/vim-illuminate",
   event = { "BufReadPost", "BufNewFile" },
   config = function()
      -- Default configuration
      require("illuminate").configure({
         -- Enable illuminating under cursor (true by default)
         under_cursor = true,
         -- Disable vim-illuminate in Visual modes
         modes_denylist = { "v", "vs", "V", "Vs", "", "s" },
      })
      local api = vim.api
      --- Set highlight groups
      local function set_illumintate_hl()
         -- Use Visual instead of CursorLine for more accentuated highlighting,
         -- or comment the lines below for illuminating only (no highlighting)
         api.nvim_set_hl(0, "IlluminatedWordText", { link = "CursorLine" })
         api.nvim_set_hl(0, "IlluminatedWordRead", { link = "CursorLine" })
         api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "CursorLine" })
      end
      set_illumintate_hl()
      -- Auto update the highlight style when the color scheme changes
      api.nvim_create_autocmd("ColorScheme", {
         group = vim.api.nvim_create_augroup(
            "Vim-illuminate",
            { clear = true }
         ),
         pattern = { "*" },
         callback = set_illumintate_hl,
         desc = "Auto update the highlight style when the color scheme changes (vim-illuminate)",
      })
   end,
}
