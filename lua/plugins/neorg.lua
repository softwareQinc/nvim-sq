return {
   "nvim-neorg/neorg",
   ft = "norg",
   dependencies = { "vhyrro/luarocks.nvim" },
   version = "*", -- pin Neorg to the latest stable release
   config = function()
      require("neorg").setup({
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
      })
      vim.wo.foldlevel = 99
      vim.wo.conceallevel = 2
   end,
}
