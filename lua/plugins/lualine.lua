return {
   "nvim-lualine/lualine.nvim",
   event = "VeryLazy",
   dependencies = { "nvim-tree/nvim-web-devicons" },
   config = function()
      require("lualine").setup({
         sections = {
            lualine_a = {
               "mode",
               -- Display trailing whitespaces
               function()
                  local space = vim.fn.search([[\s\+$]], "nwc")
                  return space ~= 0 and "TW:" .. space or ""
               end,
            },
            lualine_x = {
               "encoding",
               {
                  "fileformat",
                  icons_enabled = true,
                  symbols = {
                     unix = "UNIX", -- LF
                     dos = "DOS", -- CRLF
                     mac = "Mac", -- CR
                  },
                  -- symbols = {
                  --    unix = "", -- e712
                  --    dos = "", -- e70f
                  --    mac = "", -- e711
                  -- },
               },
               "filetype",
            },
         },
      })
   end,
}
