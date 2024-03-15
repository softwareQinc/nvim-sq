return {
   "folke/trouble.nvim",
   event = "LspAttach",
   dependencies = { "nvim-tree/nvim-web-devicons" },
   config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
         group = vim.api.nvim_create_augroup("Trouble", { clear = true }),
         callback = function(ev)
            -- Buffer local keymaps
            local keymaps = require("core.keymaps")
            local util = require("core.util")
            util.map_keys(keymaps.trouble, { buffer = ev.buf })
         end,
         desc = "Keymaps Trouble (buffer local)",
      })
   end,
}
