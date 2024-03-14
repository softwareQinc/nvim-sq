return {
   -- Haskell language support
   {
      "mrcjkb/haskell-tools.nvim",
      version = "^3", -- Recommended
      ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
      lazy = true,
      config = function()
         vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("HaskellTools", { clear = true }),
            callback = function(ev)
               -- Buffer local keymaps.
               -- See `:help vim.lsp.*` for documentation on any of the below util
               local keymaps = require("core.keymaps")
               local util = require("core.util")
               util.map_keys(keymaps.haskell_tools, { buffer = ev.buf })
            end,
            desc = "Keymaps haskell-tools (buffer local)",
         })
      end,
   },
}
