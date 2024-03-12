return {
   -- Go tooling support
   {
      "olexsmir/gopher.nvim",
      ft = "go",
      config = function(_, opts)
         require("gopher").setup(opts)
         vim.api.nvim_create_autocmd("FileType", {
            group = vim.api.nvim_create_augroup("Gopher", {}),
            pattern = "go",
            callback = function(ev)
               -- Buffer local key bindings.
               -- See `:help vim.lsp.*` for documentation on any of the below util
               local bindings = require("core.bindings")
               local util = require("core.util")
               util.map_keys(bindings.go, { buffer = ev.buf })
            end,
         })
      end,
      build = function()
         -- vim.cmd [[silent! GoInstallDeps]]
         vim.api.nvim_cmd({ cmd = "GoInstallDeps" }, { output = false })
      end,
   },
}
