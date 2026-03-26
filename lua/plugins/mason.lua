---@type LazySpec
return {
   -- External tool manager (language servers, DAP adapters, linters, formatters)
   {
      "mason-org/mason.nvim",
      cmd = { "Mason", "MasonInstall", "MasonUpdate" },
      opts = {},
   },

   -- Mason bridge for none-ls sources (linters and formatters)
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

   -- Mason bridge for nvim-lspconfig, auto-installs language servers
   {
      "mason-org/mason-lspconfig.nvim",
      dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" },
      opts = function()
         local util = require("core.util")
         local server_configs = util.discover_lsp_servers()

         local servers = vim.tbl_map(function(entry)
            return entry[1] -- server name
         end, server_configs)

         -- Do not install julials via Mason
         -- https://discourse.julialang.org/t/neovim-languageserver-jl-crashing-again/130273
         local exclude = { julials = true }

         servers = vim.tbl_filter(function(s)
            return not exclude[s]
         end, servers)

         return {
            -- Ensure automatic installation of the discovered servers
            ensure_installed = servers,
            -- Enable servers from lua/plugins/nvim-lspconfig.lua
            automatic_enable = false,
         }
      end,
   },
}
