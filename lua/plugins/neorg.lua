---@type LazyPluginSpec
return {
   "nvim-neorg/neorg",
   dependencies = { "nvim-neorg/tree-sitter-norg" },
   ft = "norg",
   opts = {
      load = {
         ["core.defaults"] = {},
         ["core.concealer"] = {},
         ["core.dirman"] = {
            config = {
               workspaces = {
                  notes = require("core.util").resolve_path("~/notes/neorg"),
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
         desc = "Set conceallevel=2 and foldlevel=99 for Neorg buffers",
         callback = function()
            vim.opt_local.conceallevel = 2
            vim.opt_local.foldlevel = 99
         end,
      })
   end,
}
