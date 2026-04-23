---@type LazySpec
return {
   -- External tool manager (language servers, DAP adapters, linters, formatters)
   {
      "mason-org/mason.nvim",
      event = "VeryLazy",
      config = function()
         local formatters = {
            "black", -- Python
            "cmakelang", -- CMake
            "gofumpt", -- Go
            "goimports", -- Go
            "golines", -- Go
            "latexindent", -- Latex
            "prettier", -- Multiple languages
            "shfmt", -- Bash/sh
            "stylua", -- Lua
         }
         local linters = {
            "cmakelint", -- CMake
            "mypy", -- Python
            "shellcheck", -- Bash/sh
         }

         --- Ensures the given Mason packages are installed, installing any missing ones asynchronously
         ---@param tools string[]  -- List of Mason package names to ensure installed
         local function ensure_mason_tools_installed(tools)
            local mr = require("mason-registry")
            mr.refresh(function()
               for _, tool in ipairs(tools) do
                  local ok, pkg = pcall(mr.get_package, tool)
                  if ok and not pkg:is_installed() then
                     pkg:install()
                  end
               end
            end)
         end

         require("mason").setup({
            ui = { border = "rounded" },
         })

         ensure_mason_tools_installed(formatters)
         ensure_mason_tools_installed(linters)
      end,
   },

   -- Mason bridge for `nvim-lspconfig`, auto-installs language servers
   {
      "mason-org/mason-lspconfig.nvim",
      dependencies = { "mason-org/mason.nvim" },
      event = "VeryLazy",
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
}
