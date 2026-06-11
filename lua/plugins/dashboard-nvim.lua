---@type LazyPluginSpec
return {
   "nvimdev/dashboard-nvim",
   dependencies = { "nvim-tree/nvim-web-devicons" },
   event = "VimEnter",
   cmd = "Dashboard",
   config = function()
      local opts = {
         theme = "hyper",
         config = {
            week_header = {
               enable = true,
            },
            shortcut = {
               {
                  desc = " Buffer",
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
      }
      vim.opt.shortmess:append("I") -- disable Neovim welcome message
      require("dashboard").setup(opts)
      -- Hide end-of-buffer `~` markers in the Dashboard buffer to avoid a
      -- brief flash on startup
      vim.api.nvim_create_autocmd("FileType", {
         pattern = "dashboard",
         callback = function()
            vim.opt_local.fillchars:append({
               eob = " ",
            })
         end,
      })
   end,
}
