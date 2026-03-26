---@type LazySpec
return {
   -- Automatic configuration of language servers
   "neovim/nvim-lspconfig",
   event = "LspAttach",
   config = function()
      local util = require("core.util")
      local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()

      local augroup =
         vim.api.nvim_create_augroup("LSP-formatting", { clear = true })
      local lsp_format_on_save = util.format_on_save(augroup)

      -- TODO: Migrate to the native Neovim 0.11+ LSP autocompletion
      lsp_capabilities = vim.tbl_deep_extend(
         "force",
         lsp_capabilities,
         require("cmp_nvim_lsp").default_capabilities()
      )

      -- Global defaults
      local server_configs = util.discover_lsp_servers()
      for _, entry in ipairs(server_configs) do
         local server = entry[1]
         local config = entry[2]
         config.capabilities = lsp_capabilities
         config.on_attach = lsp_format_on_save
         vim.lsp.config(server, config)
         vim.lsp.enable(server)
      end

      -- Additional settings
      local lsp_group =
         vim.api.nvim_create_augroup("Nvim-lspconfig", { clear = true })
      vim.api.nvim_create_autocmd("LspAttach", {
         group = lsp_group,
         callback =
            ---@param ev vim.api.keyset.create_autocmd.callback_args
            function(ev)
               -- Disable semantic token highlighting for lua_ls
               local client = vim.lsp.get_client_by_id(ev.data.client_id)
               if client and client.name and client.name == "lua_ls" then
                  client.server_capabilities.semanticTokensProvider = nil
               end

               -- Enable completion triggered by <c-x><c-o>
               vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

               -- Buffer-local keymaps
               local keymaps = require("core.keymaps")
               util.map_keys(keymaps.nvim_lspconfig, { buffer = ev.buf })

               -- Inlay hints policy (buffer overrides global)
               if vim.lsp.inlay_hint then
                  local bufnr = ev.buf
                  if vim.b[bufnr].inlay_hints_enabled ~= nil then
                     -- Buffer override wins (even if false)
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
         desc = "Keymaps nvim-lspconfig (buffer-local)",
      })
   end,
}
