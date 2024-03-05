return {
   "nvimtools/none-ls.nvim",
   enabled = false,
   event = "VeryLazy",
   opts = function()
      local null_ls = require("null-ls")
      local augroup = vim.api.nvim_create_augroup("NullLsFormatting", {})
      local null_ls_format_on_save = function(client, bufnr)
         if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({
               group = augroup,
               buffer = bufnr,
            })
            vim.api.nvim_create_autocmd("BufWritePre", {
               group = augroup,
               buffer = bufnr,
               callback = function()
                  vim.lsp.buf.format({ bufnr = bufnr })
               end,
            })
         end
      end

      local opts = {
         sources = {
            null_ls.builtins.formatting.black,
            null_ls.builtins.formatting.stylua,
            null_ls.builtins.formatting.gofumpt,
            null_ls.builtins.formatting.goimports_reviser,
            null_ls.builtins.formatting.golines,
            null_ls.builtins.formatting.cmake_format,
            null_ls.builtins.formatting.latexindent.with({
               args = { "-m", "-l" },
               filetypes = { "tex", "plaintex" },
               format = "sync",
            }),
            null_ls.builtins.formatting.shfmt.with({
               args = { "-i", "4", "-ci", "-s" },
               filetypes = { "sh", "zsh" },
               format = "sync",
            }),
            null_ls.builtins.formatting.prettier.with({
               filetypes = {
                  "typescript",
                  "css",
                  "scss",
                  "html",
                  "json",
                  "yaml",
                  "markdown",
                  "graphql",
                  "md",
                  "julia",
               },
            }),
            null_ls.builtins.diagnostics.ruff,
            null_ls.builtins.diagnostics.shellcheck.with({ filetypes = { "sh", "zsh" } }),
            null_ls.builtins.diagnostics.cmake_lint,
            null_ls.builtins.diagnostics.mypy.with({
               extra_args = function()
                  local virtual = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX") or "/usr"
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
