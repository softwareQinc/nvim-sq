-- Generic Lua functions

local M = {}

-- Merge 2 Lua tables
function M.merge_tables(table1, table2)
   local merged_table = {}
   if table1 then
      for key, value in pairs(table1) do
         merged_table[key] = value
      end
   end
   if table2 then
      for key, value in pairs(table2) do
         merged_table[key] = value
      end
   end
   return merged_table
end

-- Map keys for single non-plugin sub-table
function M.map_keys(tbl, additional_options)
   for mode, key_bindings in pairs(tbl) do
      if mode ~= "n" and mode ~= "i" and mode ~= "v" then
         goto continue
      end
      for key, cmd in pairs(key_bindings) do
         local binding = cmd[1]
         local options = cmd[2]
         local all_options = M.merge_tables(options, additional_options)
         vim.keymap.set(mode, key, binding, all_options)
      end
      ::continue::
   end
end

-- Map keys for all sub-tables in the mappings table
function M.map_all_keys(tbl, additional_options)
   for _, v in pairs(tbl) do
      -- Key binding tables that contain 'plugin = true' are skipped
      -- Key bindings are buffer-local and are done in the plugin config file
      if v.plugin and v.plugin == true then
         goto continue
      end
      M.map_keys(v, additional_options)
      ::continue::
   end
end

-- Set Vim options
function M.set_options(options)
   for scope, settings in pairs(options) do
      for key, value in pairs(settings) do
         vim[scope][key] = value
      end
   end
end

-- Format on save
function M.format_on_save(augroup)
   return function(client, bufnr)
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
end

return M
