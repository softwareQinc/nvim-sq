---@type LazyPluginSpec
return {
   -- Automatic configuration of language servers
   "neovim/nvim-lspconfig",
   config = function()
      local keymaps = require("core.keymaps")
      local util = require("core.util")

      -- Apply enhanced completion capabilities (`cmp-nvim-lsp`) to all servers
      vim.lsp.config("*", {
         capabilities = vim.tbl_deep_extend(
            "force",
            vim.lsp.protocol.make_client_capabilities(),
            require("cmp_nvim_lsp").default_capabilities()
         ),
      })

      -- Enable all servers automatically discovered from `after/lsp`
      for _, server in ipairs(util.get_lsp_server_names()) do
         vim.lsp.enable(server)
      end

      -- Additional settings
      local lsp_attach_grp =
         vim.api.nvim_create_augroup("NvimLspAttach", { clear = true })
      local lsp_format_grp =
         vim.api.nvim_create_augroup("NvimLspFormatOnSave", { clear = true })
      local lsp_format_on_save = util.format_on_save(lsp_format_grp)
      vim.api.nvim_create_autocmd("LspAttach", {
         group = lsp_attach_grp,
         desc = "Configure nvim-lspconfig",
         callback =
            ---@param ev vim.api.keyset.create_autocmd.callback_args
            function(ev)
               local client = vim.lsp.get_client_by_id(ev.data.client_id)
               if not client then
                  return
               end

               -- Disable semantic token highlighting for lua_ls
               if client and client.name and client.name == "lua_ls" then
                  client.server_capabilities.semanticTokensProvider = nil
               end

               -- Enable completion triggered by <c-x><c-o>
               vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

               -- Enable format on save
               lsp_format_on_save(client, ev.buf)

               -- Buffer-local keymaps
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
      })
   end,
}
