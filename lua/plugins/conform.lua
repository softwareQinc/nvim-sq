return {
   "stevearc/conform.nvim",
   config = function()
      local state = require("core.state")
      require("conform").setup({
         formatters_by_ft = {
            cmake = { "cmakelang" },
            go = { "gofumpt", "goimports-reviser" },
            javascript = { "prettier" },
            json = { "prettier" },
            lua = { "stylua" },
            markdown = { "prettier" },
            python = { "black" },
            sh = { "shfmt" },
            typescript = { "prettier" },
         },
         format_on_save = function(bufnr)
            local enabled = vim.b[bufnr].lsp_format_on_save_current_buffer
            if enabled == false then
               return nil
            end
            if not state.lsp_format_on_save_enabled_at_startup then
               return nil
            end
            if
               enabled == true or state.lsp_format_on_save_enabled_at_startup
            then
               return { timeout_ms = 500, lsp_format = "fallback" }
            end
         end,
      })
   end,
}
