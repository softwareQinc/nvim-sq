---@type LazyPluginSpec
return {
   -- Haskell tooling support
   "mrcjkb/haskell-tools.nvim",
   version = "*",
   ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
   lazy = true,
   config = function()
      local grp = vim.api.nvim_create_augroup("Haskell-tools", { clear = true })
      vim.api.nvim_create_autocmd("LspAttach", {
         group = grp,
         callback =
            ---@param ev vim.api.keyset.create_autocmd.callback_args
            function(ev)
               -- Buffer-local keymaps
               local keymaps = require("core.keymaps")
               local util = require("core.util")
               util.map_keys(keymaps.haskell_tools, { buffer = ev.buf })
               require("telescope").load_extension("ht")
            end,
         desc = "Keymaps haskell-tools (buffer-local)",
      })
   end,
}
