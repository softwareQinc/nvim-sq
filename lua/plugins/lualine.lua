return {
   "nvim-lualine/lualine.nvim",
   event = "VeryLazy",
   dependencies = { "nvim-tree/nvim-web-devicons" },
   opts = {
      sections = {
         lualine_a = {
            "mode",
            -- Display trailing whitespaces
            function()
               local ft = vim.bo.filetype
               local bt = vim.bo.buftype
               -- Do not display trailing whitespaces if any of those clauses
               -- are true
               local no_show = (ft == "")
                  or (ft == "dashboard")
                  or (bt == "nofile")
               if no_show then
                  return ""
               end
               local space = vim.fn.search([[\s\+$]], "nwc")
               return space ~= 0 and "TW:" .. space or ""
            end,
         },
         lualine_x = {
            "encoding",
            -- No EOL indicator
            function()
               if vim.bo.eol == false then
                  return "!EOL"
               end
               return ""
            end,
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
   },
}
