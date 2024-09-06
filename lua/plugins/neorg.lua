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
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
         group = vim.api.nvim_create_augroup("Neorg", { clear = true }),
         pattern = { "*.norg" },
         command = "setlocal conceallevel=2 foldlevel=99",
         desc = "Set conceallevel=2 and foldlevel=99 for Neorg buffers",
      })
   end,
}
