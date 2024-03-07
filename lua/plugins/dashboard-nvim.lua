return {
   "nvimdev/dashboard-nvim",
   event = "VimEnter",
   config = function()
      require("dashboard").setup({
         theme = "hyper",
         config = {
            week_header = {
               enable = true,
            },
            shortcut = {
               {
                  desc = "𝌦 Buffer",
                  group = "Number",
                  action = "bd",
                  key = "<ESC>",
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
      })
   end,
   dependencies = { { "nvim-tree/nvim-web-devicons" } },
}
