return {
   "nvim-neorg/neorg",
   ft = "norg",
   dependencies = { "nvim-neorg/luarocks.nvim" },
   config = function()
      require("neorg").setup({
         load = {
            ["core.defaults"] = {},
            ["core.concealer"] = {},
            ["core.dirman"] = {
               config = {
                  workspaces = {
                     notes = "~/notes",
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
