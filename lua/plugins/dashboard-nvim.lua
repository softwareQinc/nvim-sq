return {
   "nvimdev/dashboard-nvim",
   event = "VimEnter",
   dependencies = { { "nvim-tree/nvim-web-devicons" } },
   opts = {
      theme = "hyper",
      config = {
         week_header = {
            enable = true,
         },
         shortcut = {
            {
               desc = "𝌦 Buffer",
               group = "Number",
               action = function()
                  local util = require("core.util")
                  util.smart_bd()
               end,
               key = "q",
            },
            {
               desc = " Files",
               group = "Label",
               action = "Telescope find_files",
               key = "f",
            },
            {
               desc = "󰊳 Update",
               group = "@property",
               action = "Lazy update",
               key = "u",
            },
         },
         project = { enable = true, limit = 5 },
         mru = { enable = true, limit = 7 },
         footer = { "", "softwareQ Inc.", "Designing Quantum Software" },
      },
      hide = {
         statusline = false,
      },
   },
}
