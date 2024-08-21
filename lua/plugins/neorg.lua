return {
   "nvim-neorg/neorg",
   ft = "norg",
   dependencies = { "vhyrro/luarocks.nvim" },
   version = "*", -- pin Neorg to the latest stable release
   opts = {
      load = {
         ["core.defaults"] = {},
         ["core.concealer"] = {},
         ["core.dirman"] = {
            config = {
               workspaces = {
                  notes = "~/norg_notes",
               },
               default_workspace = "notes",
            },
         },
      },
   },
   init = function()
      vim.wo.foldlevel = 99
      vim.wo.conceallevel = 2
   end,
}
