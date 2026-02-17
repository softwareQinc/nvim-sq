---@type LazyPluginSpec
return {
   "nvimtools/none-ls.nvim",
   event = "VeryLazy",
   dependencies = {
      -- "nvimtools/none-ls-extras.nvim",
   },
   opts = function()
      local null_ls = require("null-ls")
      local util = require("core.util")
      local grp =
         vim.api.nvim_create_augroup("None-ls-formatting", { clear = true })
      local null_ls_format_on_save = util.format_on_save(grp)

      local opts = {
         sources = {
            -- Formatting
            null_ls.builtins.formatting.black,
            null_ls.builtins.formatting.cmake_format,
            null_ls.builtins.formatting.gofumpt,
            null_ls.builtins.formatting.goimports_reviser,
            null_ls.builtins.formatting.golines,
            null_ls.builtins.formatting.prettier.with({
               filetypes = {
                  "css",
                  "graphql",
                  "html",
                  "json",
                  "json5",
                  "julia",
                  "markdown",
                  "md",
                  "scss",
               },
            }),
            null_ls.builtins.formatting.shfmt.with({
               args = { "-i", "4", "-ci", "-s" },
               filetypes = { "sh", "zsh" },
               format = "sync",
            }),
            null_ls.builtins.formatting.stylua,

            -- Diagnostics
            -- CMake
            null_ls.builtins.diagnostics.cmake_lint,
            -- Python
            null_ls.builtins.diagnostics.mypy.with({
               extra_args = function()
                  local virtual = os.getenv("VIRTUAL_ENV")
                     or os.getenv("CONDA_PREFIX")
                     or "/usr"
                  return { "--python-executable", virtual .. "/bin/python3" }
               end,
            }),
         },

         -- Auto format on save
         on_attach = null_ls_format_on_save,
      }

      return opts
   end,
}
