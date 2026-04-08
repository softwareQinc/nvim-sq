return {
   "mfussenegger/nvim-lint",
   event = "BufReadPost",
   config = function()
      require("lint").linters_by_ft = {
         cmake = { "cmakelint" },
         python = { "mypy" },
         bash = { "shellcheck" },
      }
      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
         group = vim.api.nvim_create_augroup("Nvim-lint", { clear = true }),
         desc = "Configure nvim-lint",
         callback = function()
            -- try_lint without arguments runs the linters defined in `linters_by_ft`
            -- for the current filetype
            require("lint").try_lint()
            -- You can call `try_lint` with a linter name or a list of names to always
            -- run specific linters, independent of the `linters_by_ft` configuration
            -- require("lint").try_lint("cspell")
         end,
      })
   end,
}
