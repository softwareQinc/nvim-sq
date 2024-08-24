return {
   -- Haskell language support
   "mrcjkb/haskell-tools.nvim",
   version = "^3", -- recommended
   ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
   lazy = true,
   config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
         group = vim.api.nvim_create_augroup("Haskell-tools", { clear = true }),
         callback = function(ev)
            -- Buffer local keymaps
            local keymaps = require("core.keymaps")
            local util = require("core.util")
            util.map_keys(keymaps.haskell_tools, { buffer = ev.buf })
         end,
         desc = "Keymaps haskell-tools (buffer local)",
      })
   end,
}
