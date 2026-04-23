---@type LazyPluginSpec
return {
   -- Automatic configuration of language servers
   "neovim/nvim-lspconfig",
   dependencies = { "mason.nvim", "mason-org/mason-lspconfig.nvim" },
   event = { "BufReadPre", "BufNewFile" },
   config = function()
      local keymaps = require("core.keymaps")
      local util = require("core.util")

      -- Apply enhanced completion capabilities from `blink.cmp` to all servers
      vim.lsp.config("*", {
         capabilities = require("blink.cmp").get_lsp_capabilities(),
      })

      -- Enable all servers discovered from `after/lsp`, except those managed
      -- elsewhere
      local excluded = {
         -- Managed by rustaceanvim (see `lua/plugins/rust.lua`)
         rust_analyzer = true,
      }
      for _, server in ipairs(util.get_lsp_server_names()) do
         if not excluded[server] then
            vim.lsp.enable(server)
         end
      end

      -- Additional settings
      local grp = vim.api.nvim_create_augroup("NvimLspAttach", { clear = true })
      vim.api.nvim_create_autocmd("LspAttach", {
         group = grp,
         desc = "Configure nvim-lspconfig",
         callback =
            ---@param ev vim.api.keyset.create_autocmd.callback_args
            function(ev)
               local client = vim.lsp.get_client_by_id(ev.data.client_id)
               if not client then
                  return
               end

               -- Buffer-local keymaps
               util.map_keys(keymaps.nvim_lspconfig, { buffer = ev.buf })

               -- Disable semantic token highlighting for lua_ls
               if client.name and client.name == "lua_ls" then
                  client.server_capabilities.semanticTokensProvider = nil
               end

               -- Inlay hints policy (buffer-local overrides global)
               if vim.lsp.inlay_hint then
                  local bufnr = ev.buf
                  if vim.b[bufnr].inlay_hints_enabled ~= nil then
                     -- Buffer-local override wins (even if false)
                     vim.lsp.inlay_hint.enable(
                        vim.b[bufnr].inlay_hints_enabled,
                        { bufnr = bufnr }
                     )
                  elseif vim.g.inlay_hints_enabled ~= nil then
                     -- Apply global only if explicitly set; default stays
                     -- untouched otherwise
                     vim.lsp.inlay_hint.enable(
                        vim.g.inlay_hints_enabled == true,
                        { bufnr = bufnr }
                     )
                  end
               end
            end,
      })
   end,
}
