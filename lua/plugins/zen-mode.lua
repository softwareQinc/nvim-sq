---@type LazyPluginSpec
return {
   "folke/zen-mode.nvim",
   cmd = "ZenMode",
   opts = {
      window = {
         height = 0.8,
         width = 0.7,
         options = {
            cursorline = false, -- disable cursorline
            cursorcolumn = false, -- disable cursor column
            foldcolumn = "0", -- disable fold column
            list = false, -- disable whitespace characters
            number = false, -- disable number column
            relativenumber = false, -- disable relative numbers
            signcolumn = "no", -- disable signcolumn
            spell = false,
         },
      },
      on_open = function()
         -- Disable `blink.cmp` completion
         vim.b.completion = false
         -- Disable `vim-illuminate`
         local ok, illuminate = pcall(require, "illuminate")
         if ok then
            illuminate.pause()
         end
      end,
      on_close = function()
         -- Re-enable `blink.cmp` completion
         vim.b.completion = true
         -- Re-enable `vim-illuminate`
         local ok, illuminate = pcall(require, "illuminate")
         if ok then
            illuminate.resume()
         end
      end,
   },
}
