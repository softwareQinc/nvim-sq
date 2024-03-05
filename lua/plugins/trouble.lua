return {
   "folke/trouble.nvim",
   event = "LspAttach",
   dependencies = { "nvim-tree/nvim-web-devicons" },
   config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
         group = vim.api.nvim_create_augroup("Trouble", { clear = true }),
         callback = function(ev)
            -- Buffer local mappings.
            -- See `:help vim.lsp.*` for documentation on any of the below util
            local bindings = require("core.bindings")
            local util = require("core.util")
            util.map_keys(bindings.trouble, { buffer = ev.buf })
         end,
      })
   end,
}
