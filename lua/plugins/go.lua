return {
   -- Go tooling support
   {
      "olexsmir/gopher.nvim",
      ft = "go",
      config = function(_, opts)
         require("gopher").setup(opts)
         vim.api.nvim_create_autocmd("FileType", {
            group = vim.api.nvim_create_augroup("Gopher", { clear = true }),
            pattern = "go",
            callback = function(ev)
               -- Buffer local keymaps
               local keymaps = require("core.keymaps")
               local util = require("core.util")
               util.map_keys(keymaps.go, { buffer = ev.buf })
            end,
            desc = "Keymaps gopher (buffer local)",
         })
      end,
      build = function()
         pcall(vim.api.nvim_cmd, { cmd = "GoInstallDeps" }, { output = false })
      end,
   },
}
