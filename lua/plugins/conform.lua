---@type LazyPluginSpec
return {
   "stevearc/conform.nvim",
   event = { "BufReadPost", "BufNewFile" },
   config = function()
      local state = require("core.state")
      require("conform").setup({
         formatters_by_ft = {
            cmake = { "cmake_format" },
            go = { "golines", "gofumpt", "goimports" },
            javascript = { "prettier" },
            json = { "prettier" },
            lua = { "stylua" },
            markdown = { "prettier" },
            python = { "black" },
            sh = { "shfmt" },
            typescript = { "prettier" },
         },
         ---@param bufnr integer Buffer number
         ---@return table|nil conform.FormatOpts|nil
         format_on_save = function(bufnr)
            -- Buffer-local override (true/false) has highest priority
            -- nil -> inherit global setting
            local enabled = vim.b[bufnr].format_on_save_current_buffer

            -- No buffer override -> use global toggle
            if enabled == nil then
               enabled = state.format_on_save_enabled_at_startup
            end

            -- If formatting is disabled (buffer or global), skip
            if not enabled then
               return
            end

            -- Conform format options: synchronous formatting with a timeout,
            -- falling back to LSP if no formatter is available
            return {
               async = false,
               timeout_ms = 500,
               lsp_format = "fallback",
            }
         end,
      })
   end,
}
