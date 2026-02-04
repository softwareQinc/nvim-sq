return {
   "folke/zen-mode.nvim",
   cmd = "ZenMode",
   opts = {
      window = {
         height = 0.8,
         width = 0.7,
         options = {
            signcolumn = "no", -- disable signcolumn
            number = false, -- disable number column
            relativenumber = false, -- disable relative numbers
            cursorline = false, -- disable cursorline
            -- cursorcolumn = false, -- disable cursor column
            -- foldcolumn = "0", -- disable fold column
            -- list = false, -- disable whitespace characters
         },
      },
   },
}
