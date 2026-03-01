---@type LazyPluginSpec
return {
   "nvim-neorg/neorg",
   -- TODO: Revisit when Tree-sitter supports the norg parser
   enabled = false,
   ft = "norg",
   version = "*", -- pin Neorg to the latest stable release
   opts = {
      load = {
         ["core.defaults"] = {},
         ["core.concealer"] = {},
         ["core.dirman"] = {
            config = {
               workspaces = {
                  notes = vim.fs.normalize("~/notes/neorg"),
               },
               default_workspace = "notes",
            },
         },
      },
   },
   init = function()
      local grp = vim.api.nvim_create_augroup("Neorg", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
         group = grp,
         pattern = { "*.norg" },
         callback = function()
            vim.opt_local.conceallevel = 2
            vim.opt_local.foldlevel = 99
         end,
         desc = "Set conceallevel=2 and foldlevel=99 for Neorg buffers",
      })
   end,
}
