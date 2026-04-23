---@type LazyPluginSpec
return {
   -- Go tooling support
   "olexsmir/gopher.nvim",
   ft = "go",
   config =
      ---@param _ LazyPlugin
      ---@param opts table
      function(_, opts)
         require("gopher").setup(opts)
         local grp = vim.api.nvim_create_augroup("Gopher", { clear = true })
         vim.api.nvim_create_autocmd("FileType", {
            group = grp,
            pattern = { "go" },
            desc = "Keymaps gopher (buffer-local)",
            callback =
               ---@param ev vim.api.keyset.create_autocmd.callback_args
               function(ev)
                  -- Buffer-local keymaps
                  local keymaps = require("core.keymaps")
                  local util = require("core.util")
                  util.map_keys(keymaps.go, { buffer = ev.buf })
               end,
         })
      end,
   build = function()
      pcall(vim.api.nvim_cmd, { cmd = "GoInstallDeps" }, { output = false })
   end,
}
