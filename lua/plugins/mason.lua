---@type LazySpec
return {
   -- External tool manager (language servers, DAP adapters, linters, formatters)
   {
      "mason-org/mason.nvim",
      cmd = { "Mason", "MasonInstall", "MasonUpdate" },
      opts = {},
   },

   -- Mason bridge for `nvim-lspconfig`, auto-installs language servers
   {
      "mason-org/mason-lspconfig.nvim",
      dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" },
      opts = function()
         -- Language servers are automatically installed from `after/lsp`
         -- and configured via `nvim-lspconfig` in
         -- `lua/plugins/nvim-lspconfig.lua`
         local servers = require("core.util").get_lsp_server_names()
         return {
            ensure_installed = servers,
            automatic_enable = false, -- enabling is handled by `nvim-lspconfig`
         }
      end,
   },

   -- Mason bridge for `none-ls` sources (linters and formatters),
   -- auto-installs and enables formatters and linters. Additional custom
   -- configurations are defined in `lua/plugins/none-ls.lua`.
   {
      "jay-babu/mason-null-ls.nvim",
      dependencies = { "mason-org/mason.nvim", "nvimtools/none-ls.nvim" },
      opts = {
         ensure_installed = {
            -- Formatters
            "black", -- Python
            "gofumpt", -- Go
            "goimports-reviser", -- Go
            "golines", -- Go
            "latexindent", -- Latex
            "prettier", -- Multiple languages
            "shfmt", -- Bash/sh
            "stylua", -- Lua

            -- Linters
            "cmakelang", -- CMake
            "cmakelint", -- CMake
            "mypy", -- Python
            "shellcheck", -- Bash/sh
         },
      },
   },
}
